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
  echo "        All commands are preceded by \"rcchelp\". Some commands may only       "
  echo "        work on Midway, such as \"quota\" and \"project-quota\".               "
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
  echo "                             Set options to \"-v\" for verbose display         "
  echo "                             \"rcchelp qos [[option]]\"                        "
  echo
  echo "        quota                Displays your file system usage and limits        "
  echo "                             \"rcchelp user [cnet id]\"                        "
  echo
  echo "        restore              Restores a file to a given folder or (by default) "
  echo "                             the file's original location based on a snapshot  "
  echo "                             \"rcchelp restore [file] [[destination]]\"        "
  echo
  echo "        sinfo                Displays information on available Slurm queues    "
  echo "                             Set options to \"-v\" for verbose display         "
  echo "                             \"rcchelp sinfo [[option]]\"                      "
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

# Displays quota information for project folder
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

getPrefix () {
  info=$(echo $1 | cut --fields=$2 --delimiter=':')
  if [ ${#info} -gt 0 ]; then
    if echo "$info" | grep -q "cn"; then
      echo "        Name        :"
    elif echo "$info" | grep -q "title"; then
      echo "        Title       :"
    elif echo "$info" | grep -q "eduPersonPrimaryAffiliation"; then
      echo "        Affiliation :"
    elif echo "$info" | grep -q "uid"; then
      echo "        Cnet ID     :"
    elif echo "$info" | grep -q "ucDepartment"; then
      echo "        Department  :"
    elif echo "$info" | grep -q "chicagoID"; then
      echo "        Chicago ID  :"
    elif echo "$info" | grep -q "telephoneNumber"; then
      echo "        Phone       :"
    elif echo "$info" | grep -q "mail"; then
      echo "        Email       :"
    fi
  fi
}

removeLast () {
  info=$(echo $1 | cut --fields=$2 --delimiter=':')
  if [ ${#info} -gt 0 ]; then
    field1=$(echo $info | cut --field=1 --delimiter=' ')
    if [[ $info == *"@uchicago.edu"* ]]; then
      result=$field1
      echo $result
      return
    fi
    field2=$(echo $info | cut --field=2 --delimiter=' ')
    space=" "
    result=$field1$space$field2
    if [ ${#field2} -gt 0 ]; then
      i=3
      j=4
      while true; do
        field3=$(echo $info | cut --field=$i --delimiter=' ')
        if [ ${#field3} -le 0 ]; then
          result=$field1
          break
        fi
        field4=$(echo $info | cut --field=$j --delimiter=' ')
        if [ ${#field4} -le 0 ]; then
          break
        fi
        result=$result$space$field3
        i=$(($i+1))
        j=$(($j+1))
      done
    else
      echo "Error: empty field"
    fi
  fi
  echo $result
}

# Displays detailed infomation on specified user
printUser () {
  # Obtain phldap data on user
  user="$(phldap uid="$1")"

  if [ ${#user} -gt 0 ]; then
    # print out user info until email
    for i in `seq 2 10`;
    do
      j=$(($i+1))
      output=$(echo "$(getPrefix "$user" $i) $(removeLast "$user" $j)")
      if [ ${#output} -gt 1 ]; then
        echo "$output"
      fi
    done
    
    # Print names of groups
    groupinfo=$(groups $1)
    group1=$(echo $groupinfo | cut --fields=3 --delimiter=' ')
    if [ ${#group1} -gt 0 ]; then
      groupnum=$(getent group $group1 | cut --fields=3 --delimiter=':')
      echo "        Member of   : $groupnum($group1)"
      i=4
      while true; do
        group2=$(echo $groupinfo | cut --fields=$i --delimiter=' ')
        if [ ${#group2} -le 0 ]; then
          break
        fi
        groupnum2=$(getent group $group2 | cut --fields=3 --delimiter=':')
        echo "                      $groupnum2($group2)"
        i=$(($i+1))
      done
    else
      echo "        Member of   : No RCC groups"
    fi
  else
    # User not found
    echo "        No user found in the UChicago Directory with that username"
    echo "        Usage:"
    echo "                rcchelp user <username / CNET ID>"
  fi
}

# Restores a file to a given folder or (by default) the file's original location based on a snapshot
printRestore () {
  #TODO
  echo "        To guard against accidental deletion of files, the Home/Project        "
  echo "        partition is snapshotted hourly, daily, and weekly. Snapshots          "
  echo "        are located in /snapshots on Midway. In order to restore a file        "
  echo "        from a snapshot, either:                                               "
  echo "        (a) copy manually from the snapshots directory, or                     "
  echo "        (a) run \"rcchelp restore [file] [[snapshot dir]] [[-r]]\" in          "
  echo "            the folder where the file was originally located                   "
  echo "        By default, the \"rcchelp restore\" command will restore from          "
  echo "        the most recent hourly snapshot, unless the snapshot folder is         "
  echo "        specified.                                                             "
  
  current=$(pwd)
  if [[ $current == *"project"* ]]; then
    dir="project"
  elif [[ $current == *"home"* ]]; then
    dir="home"
  else
    echo "Current directory is not in \"project\" or \"home\""
  fi
  
  allsnapshots=$(cd /snapshots/home ; ls)
  if [[ $allsnapshots == *$2* ]]; then
    snapshot="$2"
  else
    snapshot=$(echo $allsnapshots | cut --field=11 --delimiter=' ')
  fi
  path=/snapshots/$dir/$snapshot$current
  printFooter
  
  echo
  echo "As long as no errors occur, will attempt to restore file from:"
  echo "  $path/$1"
  echo "to the current working directory as:"
  echo "  $current/$1"
  echo
  read -p "Are you sure this is correct [y/n]? " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  else
    if [ $3 != "-r" ] && [ $2 != "-r" ] ; then
      cp $path/$1 $current/$1
    else
      cp -r $path/$1 $current/$1
  fi

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
      printSoftware "$2"
      printFooter ;;
    allocations)
      printAllocations
      printFooter ;;
    balance)
      printBalance
      printFooter ;;
    usage)
      printUsage
      printFooter ;;
    group-members)
      printGroup "$2"
      printFooter ;;
    project-quota)
      printPQuota "$2"
      printFooter ;;
    quota)
      printQuota "$2"
      printFooter ;;
    restore)
      printRestore "$2" "$3" "$4" ;;
    user)
      printUser "$2"
      printFooter ;;
    qos)
      printQos "$2"
      printFooter ;;
    sinfo)
      printSinfo "$2"
      printFooter ;;
    all)
      printAll
      printFooter ;;
    *)
      # Display list of rcchelp commands for bad commands
      printAll
      printFooter ;;
  esac
}

# Call function with input parameters
rcchelp "$1" "$2" "$3" "$4"

