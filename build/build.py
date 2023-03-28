#------------------------------------------------------------------------
#------------------------------------------------------------------------
# cuhFramework || An addon creation framework to make SW addon development easier. || Created by cuh4#7366
#------------------------------------------------------------------------
#------------------------------------------------------------------------
"""
	My Discord: cuh4#7366
	cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
    https://github.com/Roozz1/cuhFramework
"""
#//Imports\\#
import time
import os
from os.path import isfile

#//Variables\\#
framework_file = "cuhFramework.lua"
build_file_name = "script.lua"

#//Functions\\#
def alert(msg: str):
    return print(f"|!| {msg}")

def warn(msg: str):
    return print(f"|?| {msg}")

def success(msg: str):
    return print(f"|:)| {msg}")

def timedExit(duration: int|float):
    alert(f"Exiting in {str(duration)} seconds.")
    time.sleep(duration)
    return exit(0)

def build(script_file: str):    
    # stage 1 - get script contents
    try:
        content = ""
        with open(script_file, "r") as f:
            content = f.read()
    except:
        alert(f"Failed to read {script_file}.")
        timedExit(3)
        
    # stage 2 - get framework contents
    framework_content = ""
    try:
        with open(framework_file, "r") as f:
            framework_content = f.read()
    except:
        alert(f"Failed to read {framework_file}. Is {framework_file} in the same path as {__file__}?")
        timedExit(3)
        
    # stage 3 - backup user's script
    try:
        with open(f"backup_{script_file}", "w") as f:
            f.write(content)
    except:
        alert(f"Failed to backup {script_file}.")
        timedExit(3)
        
    # stage 4 - combine
    new_content = content.replace("g_savedata", "g_savedata_overwritten")
    try:
        with open(build_file_name, "w") as f:
            f.write(f"{framework_content}\n\n{new_content}")
    except:
        alert(f"Failed to combine {script_file} with {framework_file}.")
        timedExit(3)

#//Main\\#
# Credit
print("""------------------------------------------------------------------------
cuhFramework || An addon creation framework to make SW addon development easier.
    Created by cuh4#7366
    cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
    https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------""")

# Safety Checks
if not isfile(framework_file):
    warn(f"The cuhFramework file ('{framework_file}') was not found. Is the file in the same directory as 'build.bat'?.")
    timedExit(5)
    
# Get .lua files
filesInDir = os.listdir()
luaFilesInDir = []

count = 0

for i, v in enumerate(filesInDir):
    if v.endswith(".lua"):
        luaFilesInDir.insert(count, v)
        print(f"[{str(count)}] {v}")
        count += 1
    
if count == 0:
    warn("There are no '.lua' files in this directory.")
    timedExit(5)
    
# Get addon script.lua file
desired = input("\n|?| From the .lua files above, select your addon script file.\n")
if not desired.isnumeric():
    warn("Invalid input (not a number).")
    timedExit(5)
    
if int(desired) < 0 or int(desired) > len(luaFilesInDir) - 1:
    warn("Invalid input (file doesn't exist).")
    timedExit(5)

# Build
chosenFile = luaFilesInDir[int(desired)]
success(f"You have chosen {chosenFile} as your addon script file.")
success("Building...")

build(chosenFile)
success(f"Successfully added cuhFramework to your script. The result can be found in {build_file_name}. Your script file has been backed up.")
timedExit(10)