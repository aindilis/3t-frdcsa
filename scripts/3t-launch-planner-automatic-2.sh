#!/bin/sh

/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/acl81/alisp -e "(progn (defun split-re (arg1 arg2) \"\" (split-regexp arg1 arg2)) (defun replace-re (arg1 arg2 arg3) \"\" (replace-regexp arg1 arg2 arg3)) cl-user: (load-system 'ap :compile t) cl-user: (in-package :ap) ap: (load \"ap:domains;CBRN;RTS-AI;Iran.pddl\") (setf *problem* (first (problems *domain*))) (run-ap *problem*))"
