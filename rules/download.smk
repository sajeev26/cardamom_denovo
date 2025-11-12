# workflow/rules/download.smk

SAMPLES, = glob_wildcards("data/{sample}.sra")

rule download_sra:
    input:
        "data/sra_accessions.txt"
    output:
        temp("results/raw/{sample}_1.fastq.gz"),
        temp("results/raw/{sample}_2.fastq.gz")
    params:
        outdir="results/raw"
    threads: 4
    shell:
        """
        fasterq-dump --split-files --gzip -O {params.outdir} {wildcards.sample}
        """
