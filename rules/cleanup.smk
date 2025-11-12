# workflow/rules/cleanup.smk

rule cleanup_temp:
    shell:
        """
        rm -rf results/raw/*.fastq.gz
        rm -rf results/trinity/trinity_out/chrysalis
        rm -rf results/trinity/trinity_out/inchworm.K25.L25.DS
        """
