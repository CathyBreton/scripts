#!/bin/bash
# -*- coding: utf-8 -*-
## @package epydocUpdate.sh
# @author Sebastien Ravel


jour=$(date +%d-%m-%Y)

#sed -i -e "s|[0-9]\{,2\}-[0-9]\{,2\}-[0-9]\{4\}|${jour}|g" ./modules/MODULES_SEB.py

#cp ./modules/DOC/index.html ./

epydoc --html ./local/*.py -o ./modules/DOC_Program/ -v --graph all --inheritance grouped

#mv ./index.html ./modules/DOC/

#git commit -m "update DOC for MODULE_SEB" ./modules/DOC_Program/*

#scp ./modules/DOC/* admin@194.254.138.95:/volume1/web/DOC_Program/
