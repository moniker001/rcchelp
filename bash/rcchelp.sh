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
# Comments : Some commands may only work on Midway,such as "quota" 
#            and "project-quota".
#
# -------------------------------------------------------------------

#$LOGFILE = "/rcchelp.log"

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
      clear
      phldap uid=$2
      groups $2
      ;;
    
    # Displays information on Slurm QoS
    qos)
      # TODO
      echo TODO
      ;;
    
    # Displays information on available Slurm queues
    sinfo)
      # TODO
      clear
      echo '-------------------------------------------------------------------------------'
      echo ' *      The University of Chicago Research Computing Center Help System      * '
      echo '-------------------------------------------------------------------------------'
      echo '        See online Slurm documentation for more information on "sinfo"         '
      echo '        https://computing.llnl.gov/linux/slurm/sinfo.html                      '
      echo '-------------------------------------------------------------------------------'
      case "$2" in
      # condensed display
      -s)
        sinfo -o "%9P %6D %3c %7g %28f %22N"
        ;;
      # verbose display
      -v)
        sinfo --long
        # TODO - add more sinfo options
        ;;
      # default is condensed
      *)
        sinfo -o "%9P %6D %3c %7g %28f %22N"
        ;;
      esac
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
      echo '        COMMAND              DESCRIPTION                                       '
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
      echo '        qos                  Displays information on Slurm QoS                 '
      echo '                             "rcchelp qos"                                     '
      echo
      echo '        quota                Displays your file system usage and limits        '
      echo '                             "rcchelp user [cnet id]"                          '
      echo
      echo '        restore              Restores a file to a given folder or (by default) '
      echo "                             the file's original location based on a snapshot  "
      echo '                             "rcchelp restore [file] [[destination]]"          '
      echo
      echo '        sinfo                Displays information on available Slurm queues    '
      echo '                             "rcchelp sinfo [[options]]"                         '
      echo
      echo '        usage                Displays your consumption of SUs                  '
      echo '                             "rcchelp usage"                                   '
      echo
      echo '        user                 Displays detailed infomation on specified user    '
      echo '                             "rcchelp user [cnet id]"                          '
      echo '-------------------------------------------------------------------------------'
    ;;
    
    *)
      echo "Error: \"rcchelp $1 $2\" is not a valid command"
      echo "See \"rcchelp all\" for list of commands"
      ;;
      
  esac
}

# Call function with parameters
rcchelp $1 $2



