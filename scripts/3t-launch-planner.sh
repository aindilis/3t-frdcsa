#!/bin/sh

/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/acl81/alisp -e "(load-system 'ap :compile t)"

# # then run these

# cl-user: (load-system 'ap :compile t)
# cl-user: (in-package :ap)
# ap: (load-pddl)
