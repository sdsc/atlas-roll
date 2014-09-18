#!/usr/bin/perl -w
# atlas roll installation test.  Usage:
# atlas.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $output;
my @COMPILERS = split(/\s+/, 'ROLLCOMPILER');
my $TESTFILE = 'tmpatlas';

my %CC = ('gnu' => 'gcc', 'intel' => 'icc', 'pgi' => 'pgcc');

open(OUT, ">${TESTFILE}.c");
print OUT <<END;
#include <stdio.h>
#include <cblas.h>
int
main(int argc, char** argv) {

  float v1[5] = {1.0, 3.0, 5.0, 7.0, 9.0};
  float v2[5] = {10.0, 8.0, 6.0, 4.0, 2.0};
  /*             10 + 24 + 30 + 28 + 18 = 110 */

  float dp = cblas_sdot(5, v1, 1, v2, 1);
  printf("%f\\n", dp);
  return dp == 110 ? 0 : 1;

}
END

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
module load \$1 atlas
export LD_LIBRARY_PATH=\$ATLASHOME/lib:\$LD_LIBRARY_PATH
\$2 -I \$ATLASHOME/include -o $TESTFILE.exe $TESTFILE.c -L \$ATLASHOME/lib -lcblas -latlas
./$TESTFILE.exe
END

# atlas-install.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok(-d "/opt/atlas", "atlas installed");
} else {
  ok(! -d "/opt/atlas", "atlas not installed");
}

my $packageHome = '/opt/atlas';
foreach my $compiler(@COMPILERS) {

  SKIP: {

    skip "atlas/$compiler not installed", 5 if ! -d "$packageHome/$compiler";

    $output = `bash $TESTFILE.sh $compiler $CC{$compiler} 2>&1`;
    ok(-f "$TESTFILE.exe", "compile/link with atlas/$compiler");
    like($output, qr/110/, "run with atlas/$compiler");
    `/bin/rm $TESTFILE.exe`;
  
    `/bin/ls /opt/modulefiles/applications/.$compiler/atlas/[0-9]* 2>&1`;
    ok($? == 0, "atlas module installed");
    `/bin/ls /opt/modulefiles/applications/.$compiler/atlas/.version.[0-9]* 2>&1`;
    ok($? == 0, "atlas version module installed");
    ok(-l "/opt/modulefiles/applications/.$compiler/atlas/.version",
       "atlas version module link created");

  }

}

`rm -fr $TESTFILE*`;
