#!/usr/local/bin/perl

#The usage of this script is to generate the netlists for a component for a certain platform

my @params = @ARGV;
my $platform = $params[0];
my $component = $params[1];

my $file = "../chips/$platform/$component.hdl";
my $inputY = 0;
my $inputX = 0;
my $outputY = 0;
my $outputX = 0;
my %cellCounter = ();

#my @all_tokens;

print "Accessing $file \n";

open (componentfile, $file);

print "Reading in tokens\n";

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

print "Read in all tokens\n";

close (componentfile);

foreach my $token (@all_tokens)
{
	print "$token\n";
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

print "Opening the output netlist file.";

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
	if($token eq "PARTS:" )
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
				print netlistfile "\t$pin\[$i\] input $inputX $inputY\n";
				$inputY += 5;
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
				print netlistfile "\t$pin\[$i\] output $outputX $outputY\n";
				$outputY += 5;
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
	print netlistfile "\tNets\n";
	print netlistfile "\t{\n";
	while($token ne "}")
	{
		$token = shift(@clean_tokens);
		if($token eq "")
		{
			print netlistfile "\t}\n";

			print netlistfile "\tCells\n";
			print netlistfile "\t{\n";
			for my $key ( keys %cellCounter )
			{
				local $number = 0;
				print "$cellCounter{$key}";
				while ($number lt $cellCounter{$key})
				{
					print netlistfile "\t\t$key\_$number\n";
					$number = $number +1;
				}
			}
			print netlistfile "\t}\n";

			return;
		}
		local $part = $token;
		if($cellCounter{$part} eq '')
		{
			$cellCounter{$part} = 0;
		}
		else
		{
			$cellCounter{$part} = $cellCounter{$part} + 1;
		}
		$token = shift(@clean_tokens); ### Should be '('
		while($token ne "\)")
		{
			$token = shift(@clean_tokens); ### Get first pin name of chip.
			local $partsPinName = $token;
			$token = shift(@clean_tokens); ### Should be '='
			$token = shift(@clean_tokens); ### Get the local pin name.
			local $pinName = $token;
			$token = shift(@clean_tokens);
			if($token eq "\[")
			{
				$token = shift(@clean_tokens);
				local $index = $token;
				print netlistfile "\t\t$part\_$cellCounter{$part} $partsPinName $pinName\[$index\]\n";
				$token = shift(@clean_tokens);
				$token = shift(@clean_tokens); 
			}
			else
			{
				print netlistfile "\t$part $partsPinName $pinName\n";
			}
		}
		$token = shift(@clean_tokens);
	}
}

