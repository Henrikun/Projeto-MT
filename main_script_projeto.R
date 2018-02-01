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

# Baixar a tabela lavouras temporárias e permanentes cultivadas em Acorizal
tab5457_Acorizal = get_sidra(api='/t/5457/p/all/n6/5100102/c782/allxt')

# linha de codigo para remover colunas indesejadas
tab5457_Acorizal <- tab5457_Acorizal[,-c(1,3,4,7,9)]

# renomear uma coluna (variavel)
names(tab5457_Acorizal)[2] <- "Código"
names(tab5457_Acorizal)
# Colocar o dataframe "Acorizal" dentro da lista "municipios_mt" 
# comando 'complete.case' para limpar o dataframe removendo
# as linhas que continham valores NA's 
dados.municipios.mt[[1]] <- tab5457_Acorizal[complete.cases(tab5457_Acorizal), ]













