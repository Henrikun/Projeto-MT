

#############################################################
# Primeiro lemos o ficheiro com read.csv.
# De seguida mudei o nome da quarta coluna 
# (é lido como "Weight....").
# Finalmente, algumas colunas que parecem ser numéricas devem ser 
# transformadas de classe factor para classe numeric, com a função 
# auxiliar str2num.

str2num <- function(x){
  x <- gsub(",", "", x)
  as.numeric(x)
}

URI <- "https://www.ishares.com/us/products/239600/ishares-msci-acwi-etf/1467271812596.ajax?fileType=csv&fileName=ACWI_holdings&dataType=fund&asOfDate=20141231"
dados <- read.csv(URI, skip = 10, na.strings = c("", "-"))

names(dados)[4] <- "Weight"
cols <- c("Price", "Shares", "Market.Value", "FX.Rate")
dados[cols] <- lapply(dados[cols], str2num)
str(dados)
dados
#############################################################



library(tidyverse)
resultado <- Acorizal %>% group_by(Acorizal[,2]) 
resultado


tab = municipios_mt[[1]]
attach(tab)
tab1 = tab %>% filter(Código=="2711")
tab2 = t(tab1[1:5,6]) 
tab2 = as.data.frame(tab2)
names(tab2) = t(tab1[1:5,4])
names(tab2)
attach(tab2)
rm(tab1)
tab2[1,1:5] <- t(tab[1:5,6])
tab2[2,1:5] <- t(tab[6:10,6])
tab2[3,1:5] <- t(tab[11:15,6])
tab2[4,1:5] <- t(tab[16:20,6])
tab2[5,1:5] <- t(tab[21:25,6])
tab2[6,1:5] <- t(tab[26:30,6])
tab2[7,1:5] <- t(tab[31:35,6])


a <- rbind(tab[1:5,6])
tabl <- a
a <- rbind(tab[6:10,6])

colnames(tabl) <- tab[1:5,4]

tabl3 <- cbind(a,b)
rownames(tabl3) <- c("1", "2", "3", "4")
colnames(tabl3) <- c("A", "B")

v = tab$Valor

for(i in seq(from=1, to= length(tab$Valor), by=5)){
  #  stuff, such as
  print(i)
}

require(sidrar)
tab5457_Acorizal = get_sidra(api='/t/5457/p/last/n6/5100102/c782/allxt')
tab5457_Acorizal = tab5457_Acorizal[complete.cases(tab5457_Acorizal), ]
