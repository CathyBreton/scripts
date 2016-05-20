#!/usr/bin/python3.5
# -*- coding: utf-8 -*-
## @package renameFile.py
# @author Sebastien Ravel

##################################################
## Modules
##################################################
#Import MODULES_SEB
import sys, os
current_dir = os.path.dirname(os.path.abspath(__file__))+"/"
sys.path.insert(1,current_dir+'../modules/')
from MODULES_SEB import directory, replace_all

## Python modules
import argparse
from time import localtime, strftime


##################################################
## Variables Globales
version="0.1"
VERSION_DATE='03/05/2016'

##################################################
## Main code
##################################################
if __name__ == "__main__":

	# Initializations
	start_time = strftime("%d-%m-%Y_%H:%M:%S", localtime())
	# Parameters recovery
	parser = argparse.ArgumentParser(prog='renameFile.py', description='''This Programme rename files in and directory''')
	parser.add_argument('-v', '--version', action='version', version='You are using %(prog)s version: ' + version, help=\
						'display renameFile version number and exit')
	#parser.add_argument('-dd', '--debug',choices=("False","True"), dest='debug', help='enter verbose/debug mode', default = "False")

	filesreq = parser.add_argument_group('Input mandatory infos for running')
	filesreq.add_argument('-d', '--directory', metavar="<path/to/directory>", type = directory, required=True, dest = 'dirPath', help = 'path with files to rename')
	filesreq.add_argument('-r', '--replace', metavar="<OLD:NEW,OLD:NEW>", required=True, dest = 'replaceParam', help = 'Expression replace must be OLD:NEW and if multiple replace use comma to separate ')

	args = parser.parse_args()

	#Welcome message
	print("#################################################################")
	print("#         Welcome in renameFile (Version " + version + ")           #")
	print("#################################################################")
	print('Start time: ', start_time,'\n')

	# Récupère le fichier de conf passer en argument
	workingObjDir = args.dirPath
	replaceParam = args.replaceParam

	print("Workink Directory: %s" % workingObjDir.pathDirectory)

	dicoReplace = {}
	for value in replaceParam.split(","):
		old,new = value.split(":")
		dicoReplace[old] = new


	for fileIn in workingObjDir.listFiles:
		basename = fileIn.split("/")[-1].split(".")[0]
		extention = "."+".".join(fileIn.split("/")[-1].split(".")[1:])

		newName = replace_all(dicoReplace, basename)
		print(basename+extention,"\t",newName+extention)
		os.rename(fileIn , workingObjDir.pathDirectory+newName+extention)


	print("\nStop time: ", strftime("%d-%m-%Y_%H:%M:%S", localtime()))
	print("#################################################################")
	print("#                        End of execution                       #")
	print("#################################################################")