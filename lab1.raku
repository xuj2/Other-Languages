my $name = "Jian Xu";
my $STOP_WORDS = 0;           # flag - filter stopwords, 0 (off) | 1 (on)
my $DEBUG = 0;				  # flag - debug words, 0 (off) | 1 (on)
my $SEQUENCE_LENGTH = 10;	  # length of song title, suggested default 10
my $FILE = "";

# array of song tracks
my @tracks = ();
# hash of hashes for bigram counts
my %counts = ();
# hash of words already used in current sequence, reset for new sequence
my %word_history = ();

# This extracts a title from the raw track input line
sub extract_title {
	if ($DEBUG) {say "<extracting titles>\n";}
	my @tracktitles = ();
	
	for @tracks -> $track { 
		if ($track ~~ /.*\<SEP\>(.*)/) {
			
			# $0 should be the title caught by regex first set of parens
			# It is added to end of the array		
			@tracktitles.push: $0;
		}
	} 
	# Updates @tracks
	return @tracktitles;
}

# This removes comments and parenthetical information
sub comments {
	if ($DEBUG) {say "<filtering comments>\n";}
	my @filteredtitles = ();
	
	# This loops through each track
	for @tracks -> $title { 
		$_ = $title;

		$_ ~~ s/(feat\.|\(|\[|\{|\\|\/|_|\-|\:|\"|\`|\+|\=)(.*)//;
		
		# Add the edited $title to the new array of titles
		@filteredtitles.push: $_;
	}
	# Updates @tracks
	return @filteredtitles;
}

# This removes punctutation
sub punctuation {
	if ($DEBUG) {say "<filtering punctuation>\n";}
	my @filteredtitles = ();
	
	for @tracks -> $title { 
		$_ = $title;
		$_ ~~ s:g/(\.|\?|\x[00BF]|\x[00A1]|\!|\;|\:|\&|\$|\*|\@|\%|\#|\|)+//;

		# Repeat for the other symbols

		# Add the edited $title to the new array of titles
		@filteredtitles.push: $_;
	}
		
	# Updates @tracks	
	return @filteredtitles;			
}


# This removes non-English characters, trailing whitespace, and blank titles
sub clean {
	if ($DEBUG) {say "<filtering non-ASCII characters>\n";}
	my @filteredtitles = ();
		
	# This loops through each track
	for @tracks -> $title {
	
		# replace leading/trailing apostrophe
		$_ = $title;

		$_ ~~ s/^\'+//;    # trim leading apostrophes
		$_ ~~ s/\'+$//;    # trim trailing apostrophes

		$_ ~~ s/^\s+//;    # trim leading whitespace
		$_ ~~ s/\s+$//;    # trim trailing whitespace

		# Use "next;" to skip lines containing non-ASCII characters
		if ($_ ~~ m:i/<-[a..z\d\s\']>/) {
			next;
		}
	
		# skip if only contains whitespace
		if ($_ ~~ /^\s*$/) {
			next;
		}

		# skip if only contains only an apostrophe
		if ($_ ~~ /^\'*$/) {
			next;
		}
	
		@filteredtitles.push: lc($_);
		
	}
	# Updates @tracks	
	return @filteredtitles;			
}
	
# This removes common stopwords	
sub stopwords {
	if ($DEBUG) {say "<filtering stopwords>\n";}
	my @filteredtitles = ();

	for @tracks -> $title { 
		$_ = $title;

		$_ ~~ s:g:i/<|w>a<|w>\s//;
		$_ ~~ s:g:i/<|w>an<|w>\s//;
		$_ ~~ s:g:i/<|w>and<|w>\s//;
		$_ ~~ s:g:i/<|w>by<|w>\s//;
		$_ ~~ s:g:i/<|w>for<|w>\s//;
		$_ ~~ s:g:i/<|w>from<|w>\s//;
		$_ ~~ s:g:i/<|w>in<|w>\s//;
		$_ ~~ s:g:i/<|w>of<|w>\s//;
		$_ ~~ s:g:i/<|w>on<|w>\s//;
		$_ ~~ s:g:i/<|w>or<|w>\s//;
		$_ ~~ s:g:i/<|w>out<|w>\s//;
		$_ ~~ s:g:i/<|w>the<|w>\s//;
		$_ ~~ s:g:i/<|w>to<|w>\s//;
		$_ ~~ s:g:i/<|w>with<|w>\s//;
		# Repeat for the other stopwords

		# Add the edited $title to the new array of titles
		@filteredtitles.push: $_;
	}
	
	# Updates @tracks	
	return @filteredtitles;			
}


# This splits the tracks into words and builds the bi-gram model
sub build_bigrams {
	if ($DEBUG) {say "<bigram model built>\n";}	
}


# This finds the most-common-word (mcw) to follow the given word
sub mcw {
	# Seed word (arg) for which we find the next word
	my $word = @_[0];
	# Store the most common next word in this variable and return it.
	my $best_word = '';

	if ($DEBUG) {say "  <mcw for \'$word\' is \'$best_word'\>\n";}
	
	# return the most common word to follow word
	return $best_word
}



# This builds a song title based on mcw
sub sequence {
	if ($DEBUG) {say "<sequence for \'$_[0]\'>\n";}	
	
	# clear word history for new sequence
	%word_history = ();
	
	# return the sequence you created instead of this measely string
	return "ERROR: SEQUENCE 404";
}

# This is the "command" loop that runs until end-of-input
for lines() {    
	
	# split line into array of words
	my @input = split(/\s+/, $_);	
	# command is @input[0], first word
    my $command = lc(@input[0]);
	# argument is @input[1], second word
	
	if ($command eq "load") { 
		# load the input file
		my $file = lc(@input[1]);
		$FILE = $file;				
		load($file);	
	}elsif ($command eq "length") { 	
		# change the sequence length
		if ($DEBUG) {say "<sequence length " ~ @input[1] ~ ">\n";}
		$SEQUENCE_LENGTH = @input[1];
	}elsif ($command eq "debug") { 
		# toggle debug mode on/off
		if (lc(@input[1]) eq "on") {
			if ($DEBUG) {say "<debug on>\n";}
			$DEBUG = 1;
		}elsif (lc(@input[1]) eq "off") {
			if ($DEBUG) {say "<debug off>\n";}
			$DEBUG = 0;
		}else {
			say "**Unrecognized argument to debug: " ~ @input[1] ~ "\n";
		}
	}elsif ($command eq "count") { 
		if (lc(@input[1]) eq "tracks") {
			# count the number of lines in @tracks			
			count_lines(@tracks);
		}elsif (lc(@input[1]) eq "words") {
			# count the number of words in @tracks
			count_words(@tracks);
		}elsif (lc(@input[1]) eq "characters") {
			# count the number of characters in @tracks
			count_characters(@tracks);
		}else {
			say "**Unrecognized argument: " ~ @input[1] ~ "\n";
		}
	}elsif ($command eq "stopwords") { 
		# toggle stopwords on/off
		if (lc(@input[1]) eq "on") {
			if ($DEBUG) {say "<stopwords on>\n";}
			$STOP_WORDS = 1;
		}elsif (lc(@input[1]) eq "off") {
			if ($DEBUG) {say "<stopwords off>\n";}
			$STOP_WORDS = 0;
		}else {
			say "**Unrecognized argument: " ~ @input[1] ~ "\n";
		}
	}elsif ($command eq "filter") { 
		if (@input[1] eq "title") {		
			# extract the title from the line
			@tracks = extract_title();
		}elsif (@input[1] eq "comments") {
			# filter out extra phrases from the titles
			@tracks = comments();
		}elsif (@input[1] eq "punctuation") {
			# filter out punctuation		
			@tracks = punctuation();
		}elsif (@input[1] eq "unicode") {
			# filter out non-ASCII characters		
			@tracks = clean();
		}elsif (@input[1] eq "stopwords" && $STOP_WORDS) {	
			# filter out common words, if enabled
			@tracks = stopwords();		
		}else {
			say "**Unrecognized argument to stopwords: " ~ @input[1] ~ "\n";
		}	
	}elsif ($command eq "preprocess") { 
		# preprocess does all of the filtering tasks at once and builds bigrams
		
		# first, extract the title from the line
		@tracks = extract_title();
		# next, filter out extra phrases from the titles
		@tracks = comments();
		# next, filter out punctuation
		@tracks = punctuation();
		# next, filter out non-ASCII characters, blank titles
		@tracks = clean();		
		# next, filter out common words, if enabled
		if ($STOP_WORDS) {@tracks = stopwords();}
		
		# build bi-gram model counting occurences of word pairs
		build_bigrams();
	}elsif ($command eq "build") {
		# build bi-gram model counting occurences of word pairs
		build_bigrams();
	}elsif ($command eq "mcw") {
		# say the most-common-word to follow given word
		say mcw(lc(@input[1]));
	}elsif ($command eq "sequence") { 
		# say a song title based on the given word
		say sequence(lc(@input[1])).Str;
	}elsif ($command eq "print") {
		if (@input[1]) {
			say_some_tracks(val(@input[1]));
		}else {
			say_all_tracks(@tracks);
		}
	}elsif ($command eq "author") { 
		say "Lab1 by $name run";		
	}elsif ($command eq "name") { 
		say sequence(lc($name));               
	}elsif ($command eq "random") { 
		say sequence((%counts.keys)[%counts.keys.rand]).Str;			
	}else {
		# warn user if command was ignored
		say "**Unrecognized command: " ~ $command;
	}	
}

# This loops through N lines of the array 
sub say_some_tracks($n) {
	if ($DEBUG) {say "<printing $n tracks>\n";}	
	loop (my $i=0; $i < $n; $i++) {
		say @tracks[$i];
	} 
}

# This loops through each line of the array
sub say_all_tracks {	
	if ($DEBUG) {say "<saying all tracks>\n";}	
	# are you sure you want to? (use CTRL+C to kill it)
	my $fh = open "tracks.out", :w;
	for (@_) { 
		$fh.say($_);
	} 
	$fh.close;
}

# Count lines of array
sub count_lines {
	if ($DEBUG) {say "<counting number of tracks>\n";}
	say @_.elems;
}

# Count words, after splitting on whitespace
sub count_words {
	if ($DEBUG) {say "<counting number of words>\n";}
	my $word_count = @_.words;
	say $word_count.elems;
}

# Count individual characters
sub count_characters {
	if ($DEBUG) {say "<counting number of characters>\n";}
	say @_.chars;
}

# Loads the tracks file into an array
sub load {
	for @_.IO.lines -> $line {
		@tracks.push($line); 
	}
	if ($DEBUG) {say "<loaded " ~ $FILE ~ ">"};	
}
