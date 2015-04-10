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
    allocations)
      accounts allocations ;;
    balance)
      accounts balance ;;
    usage)
      accounts usage ;;
    group-members)
      # TODO
    project-quota)
      project-quota $2 ;;
    quota)
      quota $2 ;;
    restore)
      # TODO
    user)
      phldap uid=$2 ;;
      # TODO - how to print groups
    # rccscheduler

    all)
      clear
      echo '        The University of Chicago Research Computing Center Help System        '
      echo '-------------------------------------------------------------------------------'
      echo '        All commands are preceded by "rcchelp"                                 '
      echo '-------------------------------------------------------------------------------'
      echo '        Command              Description                                       '
      echo
      echo '        allocations          Displays your allocations of SUs                  '
      echo '                             "rcchelp allocations"                                   '
      echo
      echo '        balance              Displays your remaining balance of SUs            '
      echo '                             "rcchelp balance"                                 '
      echo
      echo '        usage                Displays your consumption of SUs                  '
      echo '                             "rcchelp usage"                                   '
      echo
      echo '        user                 Displays detailed infomation on specified user    '
      echo '                             "rcchelp user [cnet id]"                          '
      echo
      echo '        project-quota        Displays quota information for project folder     '
      echo '                             "rcchelp project-quota [project directory]"       '
      echo
      echo '        quota                Displays your file system usage and limits        '
      echo '                             "rcchelp user [cnet id]"                          '
      echo
    
    
  esac
}
