#rule all:
   # input: #"output/tRNA_scan_result.txt",
     #   "output/G_intestinalis.tRNA"

#rule tRNAscan:
       # input: "resource/fasta/G_intestinalis.fasta"
       # output: "output/tRNAscan_result.txt"
       # shell: "bash run_tRNAscan.sh {input} -o {output}"

#rule tRNAscan_stats:
  #  input:
     #   genome= "resource/fasta/G_intestinalis.fasta"
  #  output:
   #     tRNA= "output/G_intestinalis.tRNA",
   #     stats= "output/G_intestinalis.stats"
 #   params:
  #      thread= 2

  #  conda:
  #      "envs/env.yaml"
 #   script:
    #    "scripts/tRNAscan_stats.py"

rule tRNAscan_stats_wildcard:
    input:
        genome="resource/fasta/{genome}.fasta"
    output:
        tRNA="output/tRNAscan/{genome}.tRNA",
        stats="output/tRNA/{genome}stats"
    params:
        threads=2
    conda:
        "envs/env.yaml"
    script:
        "scripts/tRNAscan_stats.py"

rule all:
    input: "output/tRNAscan_result.txt",
           "output/tRNAscan/G_intestinalis.tRNA",
     expand ("output/{sp}.tRNA", sp= ["G_muris","G_intestinalisv"]),

rule tRNAscan_stats_wildcard:
    input:
        genome= "resource/fasta/{genome}fasta"
    output:
        tRNA="output/tRNAscan/{genome}tRNA",
        stats="output/tRNAscan/{genome}.stats"
    params:
        threads=2
    conda:
        "env/env.yaml"
    script:
        "scripts/tRNAscan_stats.py"

rule makeblastdb:
    input:
        "resource/{type}/db/{db}.fasta"
    output:
        "output/{type}/db/{db}.ndb"
        "output/{type}/db/{db}.nhr"
        "output/{type}/db/{db}.nin"
        "output/{type}/db/{db}.not"
        "output/{type}/db/{db}.nsq"
        "output/{type}/db/{db}.ntf"
        "output/{type}/db/{db}.nto"
    params:
        outname="output/{type}/db/{db}"
    shell:
        'makeblastd -dbtype nucl -in {input} -out {params.outname}'

rule all:
    input: "output/tRNA_scan_result.txt",
           "output/tRNAscan/G_intestinalis.tRNA",
        expand("output/tRNAscan/{sp}.tRNA", sp=["G_muris, G_intestinalis]),
        expand("output/blastn/G_intestinalis/{sp}.blastn", sp=["G_muris", "S_salmonicida"])

rule blastn:
    input:
        query="resources/fasta/{type}/query/{query}.fasta",
        db="output/{type}/db/{db}ndb/"
    output:
        'output/{type}/{db}/{query}blastn'
    params:
        perc_identity=95,
        outfmt=6,
        num_threads=2,
        max_target_seqs=1,
        max_hsps=1,
        db_prefix="output/{type}/db/{db}"
    script:
        "scripts/blastn.py"





