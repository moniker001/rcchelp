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
  case "$1" in
    # Displays information about specified software
    software)
      echo "-------------------------------------------------------------------"
      echo
      echo "  More information can be found in the online RCC documentation    "
      echo "  https://rcc.uchicago.edu/docs/software/modules/index.html        "
      echo
      module display $2
      ;;

    # Displays your allocations of SUs
    allocations)
      accounts allocations
      ;;
      
    # Displays your remaining balance of SUs 
    balance)
      accounts balance
      ;;
    
    # Displays your consumption of SUs
    usage)
      accounts usage
      ;;
      
    # Displays all members in specified group  
    group-members)
      getent group $2
      ;;
      
    # Displays quota information for project folder
    project-quota)
      project-quota $2
      ;;
    
    # Displays your file system usage and limits
    quota)
      quota $2
      ;;
    
    # Restores a file to a given folder or (by default) the file's original location based on a snapshot
    restore)
      restore $2 $3
      ;;
    
    # Displays detailed infomation on specified user
    user)
      phldap uid=$2
      groups $2
      ;;

    # rccscheduler
    qos)
      echo TODO
      ;;
    sinfo)
      echo TODO
      ;;

    # Displays list of all rcchelp commands
    all)
      clear
      echo '-------------------------------------------------------------------------------'
      echo ' *      The University of Chicago Research Computing Center Help System      * '
      echo '-------------------------------------------------------------------------------'
      echo '        All commands are preceded by "rcchelp"                                 '
      echo '        Some commands may only work on Midway, such as "quota"                 '
      echo '-------------------------------------------------------------------------------'
      echo '        Command              Description                                       '
      echo
      echo '        all                  Displays list of all rcchelp commands             '
      echo '                             "rcchelp all"                                     '
      echo
      echo '        allocations          Displays your allocations of SUs                  '
      echo '                             "rcchelp allocations"                             '
      echo
      echo '        balance              Displays your remaining balance of SUs            '
      echo '                             "rcchelp balance"                                 '
      echo
      echo '        group-members        Displays all members in specified group           '
      echo '                             "rcchelp group-members [RCC group name]"          '
      echo
      echo '        project-quota        Displays quota information for project folder     '
      echo '                             "rcchelp project-quota [project directory]"       '
      echo
      echo '        quota                Displays your file system usage and limits        '
      echo '                             "rcchelp user [cnet id]"                          '
      echo
      echo '        restore              Restores a file to a given folder or (by default) '
      echo "                             the file's original location based on a snapshot  "
      echo '                             "rcchelp restore [file] [[destination]]"          '
      echo '        usage                Displays your consumption of SUs                  '
      echo '                             "rcchelp usage"                                   '
      echo
      echo '        user                 Displays detailed infomation on specified user    '
      echo '                             "rcchelp user [cnet id]"                          '
      echo '-------------------------------------------------------------------------------'
    ;;
    
    *)
      echo "Error: \"rcchelp $1\" is not a valid command"
      echo "See \"rcchelp all\" for list of commands"
      ;;
      
  esac
}

rcchelp $1 $2


