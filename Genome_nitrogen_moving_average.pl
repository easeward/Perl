#!/usr/bin/perl -w

#I want to look at a moving average of nitrogen content over the length of the genome. 
&run_script;
exit;
 
sub run_script {
	#print "For now I am assuming all chromosomes plasmids etc. are linear. This is probably not true\n";
	#print "This script cannot currently deal with Ns in the sequence or any letters that aren't ATGC\n";
	#print "Script currently ignores the presence of Ns and skips over them\n";
	#&import_genome;
	#&define_bases;
	#&import_gff;
	#&moving_average_each_chromosome; #Define if you want linear or circular chromosome; 
	#&import_gene_GC; #This is for the Mollicutes.
	#&kinetoplasitd_oriC;
	#&L_major_oriC;
	&Mollicute_nitrogen;
}

sub kinetoplasitd_oriC {
	&import_genome;
	$step_size = 10000;
	$block_size = 50000;
	&define_bases;
	&moving_average_each_chromosome;
}

sub Mollicute_nitrogen {
	&import_genome;
	&define_bases;
	#$step_size = 10000;
	$block_size = 25000;
	$step_size = $block_size;
	$oriC_location{'P_solani'} = 457598; #not sure about this one
	#$genome_size{'P_solani'} = 570238;
	$oriC_location{'P_mali'} = 251975;
	#$genome_size{'P_mali'} = 601943;
	$oriC_location{'M_synoviae'} = 25;
	#$genome_size{'M_synoviae'} = 799476;
	$oriC_location{'M_arthritidis'} = 820403;
	#$genome_size{'M_arthritidis'} = 820453;
	$oriC_location{'M_hyopneumoniae'} = 1400;
	#$genome_size{'M_hyopneumoniae'} = 921093;
	$oriC_location{'M_haemocanis'} = 1426;
	#$genome_size{'M_haemocanis'} = 919992;
	$oriC_location{'M_parvum'} = 1100;
	#$genome_size{'M_parvum'} = 564395;
	$oriC_location{'M_conjunctivae'} = 845995;
	#$genome_size{'M_conjunctivae'} = 846214;
	$oriC_location{'P_asteris'} = 852500;
	#$genome_size{'P_asteris'} = 853092;
	$oriC_location{'M_crocodyli'} = 1366;
	#$genome_size{'M_crocodyli'} = 934379;
	$oriC_location{'M_penetrans'} = 1358550;
	#$genome_size{'M_penetrans'} = 1358633;
	$oriC_location{'M_leachii'} = 1440;
	#$genome_size{'M_leachii'} = 1017232;
	$oriC_location{'M_fermentans'} = 150;
	#$genome_size{'M_fermentans'} = 1118751;
	$oriC_location{'M_capricolum'} = 1010000;
	#$genome_size{'M_capricolum'} = 1010023;
	$oriC_location{'M_putrefaciens'} = 1450;
	#$genome_size{'M_putrefaciens'} = 832603;
	$oriC_location{'M_hominis'} = 2600;
	#$genome_size{'M_hominis'} = 665445;
	$oriC_location{'M_genitalium'} = 579000;
	#$genome_size{'M_genitalium'} = 579558;
	$oriC_location{'M_mycoides'} = 5;
	#$genome_size{'M_mycoides'} = 1193808;
	$oriC_location{'P_strawberry'} = 2554;
	#$genome_size{'P_strawberry'} = 959779;
	$oriC_location{'P_australiense'} = 2554;
	#$genome_size{'P_australiense'} = 879959;
	$oriC_location{'M_hyorhinis'} = 5;
	&moving_average_each_chromosome_nitrogen;
}

sub L_major_oriC {
	$species = 'L_major';
	open SEQ, "L_major.GENOME.fasta";
		while (<SEQ>) {
			#print "$_ is the input line\n";
			if (/>/){
				@info_line = split(/\s/, $_);
				$chromosome = $info_line[0];
				$chromosome =~ s/>//g;
				$genome{$species}{$chromosome} = ();
			}
			else {
			chomp($genome{$species}{$chromosome} .= $_);
			}
		}
	close SEQ;
	$step_size = 10000;
	$block_size = 50000;
	$oriC_location{'LmjF.01'} = 268988;
	$oriC_location{'LmjF.02'} = 230166;
	$oriC_location{'LmjF.03'} = 230701;
	$oriC_location{'LmjF.04'} = 72746;
	$oriC_location{'LmjF.05'} = 409924;
	$oriC_location{'LmjF.06'} = 124761;
	$oriC_location{'LmjF.07'} = 204463;
	$oriC_location{'LmjF.08'} = 541138;
	$oriC_location{'LmjF.09'} = 245757;
	$oriC_location{'LmjF.10'} = 481667;
	$oriC_location{'LmjF.11'} = 154210;
	$oriC_location{'LmjF.12'} = 253254;
	$oriC_location{'LmjF.13'} = 147284;
	$oriC_location{'LmjF.14'} = 100969;
	$oriC_location{'LmjF.15'} = 331324;
	$oriC_location{'LmjF.16'} = 381147;
	$oriC_location{'LmjF.17'} = 391331;
	$oriC_location{'LmjF.18'} = 472179;
	$oriC_location{'LmjF.19'} = 685488;
	$oriC_location{'LmjF.20'} = 528026;
	$oriC_location{'LmjF.21'} = 235252;
	$oriC_location{'LmjF.22'} = 651456;
	$oriC_location{'LmjF.23'} = 540796;
	$oriC_location{'LmjF.24'} = 519860;
	$oriC_location{'LmjF.25'} = 608563;
	$oriC_location{'LmjF.26'} = 606411;
	$oriC_location{'LmjF.27'} = 924483;
	$oriC_location{'LmjF.28'} = 797571;
	$oriC_location{'LmjF.29'} = 369714;
	$oriC_location{'LmjF.30'} = 217025;
	$oriC_location{'LmjF.31'} = 784981;
	$oriC_location{'LmjF.32'} = 1217804;
	$oriC_location{'LmjF.33'} = 791826;
	$oriC_location{'LmjF.34'} = 282841;
	$oriC_location{'LmjF.35'} = 567612;
	$oriC_location{'LmjF.36'} = 1117563;
	&define_bases;
	foreach my $chrom (keys %oriC_location) {
		#$chrom = 'LmjF.04';
		print "looking at $chrom\n";
		$continue_left = 'yes';
		$continue_right = 'yes';
		$block_number = 1;
		@seq = ();
		@seq = split (//,$genome{$species}{$chrom});
		$genome_size = $#seq + 1;
		if ($oriC_location{$chrom} < ($genome_size/2)) {
			$longer_branch = $genome_size - $oriC_location{$chrom};
		}
		else {
			$longer_branch = $oriC_location{$chrom};
		}
		$total_number_blocks = $longer_branch/($step_size); 
		#print "$species $chrom $genome_size $oriC_location{$chrom} $longer_branch $total_number_blocks\n";
		#<STDIN>;
		$start_right = $oriC_location{$chrom};
		$stop_right = $start_right + $block_size;
		$stop_left = $oriC_location{$chrom};
		$start_left = $stop_left - $block_size;
		if ($start_left <= 0) {
			$start_left = 0;
		}
		else {}
		if ($stop_left <= 0) {
			$continue_left = 'no';
		}
		else {}
		if ($start_right >= $genome_size) {
			$continue_right = 'no';
		}
		else {}
		if ($stop_right >= $genome_size) {
			$stop_right = $genome_size;
		}
		else {}
		until ($block_number >= $total_number_blocks ) { #We have looked at the whole chromosome;
			$right_block = 0;
			$left_block = 0;
			#print "$species $block_number $oriC_location{$chrom} $genome_size $start_left $stop_left $start_right $stop_right \n";
			#<STDIN>;
			if ($continue_left =~ /yes/) {
				$i = $start_left;
				$GC = 0;
				$AT = 0;
				while ($i <= $stop_left) {
					if ($seq[$i] =~ /N/) {
						until ($seq[$i] =~ /[ATCG]+/ or $i > $stop_left) {
							++$i;
						}
					}
					else {
					}
					if ($seq[$i] =~ /A/ or $seq[$i] =~ /T/) {
							++$AT;
						}
					elsif ($seq[$i] =~ /G/ or $seq[$i] =~ /C/) {
							++$GC;
					}
					++$i;
				}
				$GC_percent_left = (100*$GC)/ ($GC + $AT);
			}
			else {}
			if ($continue_right =~ /yes/) {
		#	print "$stop_right is smaller than $genome_size\n";
				$i = $start_right;
				$GC = 0;
				$AT = 0;
				while ($i <= $stop_right) {
					if ($seq[$i] =~ /N/) {
						until ($seq[$i] =~ /[ATCG]+/ or $i > $stop_right) {
							++$i;
						}
					}
					else {
					}
					if ($seq[$i] =~ /A/ or $seq[$i] =~ /T/) {
							++$AT;
						}
					elsif ($seq[$i] =~ /G/ or $seq[$i] =~ /C/) {
							++$GC;
					}
					++$i;
				}
				$GC_percent_right = (100*$GC)/ ($GC + $AT);
			}
			else {
			#	print "$stop_right is greater than $genome_size\n";
			}
			
			if ($continue_left =~ /yes/ and $continue_right =~ /yes/) {
				$both_block_average = ($GC_percent_right + $GC_percent_left)/2;
			}
			elsif ($continue_left =~ /yes/ and $continue_right =~ /no/) {
				$both_block_average = $GC_percent_left;
			}
			elsif ($continue_left =~ /no/ and $continue_right =~ /yes/) {
				$both_block_average = $GC_percent_right;
			}
			else {
				$both_block_average = 0;
			}
			
			open FILE, ">>$species\_block_distance_from_oriC_step_$step_size\_block_size_$block_size.txt";
				print FILE "$chrom\t$block_number\t$GC_percent_left\t$GC_percent_right\t$both_block_average\n";
			close FILE;#print "$start $length\n";
			#print "$block_number $GC_percent_left $GC_percent_right $both_block_average\n";
			#<STDIN>;
			++$block_number;
			$start_right = $start_right + $step_size;
			$stop_right = $stop_right + $step_size;
			$start_left = $start_left - $step_size;
			$stop_left = $stop_left - $step_size;
			if ($start_left <= 0) {
				$continue_left = 'no';
			}
			else {}
			if ($stop_left <= 0) {
				$continue_left = 'no';
			}	
			else {}
			if ($start_right >= $genome_size) {
				$continue_right = 'no';
			}
			else {}
			if ($stop_right >= $genome_size) {
				$continue_right = 'no';
			}
			else {}
		}	
	}
}

sub import_gene_GC {
	my @GC_files = glob "*_middle_mb.fasta";
	foreach my $species (@GC_files) {
		open GC, "$species";
			
			$species =~ s/_middle_mb.fasta//;
			print "looking at $species\n";
			while (<GC>) {
				chomp;
				@line = ();
				@line = split (/\t/, $_);
				$middle_point = $line[0];
				#$accession = $line[1];
				$GC_percent = $line[2];
				#print "$species $middle_point $accession $GC_percent\n";
				#<STDIN>;
				$info{$species}{$middle_point} = $GC_percent;
			}
		close GC;
	}
	$step_size = 2500;
	$block_size = 10000;
	$oriC_location{'P_solani'} = 457598; #not sure about this one
	$genome_size{'P_solani'} = 570238;
	$oriC_location{'P_mali'} = 251975;
	$genome_size{'P_mali'} = 601943;
	$oriC_location{'M_synoviae'} = 25;
	$genome_size{'M_synoviae'} = 799476;
	$oriC_location{'M_arthritidis'} = 820403;
	$genome_size{'M_arthritidis'} = 820453;
	$oriC_location{'M_hyopneumoniae'} = 1400;
	$genome_size{'M_hyopneumoniae'} = 921093;
	$oriC_location{'M_haemocanis'} = 1426;
	$genome_size{'M_haemocanis'} = 919992;
	$oriC_location{'M_parvum'} = 1100;
	$genome_size{'M_parvum'} = 564395;
	$oriC_location{'M_conjunctivae'} = 845995;
	$genome_size{'M_conjunctivae'} = 846214;
	$oriC_location{'P_asteris'} = 852500;
	$genome_size{'P_asteris'} = 853092;
	$oriC_location{'M_crocodyli'} = 1366;
	$genome_size{'M_crocodyli'} = 934379;
	$oriC_location{'M_penetrans'} = 1358550;
	$genome_size{'M_penetrans'} = 1358633;
	$oriC_location{'M_leachii'} = 1440;
	$genome_size{'M_leachii'} = 1017232;
	$oriC_location{'M_fermentans'} = 150;
	$genome_size{'M_fermentans'} = 1118751;
	$oriC_location{'M_capricolum'} = 1010000;
	$genome_size{'M_capricolum'} = 1010023;
	$oriC_location{'M_putrefaciens'} = 1450;
	$genome_size{'M_putrefaciens'} = 832603;
	$oriC_location{'M_hominis'} = 2600;
	$genome_size{'M_hominis'} = 665445;
	$oriC_location{'M_genitalium'} = 579000;
	$genome_size{'M_genitalium'} = 579558;
	$oriC_location{'M_mycoides'} = 5;
	$genome_size{'M_mycoides'} = 1193808;
	$oriC_location{'P_strawberry'} = 2554;
	$genome_size{'P_strawberry'} = 959779;
	$oriC_location{'P_australiense'} = 2554;
	$genome_size{'P_australiense'} = 879959;
	foreach my $species (keys %oriC_location) {
		$block_number = 1;
		$total_number_blocks = $genome_size{$species}/(2*$step_size); #2 as it is bidirectional
		#print "$species $total_number_blocks\n";
		#<STDIN>;
		$start_right = $oriC_location{$species};
		$stop_right = $start_right + $block_size;
		$stop_left = $oriC_location{$species};
		$start_left = $stop_left - $block_size;
		if ($start_left < 0) {
			$start_left = $genome_size{$species} + $start_left;
		}
		else {}
		if ($stop_left < 0) {
			$stop_left = $genome_size{$species} + $stop_left;
		}
		else {}
		if ($start_right > $genome_size{$species}) {
			$start_right = $start_right - $genome_size{$species};
		}
		else {}
		if ($stop_right > $genome_size{$species}) {
			$stop_right = $stop_right - $genome_size{$species};
		}
		else {}
		#print "$species $block_number $oriC_location{$species} $genome_size{$species} $start_right $stop_right $start_left $stop_left\n";
		#	<STDIN>;
		until ($block_number >= $total_number_blocks ) { #We have looked at the whole chromosome;
			$right_block = 0;
			$right_number_genes = 0;
			$left_block = 0;
			$left_number_genes = 0;
			#print "$species $block_number $oriC_location{$species} $genome_size{$species} $start_right $stop_right $start_left $stop_left \n";
			#<STDIN>;
			foreach $gene (keys %{$info{$species}}) {
				if ($start_right < $gene and $gene < $stop_right) {
					$right_block = $right_block + $info{$species}{$gene};
					++$right_number_genes;
					print "$gene is in the right block both\n";
				}
				elsif ($start_right < $gene) {
					$difference = $stop_right - $start_right;
					if ($difference < 0) {
						$right_block = $right_block + $info{$species}{$gene};
						++$right_number_genes;
						print "$gene is in the right block one\n";
					}
				}
				elsif ($gene < $stop_right) {
					$difference = $stop_right- $start_right;
					if ($difference < 0 ) {
						$right_block = $right_block + $info{$species}{$gene};
						++$right_number_genes;
						print "$gene is in the right block two\n";
					}
				}
				else {}
				if ($start_left < $gene and $gene < $stop_left) {
					$left_block = $left_block + $info{$species}{$gene};
					++$left_number_genes;
					print "$gene is in the left block both\n";
				}
				elsif ($start_left < $gene) {
					$difference = $stop_left - $start_left;
					if ($difference < 0) {
						$left_block = $left_block + $info{$species}{$gene};
						++$left_number_genes;
						print "$gene is in the left block one\n";
					}
					else {}
				}
				elsif ($gene < $stop_left) {
					$difference = $stop_left - $start_left;
					if ($difference < 0 ) {
						$left_block = $left_block + $info{$species}{$gene};
						++$left_number_genes;
						print "$gene is in the left block two\n";
					}
					else {}
				}
				else {}
			} 
			if ($right_number_genes > 0) {
				$right_block_average = $right_block/$right_number_genes;
			}
			else {$right_block_average = 0;}
			if ($left_number_genes > 0) {
				$left_block_average = $left_block/$left_number_genes;
			}
			else {$left_block_average = 0 }
			if ($right_number_genes > 0 and $left_number_genes > 0 ) {
				$both_block_average = ($right_block_average + $left_block_average)/2;
			}
			elsif ($right_number_genes > 0) {
				$both_block_average = $right_block_average;
			}
			elsif ($left_number_genes > 0) {
				$both_block_average = $left_block_average;
			}
			else {$both_block_average = 0 }
			open FILE, ">>$species\_block_distance_from_oriC_step_$step_size\_block_size_$block_size.txt";
				print FILE "$block_number\t$right_block_average\t$left_block_average\t$both_block_average\n";
			close FILE;#print "$start $length\n";
		#	print "$block_number $right_block_average $left_block_average $both_block_average\n";
		#	<STDIN>;
			++$block_number;
			$start_right = $start_right + $step_size;
			$stop_right = $stop_right + $step_size;
			$start_left = $start_left - $step_size;
			$stop_left = $stop_left - $step_size;
			if ($start_left < 0) {
			$start_left = $genome_size{$species} + $start_left;
			}
			else {}
			if ($stop_left < 0) {
			$stop_left = $genome_size{$species} + $stop_left;
			}
			else {}
			if ($start_right > $genome_size{$species}) {
			$start_right = $start_right - $genome_size{$species};
			}
			else {}
			if ($stop_right > $genome_size{$species}) {
				$stop_right = $stop_right - $genome_size{$species};
			}
			else {}
		}
		
	}
}
sub import_gff {
my @gff = glob "*.gff";
	foreach $gff (@gff) {
	open GFF, "$gff";
		$species = $gff;
		$species =~ s/.gff//g;
		while (<GFF>) { 
		chomp;
		if (/CDS/) {
			my @array_line = split(/\t/, $_);
				$start = $array_line[3];
				$stop = $array_line[4];
				$length = $stop - $start;
				$strand = $array_line[6];
				$long_ID = $array_line[8];
				$region = $array_line[0];
				$start--;
				++$length;
				#print "\n\n$start $stop $length $strand $long_ID $region\n";
				#<STDIN>;
				if ($long_ID =~ m/pseudo=true/) {
					
				}
				elsif ($long_ID =~ m/Name=([A-Z\_0-9\.]+)\;/gx) {
					$acc = $1;
					#print "$species\t$acc\t$long_ID matches!\n";
					#<STDIN>;
					$coding_seq = ();
					if ($strand =~ /\-/) {
						#print "$strand is -\t$region\n";
						$coding_seq = substr $genome{$species}{$region}, $start, $length;
						$coding_seq = reverse $coding_seq;
						$coding_seq =~ tr/ATCG/TAGC/;
						#print "$start $length\n";
						#<STDIN>;
					}
					else {
						#print "$strand is positive \t $region\n";
						$coding_seq = substr $genome{$species}{$region}, $start, $length;
						#<STDIN>;
					}
					@seq = split (//,$coding_seq);
					$nitrogen = 0;
					foreach $base (@seq) {
						$nitrogen = $nitrogen + $base_N{$base};
					}
					$length = $#seq + 1;
					$nitrogen = $nitrogen/$length;
					open FILE, ">>$species\_CDS_nitrogen_av.txt";
						print FILE "$region\t$strand\t$start\t$stop\t$acc\t$nitrogen\n";
					close FILE;#print "$start $length\n";
				}	
				else {
					#open WARN, ">>warning.fasta";
					#print WARN "$species $acc $long_ID isn't matching\n";
					print "$species $long_ID isn't matching\n";
					#close WARN;
					<STDIN>;
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
#$coding_seq{$species}{$region}{$start}{$stop}{$acc}

sub import_genome {
my @genomes = glob "*.GENOME.fasta";
	foreach my $genome (@genomes) {
	$species = $genome;
	open SEQ, "$genome";
		$species =~ s/\.GENOME.fasta//g;
			while (<SEQ>) {
				#print "$_ is the input line\n";
				if (/>/){
					@info_line = split(/\s/, $_);
					$chromosome = $info_line[0];
					$chromosome =~ s/>//g;
					#print "$chromosome\n";
					#<STDIN>;
					$genome{$species}{$chromosome} = ();
				}
				else {
					chomp($genome{$species}{$chromosome} .= $_);
					#print $genome{$species}{$chromosome};
					#<STDIN>;
				}
			}
		close SEQ;
	}
}

sub define_bases {
	$base_N{'A'} = 5;
	$base_N{'T'} = 2;
	$base_N{'C'} = 3;
	$base_N{'G'} = 5;
	$ds_base_N{'A'} = 2;
	$ds_base_N{'T'} = 5;
	$ds_base_N{'C'} = 5;
	$ds_base_N{'G'} = 3;
}

sub moving_average_each_chromosome {
	foreach my $species (keys %genome) {
		open FILE, ">>$species\_genome_GC_$block_size\_av_array_print.txt";
			print FILE "Chromosome\tstart_block\tmiddle_block\tend_block\tBlock_number\tAverage_GC\n";
		close FILE;#print "$start $length\n";
		foreach my $chromosome (keys %{$genome{$species}}){
			@seq = ();
			@seq = split (//,$genome{$species}{$chromosome});
			$genome_size = $#seq + 1;
			print "$chromosome $genome_size is genome size and ends $seq[$genome_size - 3] $seq[$genome_size - 2] $seq[$genome_size - 1]\n";
			open FILE, ">>$species\_genome_GC_$block_size\_av_array_print.txt";
				print FILE "\n$chromosome\t$genome_size\t";
			close FILE;#<STDIN>;
			$number_blocks = ($genome_size - $block_size)/$step_size;
			$current_block = 1;
			$start = 0;
			while ($current_block < $number_blocks) {
				$GC = 0;
				$AT = 0;
				$block_bp = 0;
				$start_modified = $start;
				while ($block_bp < $block_size) {
					$position = $start_modified + $block_bp;
					#if ($position >= $genome_size) {
					#	$position = $position - $genome_size; #This makes the genome circular. 
					#}
					#else {}
					#print "$seq[$position]\n";
					if ($seq[$position] =~ /N/) {
						until ($seq[$position] =~ /[ATCG]+/ or $position > $genome_size) {
							++$start_modified;
							$position = $start_modified + $block_bp;
							print "$seq[$position - 1] is an N so I have increased $start to $start_modified to change to $position\n";
							#<STDIN>;
						}
					}
					else {
					}
					if ($seq[$position] =~ /A/ or $seq[$position] =~ /T/) {
							++$AT;
						}
					elsif ($seq[$position] =~ /G/ or $seq[$position] =~ /C/) {
							++$GC;
					}
						++$block_bp;
					#print "$nitrogen\n";
					#<STDIN>;
				}
				$GC_percent = (100*$GC)/ ($GC + $AT);
				#$middle = $start + ($block_size/2);
				open FILE, ">>$species\_genome_GC_$block_size\_av_array_print.txt";
				#print FILE "$chromosome\t$start\t$middle\t$position\t$current_block\t$GC_percent\n";
					print FILE "$GC_percent\t";
				close FILE;#print "$start $length\n";
				$start = $current_block*$step_size;
				#$next_step_end = $start + $average_block;
				#if ($next_step_end >= $genome_size and $chromosome_type =~ /linear/) {
				#	$current_block = $number_blocks;
				#}
				#else {
					++$current_block;
				#}
			}
		}
	}
}

sub moving_average_each_chromosome_nitrogen {
	foreach my $species (keys %genome) {
		foreach my $chromosome (keys %{$genome{$species}}){
			@seq = ();
			@seq = split (//,$genome{$species}{$chromosome});
			$genome_size = $#seq + 1;
			print "$chromosome $genome_size is genome size and ends $seq[$genome_size - 3] $seq[$genome_size - 2] $seq[$genome_size - 1]\n";
			$total_number_blocks = ($genome_size-$block_size)/($step_size);
			$block_number = 1;
			$start_right = $oriC_location{$species};
			$stop_right = $start_right + $block_size;
			if ($start_right > $genome_size) {
				$start_right = $start_right - $genome_size;
			}
			else {}
			if ($stop_right > $genome_size) {
				$stop_right = $stop_right - $genome_size;
			}
			else {}
			#print "$species $block_number $oriC_location{$species} $genome_size{$species} $start_right $stop_right $start_left $stop_left\n";
			#	<STDIN>;
			until ($block_number >= $total_number_blocks ) { #We have looked at the whole chromosome;
				#print "$species $block_number $oriC_location{$species} $genome_size{$species} $start_left $stop_left $start_right $stop_right\n";
				#<STDIN>;
				$length = $block_size;
				$A = 0;
				$T = 0;
				$C = 0;
				$G = 0;
				$i = $start_right;
				$j = 1;
				while ($j <= $block_size) {
					if ($i >= $genome_size) {
						$i = 0;
					}
					else {}
					if ($seq[$i] =~ /N/) {
						--$length;
					}
					else {
					}
					if ($seq[$i] =~ /A/) {
							++$A;
					}
					elsif ($seq[$i] =~ /G/) {
							++$G;
					}
					elsif ($seq[$i] =~ /C/) {
							++$C;
					}
					elsif ($seq[$i] =~ /T/) {
							++$T;
					}
					else {}
					#print "$seq[$i] $A $T $C $G\n";
					#<STDIN>;
					++$i;
					++$j;
				}
				if ($length == 0){}
				else {
				$nitrogen = (2*$T + 3*$C + 5*$A + 5*$G)/$length;
				$nitrogen_opposite = (5*$T + 5*$C + 2*$A + 3*$G)/$length;
				$middle = $start_right + ($block_size/2);
				open FILE, ">>$species\_right_genome_nitrogen_$block_size\_$step_size\_av_array.txt";
				#print "$block_number\t$nitrogen\t$nitrogen_opposite\t$length\n";
					print FILE "$block_number\t$middle\t$nitrogen\t$nitrogen_opposite\t$A\t$T\t$C\t$G\n";
				close FILE;#print "$start $length\n";
				}
				$start_right = $start_right + $step_size;
				$stop_right = $start_right + $step_size;

				if ($start_right > $genome_size) {
					$start_right = $start_right - $genome_size;
				}
				else {}
				if ($stop_right > $genome_size) {
					$stop_right = $stop_right - $genome_size;
				}
				else {}
				++$block_number;
			}
		}
	}
}

