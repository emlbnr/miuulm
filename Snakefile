rule all:
    input:
       # "output/tRNA_scan_result.txt",
       # "output/G_intestinalis.tRNA",
       # expand("output/tRNAscan/{sp}.tRNA", sp = ["G_muris", "G_intestinalis"]),
       # expand("output/tRNAscan/{sp}.tRNA", sp =["G_muris", "S_salmonicida"]),
        #expand("output/blastn/G_intestinalis/{sp}.blastn", sp = ["G_muris", "S_salmonicida"]),
        #expand("output/barrnap/{genome}_rrna_count.gff", genome=['G_intestinalis', 'G_muris', 'S_salmonicida']),
        "output/orthofinder/"

rule tRNAscan:
    input: "resource/fasta/G_intestinalis.fasta"
    output: "output/tRNA_scan_result.txt"
    conda: "envs/env.yaml"
    shell: 'bash scripts/tRNAscan.sh {input} {output}'

rule tRNAscan_stats:
    input:
            genome = "resource/fasta/G_intestinalis.fasta"
    output:
            tRNA = "output/G_intestinalis.tRNA",
            stats = "output/G_intestinalis.stats"
    params:
            threads = 2
    conda:
            "envs/env.yaml"
    script:
            "scripts/tRNAscan_stats.py"

rule tRNAscan_stats_wildcard:
    input:
        genome = "resource/fasta/{genome}.fasta"
    output:
        tRNA = "output/tRNAscan/{genome}.tRNA",
        stats = "output/tRNAscan/{genome}.stats"
    params:
        threads = 2
    conda:
        "envs/env.yaml"
    script:
        "scripts/tRNAscan_stats.py"

rule makeblastdb:
    input:
        "resource/{type}/db/{db}.fasta"
    output:
        "output/{type}/db/{db}.ndb",
        "output/{type}/db/{db}.nhr",
        "output/{type}/db/{db}.nin",
        "output/{type}/db/{db}.not",
        "output/{type}/db/{db}.nsq",
        "output/{type}/db/{db}.ntf",
        "output/{type}/db/{db}.nto"
    params:
        outname = "output/{type}/db/{db}"
    #conda: "/home/alperen_uysal/miniconda3/envs/blast"
    shell:
        'makeblastdb -dbtype nucl -in {input} -out {params.outname}'

rule blastn:
    input:
        query = "resource/{type}/query/{query}.fasta",
        db = "output/{type}/db/{db}.ndb"
    output:
        'output/{type}/{db}/{query}.blastn'
    params:
        perc_identity = 95,
        outfmt = 6,
        num_threads = 2,
        max_target_seqs = 1,
        max_hsps = 1,
        db_prefix = "output/{type}/db/{db}"
    #conda: "/home/alperen_uysal/miniconda3/envs/blast"
    script:
        "scripts/blastn.py"

rule orthofinder:
    input:
        fasta = "resource/orthofinder/",
    output:
        directory("output/orthofinder/")
    conda:
        "envs/env.yaml"
    script:
        "scripts/orthofinder.py/"






