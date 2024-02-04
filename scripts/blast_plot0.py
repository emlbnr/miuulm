import pandas as pd
import matplotlib.pyplot as plt

blast_G_muris = pd.read_csv ('/Users/emelbiner/PycharmProjects/miuulm/output/G_muris.blastn', sep='\t', header=None)
blast_S_salmonicida = pd.read_csv ('/Users/emelbiner/PycharmProjects/miuulm/output/S_salmonicida.blastn')

blast_G_muris.columns = ['qseqid', 'sseqid', 'pident', 'length', 'mismatch', 'gapopen', 'qstart', 'qend', 'sstart', 'send', 'evalue', 'bitscore']
blast_S_salmonicida.columns = ['qseqid', 'sseqid', 'pident', 'length', 'mismatch', 'gapopen', 'qstart', 'qend', 'sstart', 'send', 'evalue', 'bitscore']

num_hits_blast_G_muris = len(blast_G_muris)
num_hits_blast_S_salmonicida = len(blast_S_salmonicida)

print("Number of hits for Giardia intestinalis vs. Giardia muris:", num_hits_blast_G_muris)
print("Number of hits for Giardia intestinalis vs. Spironucleus salmonicida:", num_hits_blast_S_salmonicida)

plt.show()


