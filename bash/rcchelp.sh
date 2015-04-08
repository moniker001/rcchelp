#!/bin/bash
#!/bin/sh
# -------------------------------------------------------------------
#
# Research Computing Center
# The University of Chicago
# 6030 S. Ellis Ave, Suite 126
# Chicago, IL 60637
#
# Project  : Redo rcchelp
# Author   : Tejong Lim
# CNET     : limt
# Date     : Wed Apr 1, 2:14 CDT 2015
# Comments :
#
# -------------------------------------------------------------------

rcchelp () {
  case $1 in
    # rccsoftware
    software)
      echo "More information can be found in the online RCC documentation at https://rcc.uchicago.edu/docs/software/modules/index.html"
      module display $2 ;;
    
    # rccaccount
    accounts)
      if [ "$1" == "allocations" ]
        accounts allocations ;;
      elif [ "$1" == "balance" ]
        accounts balance ;;
      else [ "$1" == "usage" ]
        accounts usage ;;
    group-members)
      # TODO
    project-quota)
      project-quota $3 ;;
    quota)
      # TODO
    restore)
      # TODO
    user)
      phldap uid=$2 ;;
      # TODO - how to print groups
    # rccscheduler
    
    # rcchelp all
    
    # rcchelp search
    
  esac
}
