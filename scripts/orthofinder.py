from snakemake.shell import shell

fasta = snakemake.input.fasta
out = snakemake.output

shell(f"""orthofinder -f {fasta} -og""")