"""Creating Mission pbos"""
# Author: Dorbedo
#
#!/usr/bin/python3
# -*- coding: utf-8 -*-
# pylint: disable=W1401

import sys
import os
import shutil
import struct
import platform
from distutils.dir_util import copy_tree

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
    shutil.copytree(path_primary_mission, os.path.normpath(path_temp + "/" + primary_missionname))

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
        print("Creating %s.pbo" % (folder))

    shutil.rmtree(path_temp, ignore_errors=True)
    return True

def main():
    """main"""
    if create_mission_pbos():
        print("\n No errors found.")
        return 0
    else:
        print("Errors found.")
        return 1

if __name__ == '__main__':
    sys.exit(main())
