#!/bin/bash
# Usage: bash run_feelnc.sh <input_gtf> <genome_fasta> <output_file>

set -e

input_gtf=$1
genome_fasta=$2
output_file=$3

# Extract transcript sequences
echo "[FEELnc] Preparing transcript FASTA..."
gffread -w transcripts.fa -g "$genome_fasta" "$input_gtf"

# Step 1: Filter
echo "[FEELnc] Filtering transcripts..."
FEELnc_filter.pl -i "$input_gtf" -a "$genome_fasta" -o filtered.gtf

# Step 2: Coding potential
echo "[FEELnc] Computing coding potential..."
FEELnc_codpot.pl -i filtered.gtf -a "$genome_fasta" -o codpot.txt

# Step 3: Classify
echo "[FEELnc] Classifying lncRNAs..."
FEELnc_classifier.pl -i filtered.gtf -a "$genome_fasta" -b codpot.txt -o "$output_file"

# Clean intermediate files
rm -f transcripts.fa filtered.gtf codpot.txt

echo "[FEELnc] Finished. Results in: $output_file"
