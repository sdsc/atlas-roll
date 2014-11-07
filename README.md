# SDSC "atlas" roll

## Overview

This Rocks roll bundles the ATLAS math package.

The Automatically Tuned Linear Algebra Software (ATLAS) focuses on applying
empirical techniques in order to provide portable performance. At present, it
provides C and Fortran77 interfaces to a portably efficient <a
href="http://www.netlib.org/blas/" target="_blank">BLAS</a> implementation, as
well as a few routines from <a href="http://www.netlib.org/lapack/"
target="_blank">LAPACK</a>.

For more information about ATLAS please visit the <a
href="http://math-atlas.sourceforge.net" target="_blank">official web page</a>.


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate atlas source file(s) using a machine that does have
Internet access and copy them into the `src/atlas` directory on your Rocks
development machine.



## Dependencies

cpufreq-set


## Building

To build the atlas-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `atlas-*.disk1.iso`.  If you built the
roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.

This roll source supports building with different compilers.
The `ROLLCOMPILER` make variable can be used to
specify the names of compiler modulefiles to use for building the
software, e.g.,

```shell
% make ROLLCOMPILER=intel 2>&1 | tee build.log
```

The build process recognizes "gnu", "intel" or "pgi" as the value for the
`ROLLCOMPILER` variable.  The default value is "gnu".

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

Note that the optimization techniques used by ATLAS dictate only installing the
package on systems with the same architecture and configuration as the build
machine.

In addition to the software itself, the roll installs ATLAS environment module
files in:

```shell
/opt/modulefiles/applications/atlas.
```


## Testing

The atlas-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To run
the test scripts execute the following command(s):

```shell
% /root/rolltests/atlas.t 
```
