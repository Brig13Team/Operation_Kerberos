#!/usr/bin/python3

import os
import sys

def checkNegative(i : int, error : str):
    if (i < 0):
        raise ValueError(error)

def validate_xml(filepath : str) -> bool:
    file = open(filepath,'r')
    content = file.read()
    file.close()

    try:
        stack = []
        index = 0

        while index < len(content):
            if (content[index] == '<'):
                # a comment
                if (content[index:index+4] == "<!--"):
                    index = content.find("-->", index + 4)
                    checkNegative(index,"Comment not closed!")
                    index += 3

                # processing instruction
                elif (content[index:index+2] == "<?"):
                    index = content.find("?>", index + 2)
                    checkNegative(index,"Missing '?>' in processing instruction!")
                    index += 2

                # end tag
                elif (content[index:index+2] == "</"):
                    first = index + 2

                    last = content.find(">", first)
                    checkNegative(index,"End Tag never closed!")
                    closedName = content[first:last]

                    checkNegative(len(stack)-1, "Element '" + closedName + "' closed but not opened before!")
                    openedName = stack.pop()
                    if (openedName != closedName):
                        raise ValueError ("Element '" + closedName + "' closed but '" + openedName + "' excepted to be closed!")

                    index = last + 1

                # start tag
                else:
                    first = index + 1
                    last = content.find(">", first)
                    checkNegative(last, "Start Tag never closed!")
                    
                    # not an empty-element tag
                    if (not content[last-1] == '/'):
                        space = content.find(" ",first,last)
                        if (space > 0):
                            index = last + 2
                            last = space
                        stack.append(content[first:last])
        
            index += 1

    except Exception as error:
        print(error)
        return False
        
    return True

def main():
    dirToCheck = "../[Dorb]Operation_Kerberos.Altis"

    errors = 0;
    for root, subdirs, files in os.walk(dirToCheck):
        for name in list(filter(lambda x: x.endswith(".xml"),files)):
            if (not validate_xml(os.path.join(root,name))):
                errors = errors + 1

    if (errors > 0):
        print(str(errors) + " erros found!")
        return 1
    else:
        print("No errors found.")
        return 0

if __name__ == '__main__':
    sys.exit(main())
