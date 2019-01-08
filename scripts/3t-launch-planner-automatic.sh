#!/bin/sh

/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/acl81/alisp -qq -e "(progn (load \"/home/andrewdo/.clinit.cl\") (load-system 'ap :compile t) (in-package :ap) (load \"ap:domains;CBRN;RTS-AI;IRAN.pddl\") (setf *problem* (first (problems *domain*))) (run-ap *problem*))"

# /var/lib/myfrdcsa/codebases/minor/3t-frdcsa/acl81/alisp -qq -e "(progn (load \"/home/andrewdo/.clinit.cl\") (in-package :cl-user) (load-system 'ap :compile t) (in-package :ap))"
# # (load \"ap:domains;CBRN;RTS-AI;IRAN.pddl\") (setf *problem* (first (problems *domain*))) (run-ap *problem*)
