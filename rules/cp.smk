# workflow/rules/coding_potential.smk

rule cpc2:
    input:
        "results/cdhit/transcripts.cdhit.fa"
    output:
        "results/cpc2/final_CPC2.txt"
    shell:
        "bash scripts/run_cpc2.sh {input} {output}"

rule plek:
    input:
        "results/cdhit/transcripts.cdhit.fa"
    output:
        "results/plek/final_PLEK.txt"
    shell:
        "bash scripts/run_plek.sh {input} {output}"

rule feelnc:
    input:
        "results/cdhit/transcripts.cdhit.fa"
    output:
        "results/feelnc/final_FEELnc.txt"
    shell:
        "bash scripts/run_feelnc.sh {input} {output}"
