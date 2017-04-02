import os
import sys

def validate_xml(filepath : str):
    file = open(filepath,'r')
    content = file.read()
    file.close()

    stack = []
    index = 0
    while index < len(content):
        if (content[index] == '<'):
            # a comment
            if (content[index:index+4] == "<!--"):
                index = content.find("-->", index + 4)
                if (index < 0): break
                index += 3

            # special tag
            elif (content[index:index+2] == "<?"):
                index = content.find("?>", index + 2)
                if (index < 0): break

            # close tag
            elif (content[index:index+2] == "</"):
                first = index + 2
                last = content.find(">", first)
                if (last < 0): break

                closedName = content[first:last]
                if (len(stack) == 0):
                    print("Tag '" + closedName + "' closed but not opened before!")
                    return 1

                openedName = stack.pop()
                if (openedName != closedName):
                    print("Tag '" + closedName + "' closed but '" + openedName + "' opened!")
                    return 1

            # normal tag
            else:
                first = index + 1
                last = content.find(">", first)
                if (last < 0): break
                space = content.find(" ",first,last)
                if (space > 0):
                    index = last + 2
                    last = space
                stack.append(content[first:last])

        index += 1

def main():
    dirToCheck = "../[Dorb]Operation_Kerberos.Altis"

    errors = 0;
    for root, subdirs, files in os.walk(dirToCheck):
        for name in list(filter(lambda x: x.endswith(".xml"),files)):
            if (not validate_xml(os.path.join(root,name))):
                errors = errors + 1

    if (errors > 0):
        return 1
    else:
        print("No errors found.")
        return 0

if __name__ == '__main__':
    sys.exit(main())
