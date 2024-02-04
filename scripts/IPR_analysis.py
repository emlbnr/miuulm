import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("/Users/emelbiner/PycharmProjects/miuulm/resource/Genome/interproscan/G_muris_IPR.tsv", sep="\t",
                 names=list(range(0, 15)),
                 engine='python', quoting=3)
selected_columns = df.iloc[:, [0, 3, 4, 5, 11, 12]]


df_ipr = df[[0, 11]]
df_ipr = df_ipr.dropna().drop_duplicates().rename(columns={0: "id", 11: "ipr"})

df_ipr["ipr"].value_counts()[:10].plot(kind="bar")

plt.show()
