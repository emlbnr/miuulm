#Verilen diziyi tersine çevirir.
def ters_cevir(dizi):
    return dizi[::-1]

#baska neler yapabiliriz?

dna_dizisi = "AGCTATAG"
ters_dna_dizisi = ters_cevir(dna_dizisi)

ters_cevir(dna_dizisi)
if ters_dna_dizisi == dna_dizisi:
    print("DNA dizisi ve ters çevrilmiş hali aynı.")
else :
    print("DNA dizisi ve ters çevrilmiş hali farklı.")


    def birleşik_dna(dna_dizisi, ters_dna_dizisi):

    birlesik_dna = dna_dizisi + ters_dna_dizisi
        return birleşik_dna
    print("Birleşik DNA dizisi.", birlesik_dna)

    def nukleotid_say(dizi, nukleotid):
        return dizi.count(nukleotid)
birleşik_dna = dna_dizisi + ters_dna_dizisi
    adenin_sayısı = nukleotid_say(birleşik_dna,'A')
    print("Birleşik DNA'daki adenin sayısı:", adenin_sayısı)





