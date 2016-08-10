---
layout: post
title: "Manipulação de dados - Parte 1: dplyr básico"
date: 2016-07-30 19:22:00 -0300
comments: true
categories: [geral]
published: true
---

Manipulação de dados é uma das habilidades mais básicas que um analista de dados deve ter. Nesse post ensinaremos as principais atividades relacionadas a manipulação de dados utilizando o pacote dplyr, um dos melhores pacotes disponíveis no R para essa finalidade.

<!-- More -->

## O pacote

O [dplyr](https://github.com/hadley/dplyr) é um pacote criado por [Hadley Wickham](https://github.com/hadley), um dos maiores colaboradores da comunidade R. Se você não o conhece e pretende seguir em frente com o R, certamente vai ouvir falar muito dele, pois ele criou diversos pacotes extremamente úteis e fáceis de usar (ggplot2, devtools, tidyr, strigr, etc...). O dplyr foi só um deles.

Trata-se de um pacote otimizado para manipulação de dados, não só com boa performance, mas com sintaxe simples e concisa, facilitando o aprendizado e tornando o pacote um dos preferidos para as tarefas do dia a dia.

O dplyr cobre praticamente todas as tarefas básicas da manipulação de dados: agregar, sumarizar, filtrar, ordenar, criar variáveis, joins, dentre outras.

Para começar, instale, carregue, e dê uma rápida olhada na documentação do dplyr. Em seguida cobriremos suas principais funcões:



{% highlight r %}
install.packages("dplyr")
library(dplyr)
?dplyr
{% endhighlight %}

## Verbetes do dplyr e o operador %>%

As principais tarefas de manipulação de dados podem ser resumidas em algumas simpels palavras, tal qual mencionamos na introdução do post. As funcões do dplyr simplesmente reproduzem essas palavras de forma bastante intuitiva. Veja só:

* select()
* filter()
* arrange()
* distinct()
* mutate()
* group_by()

Além de nomes de funcões intuitivos, o dplyr também faz uso de um recurso disponível em boa parte dos pacotes do Hadley, o operador `%>%`. 

Esse operador (originalmente do pacote [magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html), que trataremos em outros posts) encadeia as chamadas de funcões de forma que você não vai precisar ficar chamando uma função dentro da outra ou ficar fazendo atribuições para o fluxo de manipulações. Alias, podemos dizer que esse operador `%>%` literalmente cria um fluxo sequêncial bastante claro e legível para as atividades de manipulação. 

Passaremos todos os verbetes básicos encadeando um com o outro, explicando o uso das funções e do `%>%`, aos poucos seu uso ficará claro e intuitivo.

## Dados 

Vamos carregar uma pequena base de dados de testes para explicarmos os exemplos.

Escolhemos os dados de exportação e importação da Argentina, terceiro maior parceiro comercial do Brasil, que podem ser obtidos no [Comex Vis](http://www.mdic.gov.br/comercio-exterior/estatisticas-de-comercio-exterior/comex-vis/frame-pais?pais=arg), clicando em dados brutos.

Dando uma rapida olhada nos dados, temos:




{% highlight r %}
setwd("~/Development/R workspace")
arg <- read.csv("arg.csv", sep = ';', encoding = 'latin1')
str(arg)
{% endhighlight %}



{% highlight text %}
## 'data.frame':	29136 obs. of  14 variables:
##  $ TIPO               : Factor w/ 2 levels "EXPORTAÇÕES",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ PERIODO            : Factor w/ 2 levels "Jan-Jul","Total": 1 1 1 1 1 1 1 1 1 1 ...
##  $ CO_ANO             : int  2016 2016 2016 2016 2016 2016 2016 2016 2016 2016 ...
##  $ CO_PAIS            : int  63 63 63 63 63 63 63 63 63 63 ...
##  $ NO_PAIS            : Factor w/ 1 level "Argentina": 1 1 1 1 1 1 1 1 1 1 ...
##  $ SG_PAIS            : Factor w/ 1 level "ARG": 1 1 1 1 1 1 1 1 1 1 ...
##  $ CO_PAIS_ISOA3      : Factor w/ 1 level "ARG": 1 1 1 1 1 1 1 1 1 1 ...
##  $ CO_NCM_TRANSFORMADA: int  26020090 39079999 40091100 74199100 87169090 87032310 60063200 85044029 69022099 21012010 ...
##  $ NO_NCM             : Factor w/ 5310 levels "1-mentona","1,1,1,2-Tetrafluoroetano",..: 3478 3660 5140 2617 2662 335 3901 3767 2708 1192 ...
##  $ CO_PPE             : int  1260 3865 3861 3990 3743 3411 3853 3298 3105 3990 ...
##  $ NO_PPE_PPI         : Factor w/ 593 levels "Abacaxis frescos ou secos",..: 345 464 568 171 503 66 549 363 485 171 ...
##  $ NO_FAT_AGREG       : Factor w/ 4 levels "Operações Especiais",..: 2 3 3 3 3 3 3 3 3 3 ...
##  $ VL_FOB             : num  20504694 4890073 635805 53 3710470 ...
##  $ KG_LIQUIDO         : num  3.04e+08 1.56e+06 4.45e+04 0.00 2.08e+06 ...
{% endhighlight %}



{% highlight r %}
head(arg, 3)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO CO_ANO CO_PAIS   NO_PAIS SG_PAIS CO_PAIS_ISOA3
## 1 EXPORTAÇÕES Jan-Jul   2016      63 Argentina     ARG           ARG
## 2 EXPORTAÇÕES Jan-Jul   2016      63 Argentina     ARG           ARG
## 3 EXPORTAÇÕES Jan-Jul   2016      63 Argentina     ARG           ARG
##   CO_NCM_TRANSFORMADA
## 1            26020090
## 2            39079999
## 3            40091100
##                                                                                                                                                                                    NO_NCM
## 1 Outros minérios de manganês e seus concentrados, incluindo os minérios de manganês ferruginosos e seus concentrados, de teor em manganês de 20 % ou mais, em peso, sobre o produto seco
## 2                                                                                                                                                  Outros poliésteres em formas primárias
## 3                                                                                                              Tubo de borracha vulcanizada não endurecida, não reforçado, sem acessórios
##   CO_PPE                                      NO_PPE_PPI
## 1   1260        Minérios de manganês e seus concentrados
## 2   3865                             Poliesteres, outros
## 3   3861 Tubos de borracha vulcanizada e seus acessórios
##             NO_FAT_AGREG   VL_FOB KG_LIQUIDO
## 1       Produtos Básicos 20504694  303608000
## 2 Produtos Manufaturados  4890073    1562567
## 3 Produtos Manufaturados   635805      44480
{% endhighlight %}

## select()

O primeiro e mais simples verbete que comentaremos é usado para selecionar variáveis (colunas) do seu data frame. Não queremos todas as variáveis, queremos apenas os campos TIPO, PERIODO, NO_FAT_AGREG, VL_FOB, KG_LIQUIDO, para isso usaremos o select():


{% highlight r %}
arg.select <- arg %>% select(TIPO, PERIODO, NO_FAT_AGREG, VL_FOB, KG_LIQUIDO)
str(arg.select)
{% endhighlight %}



{% highlight text %}
## 'data.frame':	29136 obs. of  5 variables:
##  $ TIPO        : Factor w/ 2 levels "EXPORTAÇÕES",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ PERIODO     : Factor w/ 2 levels "Jan-Jul","Total": 1 1 1 1 1 1 1 1 1 1 ...
##  $ NO_FAT_AGREG: Factor w/ 4 levels "Operações Especiais",..: 2 3 3 3 3 3 3 3 3 3 ...
##  $ VL_FOB      : num  20504694 4890073 635805 53 3710470 ...
##  $ KG_LIQUIDO  : num  3.04e+08 1.56e+06 4.45e+04 0.00 2.08e+06 ...
{% endhighlight %}



{% highlight r %}
head(arg.select, 3)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO           NO_FAT_AGREG   VL_FOB KG_LIQUIDO
## 1 EXPORTAÇÕES Jan-Jul       Produtos Básicos 20504694  303608000
## 2 EXPORTAÇÕES Jan-Jul Produtos Manufaturados  4890073    1562567
## 3 EXPORTAÇÕES Jan-Jul Produtos Manufaturados   635805      44480
{% endhighlight %}

Repare que o mesmo efeito seria alcançado com uma seleção "negativa", ou seja, selecionado todos que devem sair:


{% highlight r %}
arg.select <- arg %>% select(-CO_ANO, -CO_PAIS, -NO_PAIS, -SG_PAIS, -CO_PAIS_ISOA3, -CO_NCM_TRANSFORMADA, -NO_NCM, -CO_PPE, -NO_PPE_PPI)
head(arg.select, 3)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO           NO_FAT_AGREG   VL_FOB KG_LIQUIDO
## 1 EXPORTAÇÕES Jan-Jul       Produtos Básicos 20504694  303608000
## 2 EXPORTAÇÕES Jan-Jul Produtos Manufaturados  4890073    1562567
## 3 EXPORTAÇÕES Jan-Jul Produtos Manufaturados   635805      44480
{% endhighlight %}

O resultado é exatamente o mesmo, use o que tiver que escrever menos, no nosso caso será a primeira opção.

Comparando com o procedimento em R base para obtero mesmo resultado, temos:


{% highlight r %}
arg.select.rbase <- arg[, c('TIPO', 'PERIODO', 'NO_FAT_AGREG', 'VL_FOB', 'KG_LIQUIDO')]
head(arg.select.rbase, 3)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO           NO_FAT_AGREG   VL_FOB KG_LIQUIDO
## 1 EXPORTAÇÕES Jan-Jul       Produtos Básicos 20504694  303608000
## 2 EXPORTAÇÕES Jan-Jul Produtos Manufaturados  4890073    1562567
## 3 EXPORTAÇÕES Jan-Jul Produtos Manufaturados   635805      44480
{% endhighlight %}

## filter()

Enquanto select diz respeito a quais campos você quer, o filter() diz respeito a quais linhas você quer. Em nosso exemplo, temos 2 ocorrências distintas em `TIPO`, vamos selecionar apenas exportação. Repare também que em `PERIODO` temos `Jan-Jul` e `Total`, queremos apenas o período `Jan-Jul` veja:


{% highlight r %}
unique(as.character(arg.select$TIPO)) #ocorrências únicas de um vetor
{% endhighlight %}



{% highlight text %}
## [1] "EXPORTAÇÕES" "IMPORTAÇÕES"
{% endhighlight %}



{% highlight r %}
unique(as.character(arg.select$PERIODO)) #ocorrências únicas de um vetor
{% endhighlight %}



{% highlight text %}
## [1] "Jan-Jul" "Total"
{% endhighlight %}



{% highlight r %}
arg.filter <- arg.select %>% filter(TIPO != 'IMPORTAÇÕES' & PERIODO == 'Jan-Jul')
unique(as.character(arg.filter$TIPO)) #ocorrências únicas de um vetor
{% endhighlight %}



{% highlight text %}
## [1] "EXPORTAÇÕES"
{% endhighlight %}



{% highlight r %}
unique(as.character(arg.filter$PERIODO)) #ocorrências únicas de um vetor
{% endhighlight %}



{% highlight text %}
## [1] "Jan-Jul"
{% endhighlight %}

Para comparar, o mesmo resultado seria obtido com o R base da seguinte forma:


{% highlight r %}
arg.filter.rbase <- arg.select[arg.select$TIPO != 'IMPORTAÇÕES' & arg.select$PERIODO == 'Jan-Jul', ]
dim(arg.filter) #número de linhas e colunas
{% endhighlight %}



{% highlight text %}
## [1] 11008     5
{% endhighlight %}



{% highlight r %}
dim(arg.filter.rbase) #número de linhas e colunas
{% endhighlight %}



{% highlight text %}
## [1] 11008     5
{% endhighlight %}

## arrange()

Selecionamos os campos com o select(), filtramos as linhas com o filter(), agora queremos ordenar os resultados e para isso usaremos o arrange().

Queremos ordernar nossos dados filtrados por ordem alfabética de `NO_FAT_AGREG` e ordem decrescente de `VL_FOB`.


{% highlight r %}
arg.arrange <- arg.filter %>% arrange(NO_FAT_AGREG, desc(VL_FOB))
head(arg.arrange)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO        NO_FAT_AGREG  VL_FOB KG_LIQUIDO
## 1 EXPORTAÇÕES Jan-Jul Operações Especiais 9023778    7894708
## 2 EXPORTAÇÕES Jan-Jul Operações Especiais 7265362    1841428
## 3 EXPORTAÇÕES Jan-Jul Operações Especiais 5964271    3392399
## 4 EXPORTAÇÕES Jan-Jul Operações Especiais 5565702    8639868
## 5 EXPORTAÇÕES Jan-Jul Operações Especiais 5057158   10482224
## 6 EXPORTAÇÕES Jan-Jul Operações Especiais 4203581    2527950
{% endhighlight %}



{% highlight r %}
tail(arg.arrange)
{% endhighlight %}



{% highlight text %}
##              TIPO PERIODO               NO_FAT_AGREG VL_FOB
## 11003 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados     50
## 11004 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados     40
## 11005 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados     38
## 11006 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados     20
## 11007 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados     13
## 11008 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados      3
##       KG_LIQUIDO
## 11003         10
## 11004          6
## 11005          0
## 11006          0
## 11007          0
## 11008          0
{% endhighlight %}

O mesmo restulado com o R base seria o seguinte:


{% highlight r %}
arg.arrang.rbase <- arg.filter[order(NO_FAT_AGREG, -VL_FOB), ]
{% endhighlight %}



{% highlight text %}
## Error in order(NO_FAT_AGREG, -VL_FOB): objeto 'NO_FAT_AGREG' não encontrado
{% endhighlight %}



{% highlight r %}
head(arg.arrange)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO        NO_FAT_AGREG  VL_FOB KG_LIQUIDO
## 1 EXPORTAÇÕES Jan-Jul Operações Especiais 9023778    7894708
## 2 EXPORTAÇÕES Jan-Jul Operações Especiais 7265362    1841428
## 3 EXPORTAÇÕES Jan-Jul Operações Especiais 5964271    3392399
## 4 EXPORTAÇÕES Jan-Jul Operações Especiais 5565702    8639868
## 5 EXPORTAÇÕES Jan-Jul Operações Especiais 5057158   10482224
## 6 EXPORTAÇÕES Jan-Jul Operações Especiais 4203581    2527950
{% endhighlight %}



{% highlight r %}
tail(arg.arrange)
{% endhighlight %}



{% highlight text %}
##              TIPO PERIODO               NO_FAT_AGREG VL_FOB
## 11003 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados     50
## 11004 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados     40
## 11005 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados     38
## 11006 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados     20
## 11007 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados     13
## 11008 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados      3
##       KG_LIQUIDO
## 11003         10
## 11004          6
## 11005          0
## 11006          0
## 11007          0
## 11008          0
{% endhighlight %}

## distinct()

## mutate()

## group_by()

## Referências

[teste](teste)
