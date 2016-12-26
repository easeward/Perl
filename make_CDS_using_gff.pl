#!/usr/bin/perl -w

#perl /home/emily/bin/
# need .fasta, .fna (gneome) and .gff in the same folder

&run_import;
exit;
 
sub run_import {
	print "importing sequences\n";
	&import_sequences; 
	<STDIN>;
	#print "printing aminos\n";
	#&print_aminos;
	#<STDIN>;
	print "importing gff data\n";
	&import_CDS_locus;
	<STDIN>;
	print "writing files\n";
	&write_coding_sequences;
}

sub import_sequences {
	my @files = glob "*.fasta";
	foreach my $file (@files)
	{
		print "Looking at $file \n";
		my $species = ();
		$species = $file;
		$species =~ s/\.fasta//g;
		$string = ();
		open FILE, "$file";	
			while (<FILE>) {
				chomp;
				$string .= $_;
			}
		close FILE;
		@amino_sequences = split (/>/, $string);
		$i = 1;
		while ($i <= $#amino_sequences) {
				if ($amino_sequences[$i] =~ m/($species\_)([a-zA-Z0-9]+\.[0-9]+)([A-Z]+[^0-9a-z])/xs) {
					chomp($aminos{$species}{$2} = $3);
					++$i;
				}
				else {
					open WARN, ">>warning.fasta";
					print WARN "$species $accession $amino_sequences[$i] isn't matching\n";
					close WARN;
					++$i;
				}
		}
	}		
}

sub print_aminos {
	foreach my $sp (sort keys %aminos){
		foreach my $acc (sort keys %{$aminos{$sp}}) {
			print ">$sp\_$acc\n$aminos{$sp}{$acc}\n\n";
		}
	}
}

sub import_CDS_locus {
	foreach my $species (sort keys %aminos) {
		print "looking at $species\n";
		open SEQ, "$species.fna";
			while (<SEQ>) {
				#print "$_ is the input line\n";
				if (/>/){
					@info_line = split(/\|/, $_);
					$chromosome = $info_line[3];
					#print "$chromosome\n";
					#<STDIN>;
					$coding{$species}{$chromosome} = ();
				}
				else {
					chomp($coding{$species}{$chromosome} .= $_);
					#print $coding{$chromosome};
				}
			}
		close SEQ;
		foreach my $acc (sort keys %{$aminos{$species}}) {
			#print "looking at $acc\n";
			open GFF, "$species.gff";
				while (<GFF>) { 
				chomp;
					if (/CDS\t/) {
						my @array_line = split(/\s+/, $_);
						if ($array_line[2] =~ /CDS$/ ) {
							$start = $array_line[3];
							$stop = $array_line[4];
							$length = $stop - $start;
							$strand = $array_line[6];
							$long_ID = $array_line[8];
							$region = $array_line[0];
							$start--;
							++$length;
							if ($long_ID =~ m/Name=$acc\;/gx) {
							print "$species\t$acc\t$long_ID matches!\n";
								if ($strand =~ /\-/) {
								#print "$strand is -\t$region\n";
								$coding_seq{$species}{$acc} = substr $coding{$species}{$region}, $start, $length;
								$coding_seq{$species}{$acc} = reverse $coding_seq{$species}{$acc};
								$coding_seq{$species}{$acc} =~ tr/ATCG/TAGC/;
								#print "$start $length\n";
								#<STDIN>;
								}
								else {
								#print "$strand is positive \t $region\n";
								$coding_seq{$species}{$acc} = substr $coding{$species}{$region}, $start, $length;
								#print "$start $length\n";
								#<STDIN>;
								}
							}
						
							else {
							#open WARN, ">>warning.fasta";
							#print WARN "$species $acc $long_ID isn't matching\n";
							#close WARN;
							}
						
						}
						else {
							open WARN, ">>warning.fasta";
							print WARN "$species $long_ID is identifying as CDS but not matching\n";
							close WARN;
						}
					}
					else {
						#open NONCDS, ">>non_cds.fasta";
						#print NONCDS "$_ isn't CDS\n";
						#close NONCDS;
					}
			}
		close GFF;
		}
	}
}			

sub write_coding_sequences {
	foreach $species (sort keys %coding_seq) {
		foreach $accession (sort keys %{$coding_seq{$species}}) {
			open FILE, ">>$species\.CDS.fasta";
			print FILE ">$species\_$accession\n$coding_seq{$species}{$accession}\n\n";
			close FILE;
		}
	}
}