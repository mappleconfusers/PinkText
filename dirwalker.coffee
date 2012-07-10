#
# File:   dirwalker.coffee
# Author: Karolin Varner
# Date:   7/1/2012
#
# This file provides a lib for asynchroniously walking directories.
# 
##########################################################
#
# This file is part of PinkText.
#
# PinkText is free software: you can redistribute it and/or modify
# it under the terms of the Lesser GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# PinkText is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# Lesser GNU General Public License for more details.
#
# You should have received a copy of the Lesser GNU General Public License
# along with PinkText.  If not, see <http://www.gnu.org/licenses/>.
#
#        

fs   = require 'fs'
path = require 'path'
util = require 'util'
F    = require 'F'

###############################
# TESTER

#
# Check if the file is a dir
# 
isDir = (o) ->
    fs.statSync(o).isDirectory() if fs.exists o

#
# Check if the file is a document
# 
isFile = (o) ->
    fs.statSync(o).isFile() if fs.exists o

#
# Check if the name matches the expression
# 
nameMatch = (n, p) -> (path.basename n).match p

#
# Check if the path matches
# 
fileMatch= (f1, f2) -> (fs.realpathSync f1) == (fs.realpathSync f2)

###############################
# Fun

walk_dir = (dir, preq, f, rel='') ->
    fs.readdir dir, F.NOERR (files, bar) ->
        for o in files
            p = (path.join dir, o)
            r = (path.join rel, o)
        
            f p, r if preq  o
            if isDir o
                walk_dir p, preq, f

###############################
# Export

exports.isDir = isDir
exports.isFile = isFile
exports.nameMatch = nameMatch
exports.fileMatch = fileMatch
exports.match     = nameMatch

exports.walk_dir = walk_dir
exports.walk     = walk_dir
