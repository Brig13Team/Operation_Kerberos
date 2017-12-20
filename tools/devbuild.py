"""Creating Mission pbos"""
# Author: Dorbedo
#
#!/usr/bin/python3
# -*- coding: utf-8 -*-
# pylint: disable=W0702

import os
import sys
import re
import subprocess
import shutil
import platform
from distutils.dir_util import copy_tree

######## GLOBALS #########
MAINPREFIX = "x"
PREFIX = "dorb_"
MAINMISSION = "Operation_Kerberos.Altis"
##########################

def mod_time(path):
    """Returns the last modified date"""
    if not os.path.isdir(path):
        return os.path.getmtime(path)
    maxi = os.path.getmtime(path)
    for file in os.listdir(path):
        maxi = max(mod_time(os.path.join(path, file)), maxi)
    return maxi

def check_for_changes(addonspath, module, pre):
    """checks if the a pbo needs to be rebuild"""
    if not os.path.exists(os.path.join(addonspath, "{}{}.pbo".format(pre, module))):
        return True
    return mod_time(os.path.join(addonspath, module)) > mod_time(os.path.join(addonspath, \
        "{}{}.pbo".format(pre, module)))

def check_for_obsolete_pbos(addonspath, file):
    """checks if there is an obsolete pbo"""
    module = file[len(PREFIX):-4]
    if not os.path.exists(os.path.join(addonspath, module)):
        return True
    return False

def get_version(filepath):
    """update the build version"""
    versionfile = open(filepath, "r")
    hpptext = versionfile.read()
    versionfile.close()

    if hpptext:
        majortext = re.search(r"#define MAJOR (.*\b)", hpptext).group(1)
        minortext = re.search(r"#define MINOR (.*\b)", hpptext).group(1)
        patchtext = re.search(r"#define PATCHLVL (.*\b)", hpptext).group(1)
        buildtext = re.search(r"#define BUILD (.*\b)", hpptext).group(1)


        buildtext = int(buildtext) + 1

        with open(filepath, "w", newline="\n") as file:
            file.writelines([
                "#define MAJOR {}\n".format(majortext),
                "#define MINOR {}\n".format(minortext),
                "#define PATCHLVL {}\n".format(patchtext),
                "#define BUILD {}\n".format(buildtext)
            ])
        return majortext, minortext, patchtext, buildtext

def check_workdrive(path, addonspath):
    workdrivepath = os.path.normpath("{}/{}/{}/".format(path, MAINPREFIX, PREFIX.rstrip("_")))
    if not os.path.exists(workdrivepath):
        os.makedirs(workdrivepath)
    workdrivepath = os.path.normpath(workdrivepath + "/addons")
    if not os.path.exists(os.path.normpath(workdrivepath + "/main")):
        os.symlink(addonspath, workdrivepath)
    return True



def main():
    """main"""
    print("""
  #####################
  # Building Kerberos #
  #####################
""")

    scriptpath = os.path.realpath(__file__)
    projectpath = os.path.dirname(os.path.dirname(scriptpath))
    addonspath = os.path.join(projectpath, "addons")
    missionspath = os.path.join(projectpath, "missions")
    workdrivepath = os.path.normpath(projectpath + "/include"),
    temppath = os.path.join(projectpath, "temp")

    try:
        check_workdrive(workdrivepath, addonspath)
    except:
        print("The virtual workdrive could not be checked.")
        print("Please link '/addons' to 'include/{}/{}/addons'".\
            format(MAINPREFIX, PREFIX.rstrip("_")))
        print("or run this script as administrator")

    os.chdir(addonspath)

    made = 0
    failed = 0
    skipped = 0
    removed = 0

    for file in os.listdir(addonspath):
        if os.path.isfile(file):
            if check_for_obsolete_pbos(addonspath, file):
                removed += 1
                print("  Removing obsolete file => " + file)
                os.remove(file)

    if platform.system() == "Windows":
        path_armake = os.path.normpath(projectpath + "/tools/armake_w64.exe")
    else:
        path_armake = "armake"

    major, minor, patch, build = get_version(os.path.normpath(addonspath \
        + "/main/script_version.hpp"))

    print("  Version: {}.{}.{}.{}".format(major, minor, patch, build), "\n")

    print("  Creating the servermod")

    for file in os.listdir(addonspath):
        path = os.path.join(addonspath, file)
        if not os.path.isdir(path):
            continue
        if file[0] == ".":
            continue
        if not check_for_changes(addonspath, file, PREFIX):
            skipped += 1
            print("    Skipping {}{}.".format(PREFIX, file))
            continue

        print("  Making {}{} ...".format(PREFIX, file))

        try:
            command = path_armake + " build -i " + workdrivepath + \
                " -w unquoted-string -w redefinition-wo-undef -f " + \
                os.path.normpath(addonspath + "/" + file) + " " + \
                os.path.normpath(addonspath + "/" + PREFIX + file + ".pbo")
            subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)
        except:
            failed += 1
            print("    Failed to make {}{}.".format(PREFIX, file))
        else:
            made += 1
            print("    Successfully made {}{}.".format(PREFIX, file))

    print("\n  Creating the mission files")

    if os.path.exists(temppath):
        shutil.rmtree(temppath, ignore_errors=True)

    if check_for_changes(missionspath, MAINMISSION, ""):
        mainisupdated = True
        shutil.copy(os.path.normpath(addonspath + "/main/script_version.hpp"), \
            os.path.normpath(missionspath + "/" + MAINMISSION + "/main/script_version.hpp"))
    else:
        mainisupdated = False

    for file in os.listdir(missionspath):
        path = os.path.join(missionspath, file)
        if not os.path.isdir(path):
            continue
        if file[0] == ".":
            continue
        if (not check_for_changes(missionspath, file, "")) and (not mainisupdated):
            skipped += 1
            print("    Skipping {}.".format(file))
            continue

        print("  Making {} ...".format(file))

        try:
            if file == MAINMISSION:
                command = path_armake + " build -p -i " + workdrivepath + \
                " -w unquoted-string" + " -w redefinition-wo-undef" + \
                " -f " + os.path.normpath(missionspath + "/" + file) + " " + \
                os.path.normpath(missionspath + "/" + file + ".pbo")
                subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)
            else:
                os.makedirs(temppath)
                newdir = os.path.normpath(temppath + "/" + file)
                shutil.copytree(os.path.normpath(missionspath + "/" + MAINMISSION), newdir)
                copy_tree(os.path.normpath(missionspath + "/" + file), newdir)

                command = path_armake + " build -p -i " + workdrivepath + \
                " -w unquoted-string" + " -w redefinition-wo-undef" + \
                " -f " + newdir + " " + \
                os.path.normpath(missionspath + "/" + file + ".pbo")
                subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)

                shutil.rmtree(temppath, ignore_errors=True)
        except:
            failed += 1
            print("    Failed to make {}.".format(file))
        else:
            made += 1
            print("    Successfully made {}.".format(file))

    print("\n  Done. \n")
    print("  Made {}, skipped {}, removed {}, failed to make {}.\n".format(made, \
        skipped, removed, failed))

    return failed

if __name__ == "__main__":
    sys.exit(main())
