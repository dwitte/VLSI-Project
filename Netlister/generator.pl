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
	$line =~ s/^\s*(.*)\s*$/$1/;
	$line =~ s/^(.*)\s\s(.*)$/$1 $2/g;
	$line =~ s/^\/\/.*$//;
	$line =~ s/\s*([;,=\{\}\(\)\[\]])\s*/ $1 /g;
	$line =~ s/ +/ /g;
	@tokens = split(/ /, $line);
	foreach my $token (@tokens)
	{
		push(@all_tokens, $token);
	}
}

close (componentfile);

foreach my $token (@all_tokens)
{
	if($token =~ /\/\*/)
	{
		$in_comment = 1;
	}
	elsif ($token =~ /\*\// and $in_comment eq 1)
	{
		$in_comment = 0;
		next;	
	}
	
	if($in_comment ne 1)
	{
		push(@clean_tokens, $token);;
	}
}

#Write all components to the output netlist file.
open (netlistfile, ">../chips/$platform/netlists/$component.net");

#Get input
$token = shift(@clean_tokens);
if($token eq "CHIP")
{
	#Call Chip function
	parse_Chip();
}
else
{
	#Throw error
	print "$token\n";
}

close (netlistfile);

sub parse_Chip
{
	
	$token = shift(@clean_tokens);
	print netlistfile "$token Netlist file\n";
	$token = shift(@clean_tokens);
	print netlistfile "Pins\n{\n";

	$token = shift(@clean_tokens);
	if($token eq "IN")
	{
		#call Input Pin Funciton
		parse_Inputs();
	}
	else
	{
		#Throw Error
	}
	
	$token = shift(@clean_tokens);
	if($token eq "OUT")
	{
		#call Output PIn Function
		parse_Outputs();
	}
	else
	{
		#Throw error
	}

	print netlistfile "}\n\nParts\n{\n";
	$token = shift(@clean_tokens);
	if($token eq "Parts:" )
	{
		#call Parts Function;
		parse_Parts();
	}
	print netlistfile "}\n\n";
}

sub parse_Inputs
{
	while($token ne ";")
	{
		$token = shift(@clean_tokens);
		local $pin = $token;
		$token = shift(@clean_tokens);
		if($token eq '[')
		{
			$token = shift(@clean_tokens);
			local $array_count = $token;
			for($i = 0; $i < $array_count; $i++)
			{
				print netlistfile "\t$pin\[$i\] input \n";
			}
			$token = shift(@clean_tokens);
		}
		elsif($token eq ',')
		{
			print netlistfile "\t$pin\n";
		}
		else
		{
			#Throw Error
		}
		$token = shift(@clean_tokens);
	}
}

sub parse_Outputs
{
	while($token ne ";")
	{
		$token = shift(@clean_tokens);
		local $pin = $token;
		$token = shift(@clean_tokens);
		if($token eq '[')
		{
			$token = shift(@clean_tokens);
			local $array_count = $token;
			for($i = 0; $i < $array_count; $i++)
			{
				print netlistfile "\t$pin\[$i\] output \n";
			}
			$token = shift(@clean_tokens);
		}
		elsif($token eq ',')
		{
			print netlistfile "\t$pin\n";
		}
		else
		{
			#Throw Error
		}
		$token = shift(@clean_tokens);
	}
}

sub parse_Parts
{
	
}
