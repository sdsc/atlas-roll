# SDSC "atlas" roll

## Overview

This Rocks roll bundles the ATLAS math package.

The Automatically Tuned Linear Algebra Software (ATLAS) focuses on applying empirical techniques in order to provide portable performance. At present, it provides C and Fortran77 interfaces to a portably efficient <a href="http://www.netlib.org/blas/" target="_blank">BLAS</a> implementation, as well as a few routines from <a href="http://www.netlib.org/lapack/" target="_blank">LAPACK</a>.

For more information about ATLAS please visit the <a href="http://math-atlas.sourceforge.net" target="_blank">official web page</a>.


## Requirements

To build/install this roll you must have root access to a Rocks development machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must download the appropriate atlas source file(s) using a machine that does have Internet access and copy them into the `src/atlas` directory on your Rocks development machine.



## Dependencies

Unknown at this time.


## Building

To build the atlas-roll, execute these instructions on a Rocks development machine (e.g., a frontend or development appliance):

```shell
% make default 2>&1 | tee build.log
% grep "RPM build error" build.log
```

If nothing is returned from the grep command then the roll should have been created as... `atlas-*.iso`. If you built the roll on a Rocks frontend then proceed to the installation step. If you built the roll on a Rocks development appliance you need to copy the roll to your Rocks frontend before continuing with installation.

This roll source supports building with different compilers and for different
network fabrics and mpi flavors.  By default, it builds using the gnu compilers
for openmpi ethernet.  To build for a different configuration, use the
`ROLLCOMPILER`, `ROLLMPI` and `ROLLNETWORK` make variables, e.g.,

```shell
make ROLLCOMPILER=intel ROLLMPI=mpich2 ROLLNETWORK=mx 
```

The build process currently supports one or more of the values "intel", "pgi",
and "gnu" for the `ROLLCOMPILER` variable, defaulting to "gnu".  It supports
`ROLLMPI` values "openmpi", "mpich2", and "mvapich2", defaulting to "openmpi".
It uses any `ROLLNETWORK` variable value(s) to load appropriate mpi modules,
assuming that there are modules named `$(ROLLMPI)_$(ROLLNETWORK)` available (e.g., `openmpi_ib`, `mpich2_mx`, etc.).

If the `ROLLCOMPILER`, `ROLLNETWORK` and/or `ROLLMPI` variables are specified, their values are incorporated into the names of the produced roll and rpms, e.g.,

```shell
make ROLLCOMPILER=intel ROLLMPI=mvapich2 ROLLNETWORK=ib
```
produces a roll with a name that begins "`atlas_intel_mvapich2_ib`"; it
contains and installs similarly-named rpms.

This roll also supports the `ROLLOPTS` make variable.  If it contains 'avx',
options are passed to the compiler to produce AVX instructions.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll atlas
% cd /export/rocks/install
% rocks create distro
% rocks run roll atlas | bash
```

Note that the optimization techniques used by ATLAS dictate only installing
the package on systems with the same architecture and configuration as the
build machine.

In addition to the software itself, the roll installs ATLAS environment module
files in:

```shell
/opt/modulefiles/applications/.(compiler)/atlas.
```


## Testing

The atlas-roll includes a test script which can be run to verify proper installation of the atlas-roll documentation, binaries and module files. To run the test scripts execute the following command(s):

```shell
% /root/rolltests/atlas.t 
ok 1 - atlas is installed
ok 2 - atlas test run
ok 3 - atlas module installed
ok 4 - atlas version module installed
ok 5 - atlas version module link created
1..5
```


