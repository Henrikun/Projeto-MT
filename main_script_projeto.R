#   Pasta do projeto no Github
#   https://github.com/Henrikun/Projeto-MT


#install.packages(repmis)
require(repmis)
# linha de codigo para baixar o dataframe dos municipios de Mato Grosso
source_data("https://github.com/Henrikun/Projeto-MT/blob/master/municipios_mt.Rdata?raw=true")

View(municipios_mt)

#  Transformar o dataframe em lista com dataframe
dados.municipios.mt <- as.list(municipios_mt$Município)
is.list(dados.municipios.mt)

# install.packages(sidrar)
require(sidrar)

# Baixar a tabela lavouras temporarias cultivadas em Acorizal
lav.temporaria_Acorizal = get_sidra(api='/t/1612/p/last/n6/5100102/c81/allxt')

# linha de codigo para remover colunas indesejadas
lav.temporaria_Acorizal <- lav.temporaria_Acorizal[,-c(1,3,4,7,9)]

# renomear uma coluna (variavel)
names(lav.temporaria_Acorizal)[2] <- "Código"
names(lav.temporaria_Acorizal)
# Colocar o dataframe "Acorizal" dentro da lista "municipios_mt" 
# comando 'complete.case' para limpar o dataframe removendo
# as linhas que continham valores NA's 
dados.municipios.mt[[1]] <- lav.temporaria_Acorizal[complete.cases(lav.temporaria_Acorizal), ]













