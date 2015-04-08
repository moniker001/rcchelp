# Redo rcchelp

## Description

This is a personal repository for storing my work for **Redo rcchelp** project for the Research Computing Center at the University of Chicago.

## Functionalities

Here is a list of the current functionalities of `rcchelp`. We will determine which functionalities are to be kept, rewritten, or discarded.

* rccsoftware - software package specific documentation
  * ~~rcchelp $SOFTNAME~~ See `module display $SOFTNAME` and the [website documentation](https://rcc.uchicago.edu/docs/).
* rccaccount - account related documentation and actions
  * ~~allocations~~ See `accounts allocations`.*
  * ~~balance~~ See `accounts balance`.*
  * checkout
  * group-members
  * ~~project-quota~~ See `project-quota [project-directory]`.*
  * ~~quota~~ See `quota [-h][-u user]` or `gpfsquota [-h][-u user].`
  * restore
  * ~~usage~~ See `accounts usage`.*
  * user - See `phldap uid=<cnet>`. However, `phldap` does not display the groups the user is in.*
* rccscheduler - scheduler (slurm) documentation and actions
  * gpu
  * pi-debalo
  * qos
  * sarray
  * ~~sbatch - Provides documentation for sbatch~~ See website documentation for [Using Midway](https://rcc.uchicago.edu/docs/using-midway/index.html).
  * sepalmer
  * sinfo
  * ~~sinteractive - Provides documentation for sinteractive~~ See website documentation for [Using Midway](https://rcc.uchicago.edu/docs/using-midway/index.html).
  * slurm - Provides quick reference to slurm commands
* rcchelp all - lists all commands available
* rcchelp search <regex> - searches all commands for those matching search term

\*done

## Resources

* [Project description on Redmine](https://w3.rcc.uchicago.edu/redmine/projects/rcc/wiki/Redo_rcchelp)
* [User guide for rcchelp](https://w3.rcc.uchicago.edu/redmine/projects/rcc/wiki/Rcchelp_User_Guide)
* [Help with bash](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html)
* [More help with bash](http://tldp.org/LDP/Bash-Beginners-Guide/html/index.html)
