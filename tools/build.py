"""Creating Mission pbos"""
# Author: Dorbedo
#
#!/usr/bin/python3
# -*- coding: utf-8 -*-
# pylint: disable=W1401

import os
import sys
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
    if not os.path.isdir(path):
        return os.path.getmtime(path)
    maxi = os.path.getmtime(path)
    for p in os.listdir(path):
        maxi = max(mod_time(os.path.join(path, p)), maxi)
    return maxi

def check_for_changes(addonspath, module, pre):
    if not os.path.exists(os.path.join(addonspath, "{}{}.pbo".format(pre, module))):
        return True
    return mod_time(os.path.join(addonspath, module)) > mod_time(os.path.join(addonspath, \
        "{}{}.pbo".format(pre, module)))

def check_for_obsolete_pbos(addonspath, file):
    module = file[len(PREFIX):-4]
    if not os.path.exists(os.path.join(addonspath, module)):
        return True
    return False

def main():
    print("""
  #####################
  # Building Kerberos #
  #####################
""")

    scriptpath = os.path.realpath(__file__)
    projectpath = os.path.dirname(os.path.dirname(scriptpath))
    addonspath = os.path.join(projectpath, "addons")
    missionspath = os.path.join(projectpath, "missions")
    workdrivepath = os.path.normpath("P:")
    temppath = os.path.join(projectpath, "temp")

    os.chdir(addonspath)

    made = 0
    failed = 0
    skipped = 0
    removed = 0
    force_missions = False

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

    print("Creating Servermod")

    for p in os.listdir(addonspath):
        path = os.path.join(addonspath, p)
        if not os.path.isdir(path):
            continue
        if p[0] == ".":
            continue
        if not check_for_changes(addonspath, p, PREFIX):
            skipped += 1
            print("  Skipping {}.".format(p))
            continue

        print("# Making {} ...".format(p))

        try:
            command = path_armake + " build -i " + workdrivepath + \
                " -w unquoted-string" + " -w redefinition-wo-undef" + \
                " -f " + os.path.normpath(addonspath + "/" + p) + " " + \
                os.path.normpath(addonspath + "/" + PREFIX + p + ".pbo")
            subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)
        except:
            failed += 1
            print("  Failed to make {}.".format(p))
        else:
            made += 1
            print("  Successfully made {}.".format(p))

    print("Creating Missionfiles")

    if os.path.exists(temppath):
        shutil.rmtree(temppath, ignore_errors=True)

    if check_for_changes(missionspath, MAINMISSION, ""):
        updateallmissions = True
    else:
        updateallmissions = False

    for p in os.listdir(missionspath):
        path = os.path.join(missionspath, p)
        if not os.path.isdir(path):
            continue
        if p[0] == ".":
            continue
        if not check_for_changes(missionspath, p, ""):
            skipped += 1
            print("  Skipping {}.".format(p))
            continue
        if not updateallmissions:
            continue




        try:

            if p == MAINMISSION:
                command = path_armake + " build -p -i " + workdrivepath + \
                " -w unquoted-string" + " -w redefinition-wo-undef" + \
                " -f " + os.path.normpath(missionspath + "/" + p) + " " + \
                os.path.normpath(missionspath + "/" + p + ".pbo")
                subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)
            else:
                os.makedirs(temppath)
                newdir = os.path.normpath(temppath + "/" + file)
                shutil.copytree(normpath(missionspath + "/" + MAINMISSION), newdir)
                copy_tree(os.path.normpath(missionspath + "/" + p), newdir)

                command = path_armake + " build -p -i " + workdrivepath + \
                " -w unquoted-string" + " -w redefinition-wo-undef" + \
                " -f " + newdir + " " + \
                os.path.normpath(missionspath + "/" + p + ".pbo")
                subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)

                shutil.rmtree(temppath, ignore_errors=True)
        except:
            failed += 1
            print("  Failed to make {}.".format(p))
        else:
            made += 1
            print("  Successfully made {}.".format(p))

    print("UpdateallMissions={}".format(updateallmissions))


    print("\n# Done.")
    print("  Made {}, skipped {}, removed {}, failed to make {}.".format(made, \
        skipped, removed, failed))


if __name__ == "__main__":
    sys.exit(main())
