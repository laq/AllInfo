#Normaly one may want to concatenate many log files, then order them, by time for 
#example and then printing them as pretty as its possible

# The following command does all that

zcat * | grep -v Fields | grep -v Version | grep sessions |sort -s -k2,2 | column -t |  less -Si

#zcat cat ziped files with bash expansion
#remove header files from all files that are just noise when using column
# sort by a column and only by it -k2,2 (if just -k2 it will sort by column 2 and use the other columns 3,4.. as strings) and use -s to do a stable sort where last-resort is avoided
  #"equal keys are left in the order they came, not ordered as strings "
# Split the columns so that they are visible as in a table with option -t
# Show the content paged without word wraping -S and ignoring case on searches -i
