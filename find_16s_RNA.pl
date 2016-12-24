#!/usr/bin/perl -w

#perl /home/emily/bin/
# need .fasta, .fna (gneome) and .gff in the same folder

&run_import;
exit;
 
sub run_import {
	print "importing gff data\n";
	&import_CDS_locus;
}

sub import_CDS_locus {
	my @files = glob "*.fna";
	foreach my $file (@files) {
		$species = $file;
		$species =~ s/\.fna//g;
		print "looking at $species\n";
		<STDIN>;
		open SEQ, "$file";
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
		open GFF, "$species.gff";
			while (<GFF>) { 
			chomp;
				if (/rRNA\t/ and $_ =~ /16S/) {
					print "$_ is the line with 16S rRNA\n";
					#<STDIN>;
					my @array_line = split(/\s+/, $_);
					$start = $array_line[3];
					$stop = $array_line[4];
					$length = $stop - $start;
					$strand = $array_line[6];
					#$long_ID = $array_line[8];
					$region = $array_line[0];
					$start--;
					++$length;
					$coding_seq = ();
					if ($strand =~ /\-/) {
					#print "$strand is -\t$region\n";
					$coding_seq = substr $coding{$species}{$region}, $start, $length;
					$coding_seq = reverse $coding_seq;
					$coding_seq =~ tr/ATCG/TAGC/;
					#print "$start $length\n";
					#<STDIN>;
					}
					else {
					#print "$strand is positive \t $region\n";
					$coding_seq = substr $coding{$species}{$region}, $start, $length;
					#print "$start $length\n";
					#<STDIN>;
					}
					open FILE, ">>16SrRNAs.fasta";
						print FILE ">$species\n$coding_seq\n\n";
					close FILE;
				}
				else {}
			}
		close GFF;
					
	}
}