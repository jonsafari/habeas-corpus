#!/bin/sh
## By Jon Dehdari, 2014
## Usage: ./generate_language.sh vocab.txt '/usr/bin/lm-query  model' [max_sents=3]
## Apache license version 2.0
## Assumes output scores from the LM software are true probabilities, summing to 1
## See http://www.keithschwarz.com/darts-dice-coins  for an interesting article, but not applicable here since we don't need to initialize; we're only sampling once per distribution.  The distribution is constantly changing after each sample.

set -f # Disable pathname expansion

max_sents=2
current_sent=1
vocab_file=$1
#model_file=$2
lm_and_model=$2



gen_word () {
	hist_expr="3 + 3 *$hist_len" # Prepares a string to use in bc;  assumes kenlm format of "word=num num prob\t"
	sort_key=`echo "$hist_expr" | bc` # Tells sort to sort by the predicted word log-prob
	pred_word_column=`echo "$hist_len + 1" | bc`
	
	#echo "hist_len=$hist_len; hist_expr=$hist_expr; sort_key=$sort_key; pred_word_column=$pred_word_column"
	
	new_word=$( \
	for w in '<unk>' '</s>' $(sed 's/\\/\\\\/g; s/%/%%/g' < $vocab_file ); do # Build a batch of queries
		printf "$hist ${w}\n";
	done |\
	exec $lm_and_model 2>/dev/null |\
	LANG=C sort -rn -k $sort_key --temporary-directory=./ --buffer-size=4000M |\
	cut -f $pred_word_column |\
	# Assumes each word entry is of the form "word=num num prob"
	perl -p -e  's/=\d+ \d+ /\t/g' |\
	#awk -v seed=$RANDOM 'BEGIN {srand(); myrand = rand(); }; { sum += 10^$2; if (sum >= myrand) {print NR, $1, sum, myrand; exit} }; END {}' \
	awk 'BEGIN {srand(); myrand = rand(); }; { sum += 10^$2; if (sum >= myrand) {print $1; exit} }; END {}' \
	)
	if [ "$new_word" != '</s>' ]; then
		printf '%s ' "$new_word" # Allows for hyphens in $new_word
	fi
	#return $new_word
}



## Main loop
while [ $current_sent -le $max_sents ]; do
	## Initialize
	hist=''
	hist_len=0
	new_word='dummy'

	while [ "$new_word" != '</s>' ]; do
		gen_word
		hist="$hist $new_word"
		hist_len=$((hist_len + 1))
	done
	if [ "$hist" != ' </s>' ]; then # we want non-empty sentences
		printf "\n"
		#echo "incrementing current_sent=$current_sent"
		current_sent=$((current_sent + 1))
	fi
done
