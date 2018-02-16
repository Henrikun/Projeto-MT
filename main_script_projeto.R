###############################################
#                                             #
#   Pasta do projeto no Github                #
#   https://github.com/Henrikun/Projeto-MT    #
#                                             #
#   Script ideializado e estruturado por:     #
#   Henrique c. Costa                         #
#   Correção e apoio: Roney Fraga.            #
#                                             #
###############################################

#**********************************************
#  Instalação dos pacotes necessários  
#                                            
# install.packages('tidyverse')
# install.packages('repmis')
# install.packages('sidrar')
require(repmis)
require(dplyr)
require(sidrar)

# linha de codigo para baixar o dataframe dos municipios de Mato Grosso
source_data("https://github.com/Henrikun/Projeto-MT/blob/master/municipios_mt.Rdata?raw=true")

# load('municipios_mt.Rdata')

municipios_mt

links_muni <- paste0('/t/5457/p/all/n6/',municipios_mt$Código,'/c782/allxt')

# TODO
# retirar [1:5] para baixar os dados de todos os municípios
munid1 <- lapply(links_muni[1:5], function(x) get_sidra(api=x))

length(munid1)

head(munid1[[1]])
head(munid1[[2]])

munid1[[1]][1:5,1:4]

lapply(munid1,names)
lapply(munid1,head)
lapply(munid1,dim)

for(i in seq_along(munid1)){
    print(head(munid1[[i]]))
    #     print(i)
}

munid2 <- municipios_mt
munid2 <- as.list(munid2)

for(i in seq_along(munid1)){
    munid2[[i]] <- munid1[[i]][,-c(1,3,4,7,9)]
    names(munid2[[i]])[2] <- "Código"
    munid2[[i]] <- munid2[[i]][complete.cases(munid2[[i]]), ]
}

lapply(munid2,head)
lapply(munid2,dim)
lapply(munid2, names)

# Tabela com a população do censo de 2010 para os municípios brasileiros
tab200 = get_sidra(api = "/t/200/p/last/n6/all")

#  Filtrando apenas os municípios de Mato Grosso
pop.censu2010 <- tab200 %>% 
  filter(tab200$`Município (Código)` %in% municipios_mt$Código)


# existe um perigo, pois, os códigos dos municípios podem estar em ordem desigual
# para superar essa dificuldade é possível utilizar a função merge do pacote R base
# ou a função left_join do pacote dplyr

dim(municipios_mt);dim(pop.censu2010)

municipios_mt[,4] <- pop.censu2010[,15]
names(municipios_mt[,4]) <- names("População Residente Censu 2010")
municipios_mt <- municipios_mt[,-4]
