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

printHeader () {
  clear
  echo "-------------------------------------------------------------------------------"
  echo " *      The University of Chicago Research Computing Center Help System      * "
  echo "-------------------------------------------------------------------------------"
}

printFooter () {
  echo "-------------------------------------------------------------------------------"
  echo " *      Please contact help@rcc.uchicago.edu with any questions              * "
  echo "-------------------------------------------------------------------------------"
}

# Displays list of all rcchelp commands
printAll () {
  echo "        All commands are preceded by \"rcchelp\"                               "
  echo "        Some commands may only work on Midway, such as \"quota\"               "
  echo "-------------------------------------------------------------------------------"
  echo "        COMMAND              DESCRIPTION                                       "
  echo
  echo "        all                  Displays list of all rcchelp commands             "
  echo "                             \"rcchelp all\"                                   "
  echo
  echo "        allocations          Displays your allocations of SUs                  "
  echo "                             \"rcchelp allocations\"                           "
  echo
  echo "        balance              Displays your remaining balance of SUs            "
  echo "                             \"rcchelp balance\"                               "
  echo
  echo "        group-members        Displays all members in specified group           "
  echo "                             \"rcchelp group-members [RCC group name]\"        "
  echo
  echo "        project-quota        Displays quota information for project folder     "
  echo "                             \"rcchelp project-quota [project directory]\"     "
  echo
  echo "        qos                  Displays information on Slurm QoS                 "
  echo "                             \"rcchelp qos\"                                   "
  echo
  echo "        quota                Displays your file system usage and limits        "
  echo "                             \"rcchelp user [cnet id]\"                        "
  echo
  echo "        restore              Restores a file to a given folder or (by default) "
  echo "                             the file's original location based on a snapshot  "
  echo "                             \"rcchelp restore [file] [[destination]]\"        "
  echo
  echo "        sinfo                Displays information on available Slurm queues    "
  echo "                             \"rcchelp sinfo [[options]]\"                     "
  echo
  echo "        usage                Displays your consumption of SUs                  "
  echo "                             \"rcchelp usage\"                                 "
  echo
  echo "        user                 Displays detailed infomation on specified user    "
  echo "                             \"rcchelp user [cnet id]\"                        "
}

# Displays your allocations of SUs
printAllocations () {
  accounts allocations
}

# Displays your remaining balance of SUs 
printBalance () {
  accounts balance
}

# Displays information about specified software
printSoftware () {
  echo "        More information can be found in the online RCC documentation          "
  echo "        https://rcc.uchicago.edu/docs/software/modules/index.html              "
  module display $1
}

# Displays all members in specified group
printGroup () {
  info=$(getent group $1)
  groupname=$(echo $info | cut --fields=1 --delimiter=':')
  if [ ${#groupname} -gt 0 ]; then
    echo "        Group Name    : $groupname"
    groupid=$(echo $info | cut --fields=3 --delimiter=':')
    echo "        Group ID      : $groupid"
    members=$(echo $info | cut --fields=4 --delimiter=':')
    member=$(echo $members | cut --fields=1 --delimiter=',')
    echo "        Group Members : $member"
    i=2
    while true; do
      member=$(echo $info | cut --fields=$i --delimiter=',')
      echo "                        $member"
      if [ ${#member} -le 0 ]; then
        break
      fi
      i=$(($i+1))
    done
  else
    echo "        No RCC groups found with that name or group ID"
    echo "        Usage:"
    echo "                rcchelp group-members <group name or gid>"
  fi
}

printPQuota () {
  project-quota $1
}

# Displays your file system usage and limits
printQuota () {
  quota $1
}

# Displays your consumption of SUs
printUsage () {
  accounts usage
}

# Displays detailed infomation on specified user
printUser () {
  # TODO - formatting
  userinfo=$(phldap uid=$1)
  if [ ${#userinfo} -gt 0 ]; then
    echo $userinfo
    echo "---"
    # print user information
    info1=$(echo $userinfo | cut --fields=3 --delimiter=':')
    echo ${info1:0:-5}
    echo "---"

    # print names of groups
    groupinfo=$(groups $1)
    group1=$(echo $groupinfo | cut --fields=3 --delimiter=' ')
    if [ ${#group1} -gt 0 ]; then
      echo "        Member of  : $group1"
      i=4
      while true; do
        group2=$(echo $groupinfo | cut --fields=$i --delimiter=' ')
        echo "                     $group2"
        if [ ${#group2} -le 0 ]; then
          break
        fi
        i=$(($i+1))
      done
    else
      echo "        Member of  : No RCC groups"
    fi
  else
    echo "        No user found in the UChicago Directory with that username"
    echo "        Usage:"
    echo "                rcchelp user <username / CNET ID>"
  fi
}

# Restores a file to a given folder or (by default) the file's original location based on a snapshot
printRestore () {
  #TODO
  restore $1 $2
}

# Displays information on available Slurm queues
printSinfo () {
  echo "        See online Slurm documentation for more information on \"sinfo\"       "
  echo "        https://computing.llnl.gov/linux/slurm/sinfo.html                      "
  echo "-------------------------------------------------------------------------------"
  case "$1" in
  -v)
    # verbose display
    sinfo --long
    # TODO - add more sinfo options
    ;;
  *)
    # default display
    sinfo -o "%9P %R %6D %3c %7g %28f %22N"
    ;;
  esac
}

# Displays information on Slurm QoS
printQos () {
  echo "        See online Slurm documentation for more information                    "
  echo "        https://computing.llnl.gov/linux/slurm/sacctmgr.html                   "
  echo "        http://slurm.schedmd.com/qos.html                                      "
  echo "-------------------------------------------------------------------------------"
  case "$1" in
    -v)
     # verbose display
      sacctmgr show qos
      ;;
    *)
      # default display
      sacctmgr show qos format=name,MaxNodes,MaxCPUs,MaxCPUsPerUser,MaxNodesPerUser,MaxJobsPerUser%7,MaxSubmitJobsPerUser%9,MaxWallDurationPerJob
      echo "-------------------------------------------------------------------------------"
      echo " *      QOS Table Definitions                                                * "
      echo "-------------------------------------------------------------------------------"
      echo "        COLUMN             DESCRIPTION                                         "
      echo
      echo "        MaxNodes           Maximum number of nodes that each job can use       "
      echo
      echo "        MaxCPUs            Maximum number of CPUs that each job can use        "
      echo
      echo "        MaxCPUsPU          Maximum total number of CPUs each user can use      "
      echo
      echo "        MaxNodesPU         Maximum total number of nodes each user can use     "
      echo
      echo "        MaxJobs            Maximum number of jobs each user can have running   "
      echo
      echo "        MaxSubmit          Maximum number of jobs each user can have submitted "
      echo
      echo "        MaxWall            Maximum wall clock time each job can use            "
      echo "                           (days-hours:minutes:seconds)                        "
      ;;
  esac
}

rcchelp () {
  printHeader
  case "$1" in
    software)
      printSoftware $2 ;;
    allocations)
      printAllocations ;;
    balance)
      printBalance ;;
    usage)
      printUsage ;;
    group-members)
      printGroup $2 ;;
    project-quota)
      printPQuota $2 ;;
    quota)
      printQuota $2 ;;
    restore)
      printRestore $2 $3 ;;
    user)
      printUser $2 ;;
    qos)
      printQos $2 ;;
    sinfo)
      printSinfo $2 ;;
    all)
      printAll ;;
    *)
      # Display list of rcchelp commands for bad commands
      printAll ;;
  esac
  printFooter
}

# Call function with input parameters
rcchelp $1 $2

