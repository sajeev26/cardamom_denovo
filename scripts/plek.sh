#!/bin/bash
# Usage: bash run_plek.sh <input_gtf> <genome_fasta> <output_file>

set -e

input_gtf=$1
genome_fasta=$2
output_file=$3

# Extract transcript FASTA from GTF
echo "[PLEK] Extracting transcript sequences..."
gffread -w transcripts.fa -g "$genome_fasta" "$input_gtf"

# Run PLEK (Python2/3 compatible)
echo "[PLEK] Running PLEK..."
python3 /opt/PLEK/PLEK.py -fasta transcripts.fa -out "$output_file" -thread 4

# Clean up
rm -f transcripts.fa

echo "[PLEK] Completed. Output written to: $output_file"
