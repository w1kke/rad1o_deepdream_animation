#!/usr/bin/env perl

# lcd2ani.pl - by <sec@42.org> 08/2015, BSD Licence
#
# This script creates an ani from .lcd's

use strict;
use warnings;
use Getopt::Long;
use Module::Load;

$|=1;

###
### Runtime Options
###

my ($verbose);
my ($mode);
my ($header);

$mode=12;

GetOptions (
            "verbose"   => \$verbose, # flag
			"help"     => sub {
			print <<HELP;
Uasge: lcd2an.pl [-v] <outfile> {<infile> <delaytime>}*

Options:
--verbose       Be verbose.
HELP
			exit(-1);}
			);

###
### Code starts here.
###

my $out=shift ||"sample.ani";


### count the number of pictures to let the one with the nick appear longer, it is the 10th picture

my $count = 0;

open(O,">",$out)||die;
while ($#ARGV>0){
    my $in=shift;
    my $delay=shift;
    if ($count == 10 || $count == 0) {
        $delay=20*$delay;
    }

    if($verbose){
        print "Adding $in for $delay ms\n";
    };
    print O pack("S",$delay);
    open(F,"<",$in)||die;
    { local $/=undef; print O <F>; };
    close(F);
    $count++;
};

close(O);
