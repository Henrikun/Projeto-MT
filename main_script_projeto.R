###############################################
#                                             #
#   Pasta do projeto no Github                #
#   https://github.com/Henrikun/Projeto-MT    #
#                                             #
#   Script ideializado e estruturado por:     #
#   Henrique C. Costa                         #
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

require(tidyverse)

require(sidrar)



# linha de codigo para baixar o dataframe dos municipios de Mato Grosso
source_data("https://github.com/Henrikun/Projeto-MT/blob/master/municipios_mt.Rdata?raw=true")

# load('municipios_mt.Rdata')


# verificar a lista de municipios de MT
municipios_mt


# esta linha criou um objeto "links_muni" contendo o API do sidraR para todos os municípios
links_muni <- paste0('/t/5457/p/all/n6/',municipios_mt$Código,'/c782/allxt')



# TODO
# Esta linha aplica em um lista a função para baixar os dados
# das lavouras permanentes e temporarias para os 141 municípios

munid1 <- lapply(links_muni, function(x) get_sidra(api=x))

# Porém, para exemplo, só esta baixando apenas para 5 municipios
# retirar ([1:5]) para baixar os dados de todos os municípios

# munid1 <- lapply(links_muni[1:5], function(x) get_sidra(api=x))



# comandos básicos
length(munid1)

head(munid1[[1]])

head(munid1[[2]])


munid1[[1]][1:5,1:4]


# Aplicando o comando "names" na lista dos dados
# para verificar os nomes das variáveis
lapply(munid1,names)


# Aplicando o comando "head" para ler os primeiros
# itens da lista
lapply(munid1,head)


# Aplicando o comando "dim" para verificar a demensão 
# das informações contidas na lista
lapply(munid1,dim)



# Testando a execução de um loop aplicado na lista
for(i in seq_along(munid1)){
  
  print(head(munid1[[i]]))
  
  #     print(i)
  
}



# Criando um novo objeto "dataframe"
munid2 <- municipios_mt

# convertendo em formato de lista
munid2 <- as.list(munid2)




# Aplicando um loop para executar algumas comandos

for(i in seq_along(munid1)){

  # removendo algumas variáveis indesejadas  
  munid2[[i]] <- munid1[[i]][,-c(1,3,4,7,9)]
  
  # modificando o nome de uma variável
  names(munid2[[i]])[2] <- "Código"
  
  # Removendo linhas contendo valores nulos "NA"
  munid2[[i]] <- munid2[[i]][complete.cases(munid2[[i]]), ]
  
}




# Executando novamente comandos básico para verificar se
# as modificações aplicadas foram efetivas

# mostrando os primeiros itens da lista
lapply(munid2,head)

# mostrando os ultimos itens da lista
lapply(munid2, tail)

# informa a dimenção da lista
lapply(munid2,dim)

# mostra os nomes das variáveis
lapply(munid2, names)


# para ver o primeiro item da lista (isaladamente)
munid2[[1]]

# ou
View(munid2[[1]])

# ou até mesmo criando um dataframe filrando apenas os dados para acorizal
acorizal <- as.data.frame(munid2[[1]])



# com isso, pode se usar o comando "filter" do pacote tidyverse para filtar
# as informações de acorizal



# ___________________________________________________



# Tabela com a população do censo de 2010 para os municípios brasileiros
tab200 = get_sidra(api = "/t/200/p/last/n6/all")



#  Filtrando apenas os municípios de Mato Grosso
pop.censu2010 <- tab200 %>% 
  filter(tab200$`Município (Código)` %in% municipios_mt$Código)




# existe um perigo, pois, os códigos dos municípios podem estar em ordem desigual
# para superar essa dificuldade é possível utilizar a função merge do pacote R base
# ou a função left_join do pacote dplyr


# verificando a dimensão
dim(municipios_mt);dim(pop.censu2010)


# adicionando informações do censu para o data frame dos municipios
municipios_mt[,4] <- pop.censu2010[,15]


# modificando nome da variável
names(municipios_mt)[4] <- "População Residente Censu 2010"


# verificando a lista de municipios
municipios_mt


# _______________________________________________


# Tabela da população estimada para todos os municipios brasileiros 2001-2017
tab6579 = get_sidra(api = "/t/6579/p/all/n6/all")


# filtrando a população estimada para os municipios de MT
pop_est2001_2017 <- tab6579 %>% 
  filter(tab6579$`Município (Código)` %in% municipios_mt$Código)


# Removendo colunas (variáveis) indesejadas
pop_est2001_2017 <- pop_est2001_2017[,-c(1,5,6,7,8)]

# modificando nome da coluna (variável)
names(pop_est2001_2017)[2] <- "Código"

# ordenando as informações por ano e municipio
pop_est2001_2017 <- arrange(pop_est2001_2017, Código)


# filtrando a população estimada para um municipio apenas (isaladamente)
# neste exemplo: Acorizal
pop_est2001_2017_acorizal <- pop_est2001_2017 %>% 
  filter(pop_est2001_2017$Código %in% municipios_mt[1,1])


# mostrar o dataframe da população estimada 
pop_est2001_2017

# mostrar o dataframe da população estimada para acorizal
pop_est2001_2017_acorizal




