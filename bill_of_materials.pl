#!/usr/bin/perl

# file to modify 
$file = $ARGV[0];

# initial rowspan
$rowspan = 5;

#Open the file and read data
#Die with grace if it fails
open (FILE, "<$file") or die "Can't open $file: $!\n";
@lines = <FILE>;
close FILE;
#Open same file for writing, reusing STDOUT
open (STDOUT, ">$file") or die "Can't open $file: $!\n";


#Walk through lines, putting into $_, and substitute 2nd away
for ( @lines ) {
    s/<col width="100%" \/>/<col width="20%" \/>/;


    if (s/<td align="left">/<td align="left" rowspan="$rowspan">/) {
	$rowspan--;
	if ($rowspan == 0 ) {
	    $rowspan = 5;
	}
    }
    if(/<\/table>/ ) {
	$rowspan = 5;
    }
    print;
}



#Finish up
close STDOUT;
