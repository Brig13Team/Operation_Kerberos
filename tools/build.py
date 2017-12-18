"""Creating Mission pbos"""
# Author: Dorbedo
#
#!/usr/bin/python3
# -*- coding: utf-8 -*-
# pylint: disable=W1401

import os
import sys
import subprocess
import struct
import platform

######## GLOBALS #########
MAINPREFIX = "x"
PREFIX = "dorb_"
##########################

def mod_time(path):
    if not os.path.isdir(path):
        return os.path.getmtime(path)
    maxi = os.path.getmtime(path)
    for p in os.listdir(path):
        maxi = max(mod_time(os.path.join(path, p)), maxi)
    return maxi


def check_for_changes(addonspath, module):
    if not os.path.exists(os.path.join(addonspath, "{}{}.pbo".format(PREFIX, module))):
        return True
    return mod_time(os.path.join(addonspath, module)) > mod_time(os.path.join(addonspath, \
        "{}{}.pbo".format(PREFIX, module)))

def check_for_obsolete_pbos(addonspath, file):
    module = file[len(PREFIX):-4]
    if not os.path.exists(os.path.join(addonspath, module)):
        return True
    return False

def main():
    print("""
  #####################
  # Addon Debug Build #
  #####################
""")

    scriptpath = os.path.realpath(__file__)
    projectpath = os.path.dirname(os.path.dirname(scriptpath))
    addonspath = os.path.join(projectpath, "addons")
    missionspath = os.path.join(projectpath, "missions")

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
        work_drive = "P:\\"
        if struct.calcsize("P") == 8:
            path_armake = os.path.normpath(projectpath + "/tools/armake_w64.exe")
        else:
            path_armake = os.path.normpath(projectpath + "/tools/armake_w32.exe")
    else:
        path_armake = "armake"
        work_drive = "/mnt/p"

    print("")

    for p in os.listdir(addonspath):
        path = os.path.join(addonspath, p)
        if not os.path.isdir(path):
            continue
        if p[0] == ".":
            continue
        if not check_for_changes(addonspath, p):
            skipped += 1
            print("  Skipping {}.".format(p))
            continue

        print("# Making {} ...".format(p))

        try:
            if bool(USEARMAKE) or platform.system() != "Windows":
                command = path_armake + " build -i " + os.path.normpath(work_drive) + \
                    " -w unquoted-string" + " -w redefinition-wo-undef" + \
                    " -f " + os.path.normpath(addonspath + "/" + p) + " " + \
                    os.path.normpath(addonspath + "/" + PREFIX + p + ".pbo")
                subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)

            else:
                subprocess.check_output([
                    "makepbo",
                    "-NUP",
                    "-@={}\\{}\\addons\\{}".format(MAINPREFIX, PREFIX.rstrip("_"), p),
                    p,
                    "{}{}.pbo".format(PREFIX, p)
                ], stderr=subprocess.STDOUT)
        except:
            failed += 1
            print("  Failed to make {}.".format(p))
        else:
            made += 1
            print("  Successfully made {}.".format(p))

    print("\n# Done.")
    print("  Made {}, skipped {}, removed {}, failed to make {}.".format(made, \
        skipped, removed, failed))


if __name__ == "__main__":
    sys.exit(main())
