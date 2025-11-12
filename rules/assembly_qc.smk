# workflow/rules/assembly_qc.smk

rule transrate:
    input:
        assembly="results/cdhit/transcripts.cdhit.fa",
        reads=expand("results/trimmed/{sample}_1.trim.fastq.gz", sample=SAMPLES)
    output:
        "results/transrate/transrate_results.tsv"
    threads: config["threads"]
    shell:
        """
        transrate --assembly {input.assembly} \
                  --left {input.reads} \
                  --threads {threads} \
                  --output results/transrate
        touch {output}
        """

rule busco:
    input:
        "results/cdhit/transcripts.cdhit.fa"
    output:
        "results/busco/short_summary.txt"
    params:
        lineage=config["busco_lineage"],
        mode=config["busco_mode"]
    threads: config["threads"]
    shell:
        """
        busco -i {input} -l {params.lineage} \
              -m {params.mode} -o results/busco/run \
              -c {threads}
        """
