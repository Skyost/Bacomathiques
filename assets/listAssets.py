import os

def recursivePrint(directory, prefix = '- assets'):
    for root, subDirectories, files in os.walk(directory):
        for directory in subDirectories:
            directory = os.path.join(root, directory)
            onlyFiles = [file for file in os.listdir(directory) if os.path.isfile(os.path.join(directory, file))]
            if not onlyFiles:
                continue
            print(prefix + directory.replace(os.getcwd(), '').replace(os.path.sep, '/') + '/')

recursivePrint(os.getcwd())
