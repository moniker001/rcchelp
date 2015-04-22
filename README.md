# Redo rcchelp

## Description

This is a personal repository for storing my work for **Redo rcchelp** project for the Research Computing Center at the University of Chicago.

## Functionalities

Here is a list of the current functionalities of `rcchelp`. We will determine which functionalities are to be kept, rewritten, or discarded.

* rccsoftware - software package specific documentation
  * ~~rcchelp $SOFTNAME~~ See `module display $SOFTNAME` and the [website documentation](https://rcc.uchicago.edu/docs/).
* rccaccount - account related documentation and actions
  * ~~`allocations`~~ See `accounts allocations`.*
  * ~~`balance`~~ See `accounts balance`.*
  * ~~`checkout`~~ Not really needed.*
  * ~~`group-members`~~ See `getent group [group]`.*
  * ~~`project-quota`~~ See `project-quota [project-directory]`.*
  * ~~`quota`~~ See `quota [-h][-u user]` or `gpfsquota [-h][-u user]`.*
  * ~~`restore`~~ See `restore [file] [[folder]]`.*
  * ~~`usage`~~ See `accounts usage`.*
  * ~~`user`~~ - See `phldap uid=[cnet]` and `group [cnet]`.*
* rccscheduler - scheduler (slurm) documentation and actions
  * ~~`gpu`~~ Just documentation. Should be on website.*
  * ~~`pi-depablo`~~ Just documentation for pi-depablo group. Should be on website.*
  * `qos` - See [Slurm docs on qos](http://slurm.schedmd.com/qos.html)
  * ~~`sarray`~~ Just documentation. Should be on website.*
  * ~~`sbatch` - Provides documentation for sbatch~~ See website documentation for [Using Midway](https://rcc.uchicago.edu/docs/using-midway/index.html).*
  * ~~`sepalmer`~~ Just documentation fo pi-sepalmer group. Should be on website.*
  * `sinfo` - See [Slurm docs on sinfo](http://www.schedmd.com/slurmdocs/sinfo.html)
  * ~~`sinteractive` - Provides documentation for sinteractive~~ See website documentation for [Using Midway](https://rcc.uchicago.edu/docs/using-midway/index.html).*
  * ~~`slurm` - Provides quick reference to slurm commands~~ See website documentation for [Using Midway](https://rcc.uchicago.edu/docs/using-midway/index.html).*
* `rcchelp all` - lists all commands available
* ~~`rcchelp search <regex>` - searches all commands for those matching search term~~ Not really needed.*

\*done and implemented

Here are the retained functionalities in the new `rcchelp` that have been implemented.

* `all`
* `allocations`
* `balance`
* `group-members`
* `project-quota`
* `quota`
* `restore`
* `usage`
* `user`
* `sinfo`

Here are the functionalities that are yet to be implemented.

* `qos`

## Resources

* [Project description on Redmine](https://w3.rcc.uchicago.edu/redmine/projects/rcc/wiki/Redo_rcchelp)
* [User guide for rcchelp](https://w3.rcc.uchicago.edu/redmine/projects/rcc/wiki/Rcchelp_User_Guide)
* [Help with bash](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html)
* [More help with bash](http://tldp.org/LDP/Bash-Beginners-Guide/html/index.html)
