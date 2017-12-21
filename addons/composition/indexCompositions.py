"""Creates the includefiles for the compositions"""
# Author: Dorbedo
#
#!/usr/bin/python3
# -*- coding: utf-8 -*-
# pylint: disable=W1401

import sys
import os
from glob import glob

def create_mission_pbos():
    """creates the mission pbos"""

    path_configfiles = os.path.normpath(os.path.dirname(os.path.realpath(__file__)) + "/config")

    for compositiontype in glob(path_configfiles + "/*/"):
        compositions = glob(compositiontype + "/*/")
        filename = os.path.normpath(path_configfiles + "/" + \
            os.path.basename(os.path.dirname(compositiontype)) + ".hpp")
        print(filename)
        include_file = open(filename, "w")
        for folder in compositions:
            include_file.write("class " + os.path.basename(os.path.dirname(folder)) + " {\n")
            include_file.write("    class header {\n")
            include_file.write("        #include \"" \
                + os.path.basename(os.path.dirname(compositiontype)) + "\\" \
                + os.path.basename(os.path.dirname(folder)) + "\\header.sqe\"\n")
            include_file.write("    };\n")
            include_file.write("    class composition {\n")
            include_file.write("        #include \"" \
                + os.path.basename(os.path.dirname(compositiontype)) + "\\" \
                + os.path.basename(os.path.dirname(folder)) + "\\composition.sqe\"\n")
            include_file.write("    };\n")
            include_file.write("};\n\n")
        include_file.close()
    return True

def main():
    """main"""
    try:
        back = create_mission_pbos()
        if not back:
            ValueError('creating failed')
        print("No errors found.")
    except:
        print("Error occured")
        return 1
    else:
        return 0

if __name__ == '__main__':
    sys.exit(main())
