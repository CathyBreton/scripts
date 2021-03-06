#!/usr/local/bioinfo/python/3.4.3_build2/bin/python
# -*- coding: utf-8 -*-
# @package extractSeqFasta.py
# @author Sebastien Ravel

"""
	The extractSeqFasta script
	==========================
	:author: Sebastien Ravel
	:contact: sebastien.ravel@cirad.fr
	:date: 08/07/2016
	:version: 0.1

	Script description
	------------------

	This Programme extract Fasta Seq with liste keep

	Example
	-------

	>>> # keep sequences in list
	>>> extractSeqFasta.py -f myseq.fasta -l listKeepSeq.txt -o output.fasta -k yes
	>>> # remove sequences in list
	>>> extractSeqFasta.py -f myseq.fasta -l listNoKeepSeq.txt -o output.fasta -k no

	Help Programm
	-------------

	optional arguments:
		- \-h, --help
						show this help message and exit
		- \-v, --version
						display extractSeqFasta.py version number and exit

	Input mandatory infos for running:
		- \-f <filename>, --fasta <filename>
						fasta files
		- \-l <filename>, --list <filename>
						list files with keep name or not keep
		- \-o <filename>, --out <filename>
						Name of output file
		- \-k <yes/y/no/n>, --keep <yes/y/no/n>
						choise keep (y/yes) or not keep (n/no) sequences in list file

"""

##################################################
## Modules
##################################################
#Import MODULES_SEB
import sys, os
current_dir = os.path.dirname(os.path.abspath(__file__))+"/"
sys.path.insert(1,current_dir+'../modules/')
from MODULES_SEB import extractInverseListFromFasta, extractListFromFasta, relativeToAbsolutePath, existant_file

## Python modules
import argparse
from time import localtime, strftime

## BIO Python modules
from Bio import SeqIO


##################################################
## Variables Globales
version="0.1"
VERSION_DATE='04/03/2015'
debug="False"
#debug="True"


##################################################
## Functions
def checkParameters (arg_list):
	# Check input related options
	if (not arg_list.fastaFile):
		print ('Error: No input file defined via option -f/--fasta !' + "\n")
		parser.print_help()
		exit()

##################################################
## Main code
##################################################
if __name__ == "__main__":

	# Initializations
	start_time = strftime("%d-%m-%Y_%H:%M:%S", localtime())
	# Parameters recovery
	parser = argparse.ArgumentParser(prog='extractSeqFasta.py', description='''This Programme extract Fasta Seq with liste keep''')
	parser.add_argument('-v', '--version', action='version', version='You are using %(prog)s version: ' + version, help=\
						'display extractSeqFasta.py version number and exit')
	#parser.add_argument('-dd', '--debug',choices=("False","True"), dest='debug', help='enter verbose/debug mode', default = "False")

	filesreq = parser.add_argument_group('Input mandatory infos for running')
	filesreq.add_argument('-f', '--fasta', metavar="<filename>", type=existant_file, required=True, dest = 'fastaFile', help = 'fasta files')
	filesreq.add_argument('-l', '--list', metavar="<filename>", type=existant_file, required=True, dest = 'listFile', help = 'list files with keep name or not keep')
	filesreq.add_argument('-o', '--out', metavar="<filename>", required=True, dest = 'paramoutfile', help = 'Name of output file')
	filesreq.add_argument('-k', '--keep', metavar="<yes/y/no/n>", required=True, dest = 'keepValue',choices = ["yes","y","no","n"], help = 'choise keep (y/yes) or not keep (n/no) sequences in list file')

	# Check parameters
	args = parser.parse_args()
	checkParameters(args)

	#Welcome message
	print("#################################################################")
	print("#        Welcome in extractSeqFasta (Version " + version + ")          #")
	print("#################################################################")
	print('Start time: ', start_time,'\n')

	# Récupère le fichier de conf passer en argument
	fastaFile = relativeToAbsolutePath(args.fastaFile)
	outputfilename = relativeToAbsolutePath(args.paramoutfile)
	listFile = relativeToAbsolutePath(args.listFile)
	keepValue = args.keepValue

	output_handle = open(outputfilename, "w")


	if keepValue in ["no","n"]:
		dico_keep, nbTotal = extractInverseListFromFasta(fastaFile, listFile)
	elif keepValue in ["yes","y"]:
		dico_keep, nbTotal = extractListFromFasta(fastaFile, listFile)

	nbKeep = len(dico_keep.keys())
	for geneId, sequence in dico_keep.items():
		SeqIO.write(sequence,output_handle, "fasta")

	output_handle.close()
	print("\n\nExecution summary:")

	print("  - Outputting \n\
	Il y a au final %i Sequences gardées sur les %i initial\n\
	les sequences sont ajoutées dans le fichier %s" %(nbKeep,nbTotal,outputfilename))
	print("\nStop time: ", strftime("%d-%m-%Y_%H:%M:%S", localtime()))
	print("#################################################################")
	print("#                        End of execution                       #")
	print("#################################################################")
