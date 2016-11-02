#!/usr/bin/perl -w

use File::Copy;
&get_tRNA_scan;
&format_CDS;
exit;

sub get_tRNA_scan{
	my @files = glob "*_genome.fasta";
	my @done_files = glob "*_tRNAscan.txt";
	foreach my $sp (@done_files) {
		$sp =~ s/_tRNAscan.txt//g; #print "$sp already has tRNAscan file\n";
		$done_already{$sp} = 1;
	}
	foreach my $file (@files) {
		my $species = ();
		$species = $file;
		$species =~ s/_genome.fasta//g;
		print "looking at $species\n";
		if (exists $done_already{$species}) {}
		else {
			system "/usr/local/trna_scan/tRNAscan-SE-1.3.1/tRNAscan-SE $file -o $species\_tRNAscan.txt";
		}
	}
}

sub format_CDS {
	my @files = glob "*_unformatted_CDS.fasta";
	foreach my $file (@files){
		print "Looking at $file \n";
		my $species = ();
		$species = $file;
		$species =~ s/\_unformatted\_CDS.fasta//g;
		$species =~ s/\s/\_/g;
		open FILE, "$file";	
		while (<FILE>) {
			chomp;
			$_ =~ s/\r//g;
			$_ =~ s/\n//g;
			if (/\>/) {
				if ($_ =~ /\[protein_id=([A-Z0-9\.\_]+)\]/) {
					$acc = $1;
				}
				else{
					$acc = $_;
					print "$acc\n";
					<STDIN>;
				}
				$CDS{$species}{$acc} = "";
			}
			elsif (/[ATCG]+/){
				$CDS{$species}{$acc} .= $_;
			}
			else {
			}
		}
		close FILE;
		for $accession (keys %{$CDS{$species}}) {
			@nuc_seq = split (//,$CDS{$species}{$accession});
			$end_seq = $#nuc_seq;
			++$end_seq; 
			$remainder = $end_seq % 3; #print "$remainder is the $end_seq divided by 3\n@nuc_seq\n";
			if ($remainder == 0) {
				$start_codon = ();
				$start_codon .= $nuc_seq[0];
				$start_codon .= $nuc_seq[1];
				$start_codon .= $nuc_seq[2];
				if ($start_codon =~ /ATG/ or $start_codon =~ /CTG/ or $start_codon =~ /GTG/ or $start_codon =~ /TTG/) {
				#or $start_codon =~ /CTG/ or $start_codon =~ /GTG/ or $start_codon =~ /TTG/ #these are for bacteria but maybe it is fine to ignore these for now.
				$end_codon = ();
				$end_codon .= $nuc_seq[$#nuc_seq - 2];
				$end_codon .= $nuc_seq[$#nuc_seq -1];
				$end_codon .= $nuc_seq[$#nuc_seq];
				if ($end_codon =~ /TAG/ or $end_codon =~ /TGA/ or $end_codon =~ /TAA/) {#print "$end_codon ends\n@nuc_seq\n";
					if ($end_seq > 30) {
						open FILE, ">>$species\_formatted_CDS.fasta";
							print FILE ">$species\_$accession\n$CDS{$species}{$accession}\n";
						close FILE;
					}
						else {} #don't want to look at sequences smaller than 30 nt. 
					}
					else {} #don't want sequences that don't end in stop codon
				}
				else {} #don't want sequences that don't start with ATG.
			}
			else {} #don't want sequences where triplet is fucked up. 
		}
		#copy("$file","/cellar/emily/Model_python/Bacteria_inc_genomes/unformatted/$file") or die "Copy failed: $!";
		#unlink "$file" or warn "Could not unlink $file: $!";
		#print "moved $file to unformatted file.\n";
	}
}
