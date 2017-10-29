"""Creating Mission pbos"""
# Author: Dorbedo
#
#!/usr/bin/python3
# -*- coding: utf-8 -*-
# pylint: disable=W1401

import sys
import os
import re
import shutil
from shutil import copy2
import struct
import platform
from distutils.dir_util import copy_tree
from colorama import init, Fore
init()


def is_python_64bit():
    """checks if it is 64-bit OS"""
    return struct.calcsize("P") == 8

def create_mission_pbos():
    """creates the mission pbos"""
    primary_missionname = "Operation_Kerberos.Altis"

    # switch the folder if the function is inside the tools directory
    if os.path.basename(os.path.dirname(os.path.realpath(__file__))) == "tools":
        path_root = os.path.normpath(os.path.dirname(os.path.realpath(__file__)) + "/../")
    else:
        path_root = os.path.dirname(os.path.realpath(__file__))

    path_temp = os.path.normpath(path_root + "/temp")
    path_missions = os.path.normpath(path_root + "/missions")
    path_release = os.path.normpath(path_root + "/release")
    path_servermod = os.path.normpath(path_root + "/servermod/dorb")
    path_keys = path_root

    if platform.system() == "Windows":
        if is_python_64bit():
            path_armake = os.path.normpath(path_root + "/tools/armake_w64.exe")
        else:
            path_armake = os.path.normpath(path_root + "/tools/armake_w32.exe")
    else:
        path_armake = "armake"

    if not os.path.exists(path_release):
        os.makedirs(path_release)

    if os.path.exists(path_temp):
        shutil.rmtree(path_temp, ignore_errors=True)
    os.makedirs(path_temp)

    if not os.path.exists(path_missions + "/" + primary_missionname):
        print("no missions folder found")
        return False

    path_primary_mission = os.path.normpath(path_missions + "/" + primary_missionname)
    update_version(os.path.normpath(path_primary_mission + "/main/script_version.hpp"), \
        os.path.normpath(path_servermod + "/addons/main/script_version.hpp"), path_keys, path_armake, path_release)




    shutil.copytree(path_primary_mission, os.path.normpath(path_temp + "/" + primary_missionname))

    print_yellow("Copying files")
    for file in os.listdir(path_missions):
        if not file.lower() == primary_missionname.lower():
            newdir = os.path.normpath(path_temp + "/" + file)
            shutil.copytree(path_primary_mission, newdir)
            copy_tree(os.path.normpath(path_missions + "/" + file), newdir)

    for folder in os.listdir(path_temp):
        cmd_armake = path_armake + " build -p -w unquoted-string -w redefinition-wo-undef -f " + \
            os.path.normpath(path_temp + "/" + folder) + " " + \
            os.path.normpath(path_release + "/" + folder + ".pbo")
        os.system(cmd_armake)
        print_yellow("Creating %s.pbo" % (folder))

    create_mod_pbo(path_servermod, path_release)

    shutil.rmtree(path_temp, ignore_errors=True)
    return True

def create_mod_pbo(path_servermod, path_release):
    print (path_servermod, path_release)

def update_version(filepath, copypath, keypath, path_armake, path_release):
    """update the build version"""
    versionfile = open(filepath, "r")
    hpptext = versionfile.read()
    versionfile.close()

    if hpptext:
        majortext = re.search(r"#define MAJOR (.*\b)", hpptext).group(1)
        minortext = re.search(r"#define MINOR (.*\b)", hpptext).group(1)
        patchtext = re.search(r"#define PATCHLVL (.*\b)", hpptext).group(1)
        buildtext = re.search(r"#define BUILD (.*\b)", hpptext).group(1)

        keyname = "Kerberos_{}.{}".format(majortext, minortext)

        cmd_armake = path_armake + " keygen -f {}".format( \
            os.path.normpath(path_release + "/" + keyname))
        print(cmd_armake)
        os.system(cmd_armake)

        buildtext = int(buildtext) + 1

        print_yellow("Incrementing version to {}.{}.{}.{}".format(majortext,\
            minortext, patchtext, buildtext))
        with open(filepath, "w", newline="\n") as file:
            file.writelines([
                "#define MAJOR {}\n".format(majortext),
                "#define MINOR {}\n".format(minortext),
                "#define PATCHLVL {}\n".format(patchtext),
                "#define BUILD {}\n".format(buildtext)
            ])
        copy2(filepath, copypath)

def print_green(text):
    """print green colored"""
    print(Fore.GREEN + text)

def print_red(text):
    """print red colored"""
    print(Fore.RED + text)

def print_yellow(text):
    """print yellow colored"""
    print(Fore.YELLOW + text)

def main():
    """main"""
    print_green("Creating mission pbos")

    try:
        back = create_mission_pbos()
        if not back:
            ValueError('Armake failed')
        print_green("No errors found.")
    except:
        print_red("Error occured found.")
        print(Fore.RESET)
        return 1
    else:
        print(Fore.RESET)
        return 0

if __name__ == '__main__':
    sys.exit(main())
