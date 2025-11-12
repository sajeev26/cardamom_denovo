#!/bin/bash
# Usage: bash run_cpc2.sh <input_gtf> <genome_fasta> <output_dir>

set -e  # stop if any command fails

input_gtf=$1
genome_fasta=$2
output_file=$3

# Extract transcript sequences from GTF using gffread
echo "[CPC2] Extracting transcript sequences..."
gffread -w transcripts.fa -g "$genome_fasta" "$input_gtf"

# Run CPC2
echo "[CPC2] Running CPC2..."
python3 /opt/CPC2_standalone/bin/CPC2.py -i transcripts.fa -o "$output_file"

# Clean intermediate files
rm -f transcripts.fa

echo "[CPC2] Finished successfully. Results saved in: $output_file"
