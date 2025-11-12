# workflow/rules/quant.smk

rule salmon_index:
    input:
        "results/cdhit/transcripts.cdhit.fa"
    output:
        directory("results/salmon/index")
    shell:
        "salmon index -t {input} -i {output} -k 31"

rule salmon_quant:
    input:
        index="results/salmon/index",
        r1="results/trimmed/{sample}_1.trim.fastq.gz",
        r2="results/trimmed/{sample}_2.trim.fastq.gz"
    output:
        "results/salmon/{sample}/quant.sf"
    threads: config["threads"]
    shell:
        """
        salmon quant -i {input.index} \
                     -l A -1 {input.r1} -2 {input.r2} \
                     -p {threads} -o results/salmon/{wildcards.sample}
        """
