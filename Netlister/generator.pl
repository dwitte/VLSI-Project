#!/usr/local/bin/perl

#The usage of this script is to generate the netlists for a component for a certain platform

my @params = @ARGV;
my $platform = $params[0];
my $component = $params[1];

my $file = "../chips/$platform/$component.hdl";

#my @all_tokens;

print "Accessing $file \n";

open (componentfile, $file);

while (<componentfile>)
{
	chomp;
	$line = $_;
	$line =~ s/(.*)\((.*)/$1 \( $2/;
	$line =~ s/(.*)\)(.*)/$1 \) $2/;
	$line =~ s/(.*),(.*)/$1 , $2/;
	$line =~ s/^\s*(.*)\s*$/$1/;
	@tokens = split(/ /, $line);
	foreach my $token (@tokens)
	{
		if($token ne "\n" or $token ne " " or $token ne "")
		{
#			push(@all_tokens, $token);
			print "$token\n";
		}
	}
}

close (componentfile);

