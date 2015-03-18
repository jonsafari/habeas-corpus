#!/bin/sh
### By Jon Dehdari, 2010
### Parallel Map a command to either a single file or
###   multiple files (no rejoining is to be done)
###   The file(s) argument may be a glob of files
### The license is GPLv3 (see http://www.gnu.org/licenses/gpl-3.0.txt )


usage='Usage: ./par_map.sh  [options]  command  file(s)
Parallel Map a command to either a single file or multiple files

If the command requires additional arguments, surround the entire command
and its arguments in single quotes.  You may use globbing for the file
argument.

Options:
  -c, --cores <n>        Use <n> cores (default: 6)
  -h, --help             Display this usage info
      --from-stdin       The command assumes the input will come from STDIN, instead of a file argument
      --ls-out           List output files, instead of concatenating output & deleting temp files (you must delete temp files yourself)
      --tmpdir <x>       Use temporary directory at <x> (default: ./ )
'

### Defaults
cores=6
tmpdir=./
from_stdin='false'


### Process command-line args
### If not enough arguments, die
if [ $# -lt 2 ]; then
    echo "$usage"
    exit
fi

while [ $# -gt 2 ]; do
    case $1 in
    -c | --cores)
        cores=$2
        shift 2
        ;;
    --from-stdin)
        from_stdin='true'
        shift
        ;;
    --ls-out)
        ls_out='true'
        shift
        ;;

	-h | --help)
	    echo "$usage"
	    exit
	    ;;
         --tmpdir)
        tmpdir=$2
        shift 2
        ;;
	-*)
	    echo 'Warning: invalid flag'
	    echo "$usage"
	    shift
	    ;;
	*)
	    break
	    ;;
    esac
done

function=$1 && shift
list=$*

list_length=`echo $list | wc -w`

### If input list is single file, split it now and rejoin it later
if [ $list_length -eq 1 ]; then
    single_file=$list
    file_length=`cat $list | wc -l`
    remainder=`echo " ( $file_length % $cores ) " | bc`
    if [ $remainder -gt 0 ]; then
        does_remainder_exist=1
    else
        does_remainder_exist=0
    fi

    ### Find number of lines to evenly split-up rare-words file
    split_line_load=`echo " ( $file_length / $cores ) + $does_remainder_exist " | bc`
    temp_name=`mktemp --tmpdir=$tmpdir -u`_`basename ${list}`
    split -d -a 4 -l $split_line_load $list ${temp_name}_

    ###  *Overwrites* original $list from one file to multiple split files; original preserved in $single_file
    list=`\ls ${temp_name}_*`

    list_length=`echo $list | wc -w`
fi

### Don't get greedy ;-)
if [ $cores -gt $list_length ]; then
    cores=$list_length
fi


load_per_core=`echo " ( $list_length / $cores ) " | bc`
remainder=`echo " ( $list_length % $cores ) " | bc`
remainder_index=0
temp_out=`mktemp --tmpdir=$tmpdir -u`


for core_number in `seq 1 $cores`; do
    list_offset_begin=$(( ( ($core_number - 1) * $load_per_core) + 1 + $remainder_index ))

    ### No remainder exists 
    if [ $remainder_index = $remainder ]; then
        list_offset_end=$(($list_offset_begin + $load_per_core - 1 ))
    
    ### Remainder exists
    else
        list_offset_end=$(($list_offset_begin + $load_per_core))
        remainder_index=$(( $remainder_index + 1 ))
    fi
    
    list_subset=`echo $list | cut -d ' ' -f ${list_offset_begin}-$list_offset_end`

	if [ $from_stdin = 'true' ]; then
		( eval cat $list_subset | $function > ${temp_out}_output_${core_number} ) &
	else
		( eval $function $list_subset > ${temp_out}_output_${core_number} ) &
	fi
done
wait


### For a single file, the $list is just a listing of temporary split files
if [ $single_file ]; then
    \rm $list
fi

if [ $ls_out = 'true' ]; then
	### List temporary output files
	\ls ${temp_out}_output_*
	#\rm ${temp_out}_output_*
else
	### Rejoin STDOUT and delete temporaries
	cat ${temp_out}_output_*
	\rm ${temp_out}_output_*
fi
