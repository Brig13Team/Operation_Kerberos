"""Creating Mission pbos"""
# Author: Dorbedo
#
#!/usr/bin/python3
# -*- coding: utf-8 -*-
# pylint: disable=W0702

import os
import sys
import re
import datetime
import configparser
import argparse
import subprocess
import shutil
import platform
from distutils.dir_util import copy_tree



def main():
    """Main"""
    parser = argparse.ArgumentParser(description='Armake Buildscript')
    parser.add_argument('buildtype', type=str, choices=['dev', 'mission', 'release'])
    parsergrp = parser.add_argument_group('version')
    parsergrp.add_argument('-patch', type=int, default=0, help='increase patch')
    parsergrp.add_argument('-minor', type=int, default=0, help='increase minor')
    parsergrp.add_argument('-major', type=int, default=0, help='increase major')

    start = datetime.datetime.now()

    #build()

    print()

    print("\nTotal Program time elapsed: {}".\
        format(datetime.datetime.now() - start))

    input("Press Enter to continue...")

def get_configvalue(valueid, valuegroup='DEFAULT'):
    """returns the value form the configfile"""
    config = configparser.ConfigParser()
    config.read('build.cfg')
    return config[valuegroup][valueid]


def update_versionfile(filepath):
    """Updates the Versionfile"""

    # find the Versionfile
    filename = get_configvalue('filename')
    for file in os.walk(filepath):
        if os.path.isfile(file) and file == filename:
            



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
        if file != "script_version.hpp":
            maxi = max(mod_time(os.path.join(path, file)), maxi)
    return maxi

def fract_sec(second):
    """fract sec"""
    temp = float()
    temp = float(second) / (60*60*24)
    days = int(temp)
    temp = (temp - days) * 24
    hours = int(temp)
    temp = (temp - hours) * 60
    minutes = int(temp)
    temp = (temp - minutes) * 60
    sec = temp
    return hours, minutes, sec

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

def get_version(filepath, version_increments=[]):
    """update the build version"""
    versionfile = open(filepath, "r")
    hpptext = versionfile.read()
    versionfile.close()

    if hpptext:
        majortext = re.search(r"#define MAJOR (.*\b)", hpptext).group(1)
        minortext = re.search(r"#define MINOR (.*\b)", hpptext).group(1)
        patchtext = re.search(r"#define PATCHLVL (.*\b)", hpptext).group(1)
        buildtext = re.search(r"#define BUILD (.*\b)", hpptext).group(1)

        if "major" in version_increments:
            majortext = int(majortext) + 1
            minortext = 0
            patchtext = 0
        elif "minor" in version_increments:
            minortext = int(minortext) + 1
            patchtext = 0
        elif "patch" in version_increments:
            patchtext = int(patchtext) + 1

        buildtext = int(buildtext) + 1

        with open(filepath, "w", newline="\n") as file:
            file.writelines([
                "#define MAJOR {}\n".format(majortext),
                "#define MINOR {}\n".format(minortext),
                "#define PATCHLVL {}\n".format(patchtext),
                "#define BUILD {}\n".format(buildtext)
            ])
        return majortext, minortext, patchtext, buildtext


def build(argv):
    """main"""
    print("""
  #####################
  # Building Kerberos #
  #####################
""")

    version_increments = []
    if "increment_patch" in argv:
        argv.remove("increment_patch")
        version_increments.append("patch")
    if "increment_minor" in argv:
        argv.remove("increment_minor")
        version_increments.append("minor")
    if "increment_major" in argv:
        argv.remove("increment_major")
        version_increments.append("major")

    scriptpath = os.path.realpath(__file__)
    projectpath = os.path.dirname(os.path.dirname(scriptpath))
    addonspath = os.path.join(projectpath, "addons")
    missionspath = os.path.join(projectpath, "missions")
    workdrivepath = os.path.normpath("P:")
    temppath = os.path.join(projectpath, "temp")

    if not os.path.exists(os.path.normpath(projectpath + "/privatekeys/")):
        os.makedirs(os.path.normpath(projectpath + "/privatekeys/"))
    if not os.path.exists(os.path.normpath(projectpath + "/release/@dorb/keys")):
        os.makedirs(os.path.normpath(projectpath + "/release/@dorb/keys"))
    if os.path.exists(os.path.normpath(projectpath + "/release/@dorb/addons")):
        shutil.rmtree(os.path.normpath(projectpath + "/release/@dorb/addons"), ignore_errors=True)
    os.makedirs(os.path.normpath(projectpath + "/release/@dorb/addons"))
    if os.path.exists(os.path.normpath(projectpath + "/release/@dorb/mpmissions")):
        shutil.rmtree(os.path.normpath(projectpath + "/release/@dorb/mpmissions"),\
            ignore_errors=True)
    os.makedirs(os.path.normpath(projectpath + "/release/@dorb/mpmissions"))

    made = 0
    failed = 0

    if platform.system() == "Windows":
        path_armake = os.path.normpath(projectpath + "/tools/armake_w64.exe")
    else:
        path_armake = "armake"
        workdrivepath = os.path.normpath("/mnt/p/")

    major, minor, patch, build = get_version(os.path.normpath(addonspath \
        + "/main/script_version.hpp"), version_increments)

    print("  Version: {}.{}.{}.{}".format(major, minor, patch, build), "\n")

    if not os.path.exists(os.path.normpath(projectpath + \
        "/privatekeys/Kerberos_{}.{}.biprivatekey".format(major, minor))):
        print("  Creating the new keys Kerberos_{}.{} \n".format(major, minor))
        command = path_armake + " keygen -f " + os.path.normpath(projectpath + \
            "/privatekeys/Kerberos_{}.{}".format(major, minor))
        subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)

    shutil.copy(os.path.normpath(projectpath + \
        "/privatekeys/Kerberos_{}.{}.bikey".format(major, minor)), \
        os.path.normpath(projectpath + \
        "/release/@dorb/keys/Kerberos_{}.{}.bikey".format(major, minor)))

    print("  Creating the servermod")
    releasepath = os.path.normpath(projectpath + "/release/@dorb/addons")

    for file in os.listdir(addonspath):
        path = os.path.join(addonspath, file)
        if not os.path.isdir(path):
            continue
        if file[0] == ".":
            continue

        print("  Making {}{} ...".format(PREFIX, file))

        try:
            command = path_armake + " build -i " + workdrivepath + \
                " -w unquoted-string" + " -w redefinition-wo-undef" + \
                " -f " + os.path.normpath(addonspath + "/" + file) + " " + \
                os.path.normpath(releasepath + "/" + PREFIX + file + ".pbo")
            subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)

            command = path_armake + " sign -f " + os.path.normpath(projectpath + \
                "/privatekeys/Kerberos_{}.{}.biprivatekey ".format(major, minor)) + \
                os.path.normpath(releasepath + "/" + PREFIX + file + ".pbo")
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

    shutil.copy(os.path.normpath(addonspath + "/main/script_version.hpp"), \
        os.path.normpath(missionspath + "/" + MAINMISSION + "/main/script_version.hpp"))


    releasepath = os.path.normpath(projectpath + "/release/@dorb/mpmissions")
    if not os.path.exists(releasepath):
        os.makedirs(releasepath)

    for file in os.listdir(missionspath):
        path = os.path.join(missionspath, file)
        if not os.path.isdir(path):
            continue
        if file[0] == ".":
            continue

        print("  Making {} ...".format(file))

        try:
            if file == MAINMISSION:
                command = path_armake + " build -p -i " + workdrivepath + \
                " -w unquoted-string" + " -w redefinition-wo-undef" + \
                " -f " + os.path.normpath(missionspath + "/" + file) + " " + \
                os.path.normpath(releasepath + "/" + file + ".pbo")
                subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)
            else:
                os.makedirs(temppath)
                newdir = os.path.normpath(temppath + "/" + file)
                shutil.copytree(os.path.normpath(missionspath + "/" + MAINMISSION), newdir)
                copy_tree(os.path.normpath(missionspath + "/" + file), newdir)

                command = path_armake + " build -p -i " + workdrivepath + \
                " -w unquoted-string" + " -w redefinition-wo-undef" + \
                " -f " + newdir + " " + \
                os.path.normpath(releasepath + "/" + file + ".pbo")
                subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)

                shutil.rmtree(temppath, ignore_errors=True)
        except:
            failed += 1
            print("    Failed to make {}.".format(file))
        else:
            made += 1
            print("    Successfully made {}.".format(file))

    releasepath = os.path.normpath(projectpath + "/release/@dorb")

    shutil.copy(os.path.normpath(projectpath + "/LICENSE"), \
        os.path.normpath(releasepath + "/LICENSE"))

    shutil.copy(os.path.normpath(projectpath + "/README.md"), \
        os.path.normpath(releasepath + "/README.md"))

    releasename = "{}_{}.{}.{}.{}".format(MAINMISSION.rsplit(".", 1)[0], major, minor, patch, build)

    os.chdir(os.path.normpath(projectpath))
    shutil.make_archive("{}".format(releasename), "zip", \
       os.path.normpath(projectpath + "/release"))

    print("\n  Done. \n")
    print("  Made {}, failed to make {}.\n".format(made, failed))


if __name__ == "__main__":
    main()
