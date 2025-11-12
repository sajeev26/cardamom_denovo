# Snakefile
include: "workflow/rules/download.smk"
include: "workflow/rules/qc.smk"
include: "workflow/rules/trinity.smk"
include: "workflow/rules/quant.smk"
include: "workflow/rules/assembly_qc.smk"
include: "workflow/rules/cp.smk"
include: "workflow/rules/cleanup.smk"

configfile: "config/config.yaml"

rule all:
    input:
        "results/trinity/Trinity.fasta",
        "results/cpc2/final_CPC2.txt",
        "results/plek/final_PLEK.txt",
        "results/feelnc/final_FEELnc.txt",
        "results/transrate/transrate_results.tsv"
