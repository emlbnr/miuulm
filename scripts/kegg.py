import pandas as pd

eggnog = "/Users/emelbiner/PycharmProjects/miuulm/resource/eggnog/G_intestinalis.csv"
out_file = "/Users/emelbiner/PycharmProjects/miuulm/data/kegg_wb.csv"

df = pd.read_csv(eggnog, sep="\t", header="infer")

# split the column into multiple columns
df_kegg = df.dropna(subset=["KEGG_KOs"])["KEGG_KOs"].str.split(",", expand=True)
# merge all columns into one
df_kegg_melt = pd.melt(df_kegg, value_name="KEGG_KOs").dropna(subset=["KEGG_KOs"])

# drop duplicates
df_kegg_melt = df_kegg_melt.drop_duplicates(subset=["KEGG_KOs"])
# sort
df_kegg_melt_sort = df_kegg_melt.sort_values(by=["variable"], ascending=False)
# save
df_kegg_melt_sort["KEGG_KOs"].to_csv(out_file, sep="\t", index=False, header=False)
