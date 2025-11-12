# workflow/rules/trinity.smk

SAMPLES = [line.strip() for line in open("data/sra_accessions.txt") if line.strip()]

rule trinity_assembly:
    input:
        r1=expand("results/trimmed/{sample}_1.trim.fastq.gz", sample=SAMPLES),
        r2=expand("results/trimmed/{sample}_2.trim.fastq.gz", sample=SAMPLES)
    output:
        "results/trinity/Trinity.fasta"
    params:
        mem=config["trinity_max_memory"],
        cpu=config["threads"]
    shell:
        """
        Trinity --seqType fq \
                 --left {input.r1} --right {input.r2} \
                 --max_memory {params.mem} \
                 --CPU {params.cpu} \
                 --output results/trinity/trinity_out
        cp results/trinity/trinity_out/Trinity.fasta {output}
        """

rule cdhit_reduce:
    input:
        "results/trinity/Trinity.fasta"
    output:
        "results/cdhit/transcripts.cdhit.fa"
    params:
        id=config["cdhit_identity"]
    threads: config["threads"]
    shell:
        "cd-hit-est -i {input} -o {output} -c {params.id} -T {threads} -M 0"
