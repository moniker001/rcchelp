# Redo rcchelp

## Description

This is a personal repository for storing my work for **Redo rcchelp** project for the Research Computing Center at the University of Chicago.

## Functionalities

Here is a list of the current functionalities of `rcchelp`. We will determine which functionalities are to be kept, rewritten, or discarded.

* ~~rccsoftware - software package specific documentation~~ Documentation already exists on [website](http://docs.rcc.uchicago.edu) and with `module display $SOFTNAME.`
  * ~~R~~
  * ~~c~~
  * ~~cp2k~~
  * ~~fftw~~
  * ~~gaussian~~
  * ~~gcc~~
  * ~~getpdb~~
  * ~~gnuplot~~
  * ~~gromacs~~
  * ~~gromacs-plumed~~
  * ~~hoomd~~
  * ~~lammps~~
  * ~~matlab~~
  * ~~matlab-parallel~~
  * ~~mpi~~
  * ~~mpi4py~~
  * ~~namd~~
  * ~~netcdf~~
  * ~~openfoam~~
  * ~~pgi~~
  * ~~python~~
  * ~~stata~~
* rccaccount - account related documentation and actions
  * ~~allocations~~ See `accounts allocations`.
  * ~~balance~~ See `accounts balance`.
  * checkout
  * group-members
  * ~~project-quota~~ See `project-quota [project-directory]`.
  * ~~quota~~ See `quota [-h][-u user]`.
  * restore
  * ~~usage~~ See `accounts usage`.
  * user - See `phldap uid=<cnet>`. However, `phldap` does not display the groups the user is in.
* rccscheduler - scheduler (slurm) documentation and actions
  * gpu
  * pi-debalo
  * quo
  * sarray
  * sbatch
  * sepalmer
  * sinfo
  * sinteractive
  * slurm
* rcchelp all - lists all commands available
* rcchelp search <regex> - searches all commands for those matching search term

## Resources

* [Project description on Redmine](https://w3.rcc.uchicago.edu/redmine/projects/rcc/wiki/Redo_rcchelp)
* [User guide for rcchelp](https://w3.rcc.uchicago.edu/redmine/projects/rcc/wiki/Rcchelp_User_Guide)
* [Help with bash](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html)
* [More help with bash](http://tldp.org/LDP/Bash-Beginners-Guide/html/index.html)
