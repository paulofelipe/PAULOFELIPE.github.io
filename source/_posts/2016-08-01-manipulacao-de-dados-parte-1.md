---
layout: post
title: "Manipulação de dados - Parte 1: dplyr básico"
date: 2016-07-30 19:22:00 -0300
comments: true
categories: [geral]
published: true
---

Dominar a manipulação de dados é uma das habilidades mais básicas que um analista de dados deve ter. Nesse post ensinaremos as principais atividades relacionadas a manipulação de dados utilizando o pacote dplyr, um dos melhores pacotes disponíveis no R para essa finalidade.

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
* mutate()
* group_by()
* summarise()

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
## 'data.frame':	3286 obs. of  10 variables:
##  $ TIPO         : Factor w/ 2 levels "EXPORTAÇÕES",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ PERIODO      : Factor w/ 2 levels "Jan-Jul","Total": 1 1 1 1 1 1 1 1 1 1 ...
##  $ CO_ANO       : int  2014 2014 2014 2014 2014 2014 2014 2014 2014 2014 ...
##  $ CO_PAIS      : int  63 63 63 63 63 63 63 63 63 63 ...
##  $ NO_PAIS      : Factor w/ 1 level "Argentina": 1 1 1 1 1 1 1 1 1 1 ...
##  $ CO_PAIS_ISOA3: Factor w/ 1 level "ARG": 1 1 1 1 1 1 1 1 1 1 ...
##  $ NO_PPE_PPI   : Factor w/ 593 levels "Abacaxis frescos ou secos",..: 1 2 3 5 8 9 10 11 15 17 ...
##  $ NO_FAT_AGREG : Factor w/ 4 levels "Operações Especiais",..: 2 3 3 3 3 4 3 3 3 2 ...
##  $ VL_FOB       : num  164490 5513295 17367531 4361844 77117330 ...
##  $ KG_LIQUIDO   : num  210336 716749 1197004 1155458 68853741 ...
{% endhighlight %}



{% highlight r %}
head(arg, 3)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO CO_ANO CO_PAIS   NO_PAIS CO_PAIS_ISOA3
## 1 EXPORTAÇÕES Jan-Jul   2014      63 Argentina           ARG
## 2 EXPORTAÇÕES Jan-Jul   2014      63 Argentina           ARG
## 3 EXPORTAÇÕES Jan-Jul   2014      63 Argentina           ARG
##                                         NO_PPE_PPI
## 1                        Abacaxis frescos ou secos
## 2     Abrasivos e pedras para amolar e semelhantes
## 3 Aceleradores de reação e preparações catalíticas
##             NO_FAT_AGREG   VL_FOB KG_LIQUIDO
## 1       Produtos Básicos   164490     210336
## 2 Produtos Manufaturados  5513295     716749
## 3 Produtos Manufaturados 17367531    1197004
{% endhighlight %}

## select()

O primeiro e mais simples verbete que comentaremos é usado para selecionar variáveis (colunas) do seu data frame. Não queremos todas as variáveis, queremos apenas os campos TIPO, CO_ANO, PERIODO, NO_FAT_AGREG, VL_FOB, KG_LIQUIDO, para isso usaremos o select():


{% highlight r %}
arg.select <- arg %>% select(TIPO, PERIODO, CO_ANO, NO_FAT_AGREG, NO_PPE_PPI, VL_FOB, KG_LIQUIDO)
str(arg.select)
{% endhighlight %}



{% highlight text %}
## 'data.frame':	3286 obs. of  7 variables:
##  $ TIPO        : Factor w/ 2 levels "EXPORTAÇÕES",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ PERIODO     : Factor w/ 2 levels "Jan-Jul","Total": 1 1 1 1 1 1 1 1 1 1 ...
##  $ CO_ANO      : int  2014 2014 2014 2014 2014 2014 2014 2014 2014 2014 ...
##  $ NO_FAT_AGREG: Factor w/ 4 levels "Operações Especiais",..: 2 3 3 3 3 4 3 3 3 2 ...
##  $ NO_PPE_PPI  : Factor w/ 593 levels "Abacaxis frescos ou secos",..: 1 2 3 5 8 9 10 11 15 17 ...
##  $ VL_FOB      : num  164490 5513295 17367531 4361844 77117330 ...
##  $ KG_LIQUIDO  : num  210336 716749 1197004 1155458 68853741 ...
{% endhighlight %}



{% highlight r %}
head(arg.select, 3)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO CO_ANO           NO_FAT_AGREG
## 1 EXPORTAÇÕES Jan-Jul   2014       Produtos Básicos
## 2 EXPORTAÇÕES Jan-Jul   2014 Produtos Manufaturados
## 3 EXPORTAÇÕES Jan-Jul   2014 Produtos Manufaturados
##                                         NO_PPE_PPI   VL_FOB
## 1                        Abacaxis frescos ou secos   164490
## 2     Abrasivos e pedras para amolar e semelhantes  5513295
## 3 Aceleradores de reação e preparações catalíticas 17367531
##   KG_LIQUIDO
## 1     210336
## 2     716749
## 3    1197004
{% endhighlight %}

Repare que o mesmo efeito seria alcançado com uma seleção "negativa", ou seja, selecionado todos que devem sair:


{% highlight r %}
arg.select <- arg %>% select(-CO_PAIS, -NO_PAIS, -CO_PAIS_ISOA3)
head(arg.select, 3)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO CO_ANO
## 1 EXPORTAÇÕES Jan-Jul   2014
## 2 EXPORTAÇÕES Jan-Jul   2014
## 3 EXPORTAÇÕES Jan-Jul   2014
##                                         NO_PPE_PPI
## 1                        Abacaxis frescos ou secos
## 2     Abrasivos e pedras para amolar e semelhantes
## 3 Aceleradores de reação e preparações catalíticas
##             NO_FAT_AGREG   VL_FOB KG_LIQUIDO
## 1       Produtos Básicos   164490     210336
## 2 Produtos Manufaturados  5513295     716749
## 3 Produtos Manufaturados 17367531    1197004
{% endhighlight %}

O resultado é exatamente o mesmo, use o que tiver que escrever menos, no nosso caso será a primeira opção.

Comparando com o procedimento em R base para obtero mesmo resultado, temos:


{% highlight r %}
arg.select.rbase <- arg[, c('TIPO', 'PERIODO', 'CO_ANO', 'NO_FAT_AGREG', 'NO_PPE_PPI',  'VL_FOB', 'KG_LIQUIDO')]
head(arg.select.rbase, 3)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO CO_ANO           NO_FAT_AGREG
## 1 EXPORTAÇÕES Jan-Jul   2014       Produtos Básicos
## 2 EXPORTAÇÕES Jan-Jul   2014 Produtos Manufaturados
## 3 EXPORTAÇÕES Jan-Jul   2014 Produtos Manufaturados
##                                         NO_PPE_PPI   VL_FOB
## 1                        Abacaxis frescos ou secos   164490
## 2     Abrasivos e pedras para amolar e semelhantes  5513295
## 3 Aceleradores de reação e preparações catalíticas 17367531
##   KG_LIQUIDO
## 1     210336
## 2     716749
## 3    1197004
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
## [1] 1012    7
{% endhighlight %}



{% highlight r %}
dim(arg.filter.rbase) #número de linhas e colunas
{% endhighlight %}



{% highlight text %}
## [1] 1012    7
{% endhighlight %}

## arrange()

Selecionamos os campos com o select(), filtramos as linhas com o filter(), agora queremos ordenar os resultados e para isso usaremos o arrange().

Queremos ordernar nossos dados filtrados por ordem alfabética de `NO_FAT_AGREG` e ordem decrescente de `VL_FOB`.


{% highlight r %}
arg.arrange <- arg.filter %>% arrange(NO_FAT_AGREG, desc(VL_FOB))
head(arg.arrange)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO CO_ANO                              NO_PPE_PPI
## 1 EXPORTAÇÕES Jan-Jul   2014 Consumo de bordo - óleos e combustíveis
## 2 EXPORTAÇÕES Jan-Jul   2016                            Reexportação
## 3 EXPORTAÇÕES Jan-Jul   2014                            Reexportação
## 4 EXPORTAÇÕES Jan-Jul   2015 Consumo de bordo - óleos e combustíveis
## 5 EXPORTAÇÕES Jan-Jul   2016 Consumo de bordo - óleos e combustíveis
## 6 EXPORTAÇÕES Jan-Jul   2015                            Reexportação
##          NO_FAT_AGREG  VL_FOB KG_LIQUIDO
## 1 Operações Especiais 9023778    7894708
## 2 Operações Especiais 7265362    1841428
## 3 Operações Especiais 5964271    3392399
## 4 Operações Especiais 5565702    8639868
## 5 Operações Especiais 5057158   10482224
## 6 Operações Especiais 4203581    2527950
{% endhighlight %}



{% highlight r %}
tail(arg.arrange)
{% endhighlight %}



{% highlight text %}
##             TIPO PERIODO CO_ANO
## 1007 EXPORTAÇÕES Jan-Jul   2016
## 1008 EXPORTAÇÕES Jan-Jul   2016
## 1009 EXPORTAÇÕES Jan-Jul   2016
## 1010 EXPORTAÇÕES Jan-Jul   2015
## 1011 EXPORTAÇÕES Jan-Jul   2015
## 1012 EXPORTAÇÕES Jan-Jul   2014
##                                                  NO_PPE_PPI
## 1007                                      Alumínio em bruto
## 1008 Pedras p/calcetar, placas p/paviment. de pedra natural
## 1009               Pimentões e pimentas trituradas ou em pó
## 1010 Pedras p/calcetar, placas p/paviment. de pedra natural
## 1011                               Açúcar de cana, em bruto
## 1012                               Açúcar de cana, em bruto
##                    NO_FAT_AGREG VL_FOB KG_LIQUIDO
## 1007 Produtos Semimanufaturados  21868      12000
## 1008 Produtos Semimanufaturados  19630      44425
## 1009 Produtos Semimanufaturados  12373       1370
## 1010 Produtos Semimanufaturados   8424      24455
## 1011 Produtos Semimanufaturados   1200       1000
## 1012 Produtos Semimanufaturados     98        200
{% endhighlight %}

O mesmo resultado com o R base seria o seguinte:


{% highlight r %}
arg.arrang.rbase <- arg.filter[order(arg.filter$NO_FAT_AGREG, -arg.filter$VL_FOB), ]
head(arg.arrange)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO CO_ANO                              NO_PPE_PPI
## 1 EXPORTAÇÕES Jan-Jul   2014 Consumo de bordo - óleos e combustíveis
## 2 EXPORTAÇÕES Jan-Jul   2016                            Reexportação
## 3 EXPORTAÇÕES Jan-Jul   2014                            Reexportação
## 4 EXPORTAÇÕES Jan-Jul   2015 Consumo de bordo - óleos e combustíveis
## 5 EXPORTAÇÕES Jan-Jul   2016 Consumo de bordo - óleos e combustíveis
## 6 EXPORTAÇÕES Jan-Jul   2015                            Reexportação
##          NO_FAT_AGREG  VL_FOB KG_LIQUIDO
## 1 Operações Especiais 9023778    7894708
## 2 Operações Especiais 7265362    1841428
## 3 Operações Especiais 5964271    3392399
## 4 Operações Especiais 5565702    8639868
## 5 Operações Especiais 5057158   10482224
## 6 Operações Especiais 4203581    2527950
{% endhighlight %}



{% highlight r %}
tail(arg.arrange)
{% endhighlight %}



{% highlight text %}
##             TIPO PERIODO CO_ANO
## 1007 EXPORTAÇÕES Jan-Jul   2016
## 1008 EXPORTAÇÕES Jan-Jul   2016
## 1009 EXPORTAÇÕES Jan-Jul   2016
## 1010 EXPORTAÇÕES Jan-Jul   2015
## 1011 EXPORTAÇÕES Jan-Jul   2015
## 1012 EXPORTAÇÕES Jan-Jul   2014
##                                                  NO_PPE_PPI
## 1007                                      Alumínio em bruto
## 1008 Pedras p/calcetar, placas p/paviment. de pedra natural
## 1009               Pimentões e pimentas trituradas ou em pó
## 1010 Pedras p/calcetar, placas p/paviment. de pedra natural
## 1011                               Açúcar de cana, em bruto
## 1012                               Açúcar de cana, em bruto
##                    NO_FAT_AGREG VL_FOB KG_LIQUIDO
## 1007 Produtos Semimanufaturados  21868      12000
## 1008 Produtos Semimanufaturados  19630      44425
## 1009 Produtos Semimanufaturados  12373       1370
## 1010 Produtos Semimanufaturados   8424      24455
## 1011 Produtos Semimanufaturados   1200       1000
## 1012 Produtos Semimanufaturados     98        200
{% endhighlight %}

## mutate()

O mutate() é um verbete usado para criar novas variáveis (colunas) no data.frame que você está manipulando. Por exemplo, em nossos dados temos o valor (VL_FOB) e o quilograma líquido (KG_LIQUIDO), mas estamos interessados em algum valor mais próximo do valor unitário. Podemos aproximar esse valor por dividindo VL_FOB por KG_LIQUIDO.

A título de exemplo, criaremos também o log de KG_LIQUIDO e o VL_FOB ao quadrado.


{% highlight r %}
arg.mutate <- arg.filter %>% mutate(PRECO_VL_KG = VL_FOB/KG_LIQUIDO, LOG_KG = log(KG_LIQUIDO), VL_FOB_2 = VL_FOB^2)
head(arg.mutate)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO CO_ANO
## 1 EXPORTAÇÕES Jan-Jul   2014
## 2 EXPORTAÇÕES Jan-Jul   2014
## 3 EXPORTAÇÕES Jan-Jul   2014
## 4 EXPORTAÇÕES Jan-Jul   2014
## 5 EXPORTAÇÕES Jan-Jul   2014
## 6 EXPORTAÇÕES Jan-Jul   2014
##                                                NO_PPE_PPI
## 1                               Abacaxis frescos ou secos
## 2            Abrasivos e pedras para amolar e semelhantes
## 3        Aceleradores de reação e preparações catalíticas
## 4 Acetatos,nitratos, éteres de celulose e outs. derivados
## 5  Ácidos carboxílicos, seus anidridos, halogenetos, etc.
## 6                                Açúcar de cana, em bruto
##                 NO_FAT_AGREG   VL_FOB KG_LIQUIDO PRECO_VL_KG
## 1           Produtos Básicos   164490     210336   0.7820345
## 2     Produtos Manufaturados  5513295     716749   7.6920861
## 3     Produtos Manufaturados 17367531    1197004  14.5091671
## 4     Produtos Manufaturados  4361844    1155458   3.7749914
## 5     Produtos Manufaturados 77117330   68853741   1.1200166
## 6 Produtos Semimanufaturados       98        200   0.4900000
##      LOG_KG     VL_FOB_2
## 1 12.256462 2.705696e+10
## 2 13.482481 3.039642e+13
## 3 13.995332 3.016311e+14
## 4 13.960007 1.902568e+13
## 5 18.047495 5.947083e+15
## 6  5.298317 9.604000e+03
{% endhighlight %}



{% highlight r %}
tail(arg.mutate)
{% endhighlight %}



{% highlight text %}
##             TIPO PERIODO CO_ANO
## 1007 EXPORTAÇÕES Jan-Jul   2016
## 1008 EXPORTAÇÕES Jan-Jul   2016
## 1009 EXPORTAÇÕES Jan-Jul   2016
## 1010 EXPORTAÇÕES Jan-Jul   2016
## 1011 EXPORTAÇÕES Jan-Jul   2016
## 1012 EXPORTAÇÕES Jan-Jul   2016
##                                                   NO_PPE_PPI
## 1007                         Vestuário para homens e meninos
## 1008                       Vestuário para mulheres e meninas
## 1009 Vidro em esferas,barras,varetas e tubos, não trabalhado
## 1010 Vidro flotado,desbastado ou polido, em chapas ou folhas
## 1011                                     Vidros de segurança
## 1012                                          Zinco em bruto
##                    NO_FAT_AGREG   VL_FOB KG_LIQUIDO PRECO_VL_KG
## 1007     Produtos Manufaturados   811139      23278  34.8457342
## 1008     Produtos Manufaturados   543358      26923  20.1819262
## 1009     Produtos Manufaturados      874          1 874.0000000
## 1010     Produtos Manufaturados 14823394   32236312   0.4598353
## 1011     Produtos Manufaturados 10416982    5693081   1.8297618
## 1012 Produtos Semimanufaturados 38057373   21823452   1.7438750
##        LOG_KG     VL_FOB_2
## 1007 10.05526 6.579465e+11
## 1008 10.20074 2.952379e+11
## 1009  0.00000 7.638760e+05
## 1010 17.28860 2.197330e+14
## 1011 15.55476 1.085135e+14
## 1012 16.89850 1.448364e+15
{% endhighlight %}

O mesmo resultado com o R base seria o seguinte:


{% highlight r %}
arg.mutate.rbase <- arg.filter
arg.mutate.rbase$PRECO_VL_KG = arg.mutate.rbase$VL_FOB/arg.mutate.rbase$KG_LIQUIDO
arg.mutate.rbase$LOG_KG = log(arg.mutate.rbase$KG_LIQUIDO)
arg.mutate.rbase$VL_FOB_2 = arg.mutate.rbase$VL_FOB^2
head(arg.mutate)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO CO_ANO
## 1 EXPORTAÇÕES Jan-Jul   2014
## 2 EXPORTAÇÕES Jan-Jul   2014
## 3 EXPORTAÇÕES Jan-Jul   2014
## 4 EXPORTAÇÕES Jan-Jul   2014
## 5 EXPORTAÇÕES Jan-Jul   2014
## 6 EXPORTAÇÕES Jan-Jul   2014
##                                                NO_PPE_PPI
## 1                               Abacaxis frescos ou secos
## 2            Abrasivos e pedras para amolar e semelhantes
## 3        Aceleradores de reação e preparações catalíticas
## 4 Acetatos,nitratos, éteres de celulose e outs. derivados
## 5  Ácidos carboxílicos, seus anidridos, halogenetos, etc.
## 6                                Açúcar de cana, em bruto
##                 NO_FAT_AGREG   VL_FOB KG_LIQUIDO PRECO_VL_KG
## 1           Produtos Básicos   164490     210336   0.7820345
## 2     Produtos Manufaturados  5513295     716749   7.6920861
## 3     Produtos Manufaturados 17367531    1197004  14.5091671
## 4     Produtos Manufaturados  4361844    1155458   3.7749914
## 5     Produtos Manufaturados 77117330   68853741   1.1200166
## 6 Produtos Semimanufaturados       98        200   0.4900000
##      LOG_KG     VL_FOB_2
## 1 12.256462 2.705696e+10
## 2 13.482481 3.039642e+13
## 3 13.995332 3.016311e+14
## 4 13.960007 1.902568e+13
## 5 18.047495 5.947083e+15
## 6  5.298317 9.604000e+03
{% endhighlight %}



{% highlight r %}
tail(arg.mutate)
{% endhighlight %}



{% highlight text %}
##             TIPO PERIODO CO_ANO
## 1007 EXPORTAÇÕES Jan-Jul   2016
## 1008 EXPORTAÇÕES Jan-Jul   2016
## 1009 EXPORTAÇÕES Jan-Jul   2016
## 1010 EXPORTAÇÕES Jan-Jul   2016
## 1011 EXPORTAÇÕES Jan-Jul   2016
## 1012 EXPORTAÇÕES Jan-Jul   2016
##                                                   NO_PPE_PPI
## 1007                         Vestuário para homens e meninos
## 1008                       Vestuário para mulheres e meninas
## 1009 Vidro em esferas,barras,varetas e tubos, não trabalhado
## 1010 Vidro flotado,desbastado ou polido, em chapas ou folhas
## 1011                                     Vidros de segurança
## 1012                                          Zinco em bruto
##                    NO_FAT_AGREG   VL_FOB KG_LIQUIDO PRECO_VL_KG
## 1007     Produtos Manufaturados   811139      23278  34.8457342
## 1008     Produtos Manufaturados   543358      26923  20.1819262
## 1009     Produtos Manufaturados      874          1 874.0000000
## 1010     Produtos Manufaturados 14823394   32236312   0.4598353
## 1011     Produtos Manufaturados 10416982    5693081   1.8297618
## 1012 Produtos Semimanufaturados 38057373   21823452   1.7438750
##        LOG_KG     VL_FOB_2
## 1007 10.05526 6.579465e+11
## 1008 10.20074 2.952379e+11
## 1009  0.00000 7.638760e+05
## 1010 17.28860 2.197330e+14
## 1011 15.55476 1.085135e+14
## 1012 16.89850 1.448364e+15
{% endhighlight %}

## group_by() e summarise()

O group_by() e o summarise() são operações que trabalham na agregação dos dados, ou seja, um dado mais detalhado passa a ser um dados mais agregado, agrupado. 

Agrupamento de dados geralmente é trabalhado em conjunção com sumarisações, que usam funcões matemáticas do tipo soma, média, desvio padrão, etc.

Enquanto o group_by() separa seus dados nos grupos que você selecionar, o summarise() faz operações de agregação de linhas limitadas a esse grupo. Com o exemplo ficará mais claro. ***(essa explicação não ta mto legal, mas não to conseguindo melhorar mto)***

Repare que, em relação ao produto, temos duas variáveis hierárquicas em nossos dados: NO_FAT_AGREG (nome do fator agregado) é uma classificação maior de de NO_PPE_PPI (nome do produto), além das outras variáveis de tempo e tipo de operação.

Em nossos dados temos o valor detalhado por produto, queremos agora o valor total por cada classificação de fator agregado. Além disso, queremos também a média de quilograma por cada fator agregado. Queremos tudo isso mantendo as variáveis de tempo e tipo de operação, ou seja, a unica coluna que será suprimida será o nome do produto NO_PPE_PPI.


{% highlight r %}
arg.group <- arg.filter %>% group_by(TIPO, PERIODO, CO_ANO, NO_FAT_AGREG) %>% 
    summarise(SOMA_VL_FOB = sum(VL_FOB), 
              MEDIA_KG = mean(KG_LIQUIDO))
str(agr.group)
{% endhighlight %}



{% highlight text %}
## Error in str(agr.group): objeto 'agr.group' não encontrado
{% endhighlight %}



{% highlight r %}
head(arg.group)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [6 x 6]
## Groups: TIPO, PERIODO, CO_ANO [2]
## 
##          TIPO PERIODO CO_ANO               NO_FAT_AGREG SOMA_VL_FOB
##        <fctr>  <fctr>  <int>                     <fctr>       <dbl>
## 1 EXPORTAÇÕES Jan-Jul   2014        Operações Especiais    18281140
## 2 EXPORTAÇÕES Jan-Jul   2014           Produtos Básicos   754707560
## 3 EXPORTAÇÕES Jan-Jul   2014     Produtos Manufaturados  7680228246
## 4 EXPORTAÇÕES Jan-Jul   2014 Produtos Semimanufaturados   204338219
## 5 EXPORTAÇÕES Jan-Jul   2015        Operações Especiais    13159527
## 6 EXPORTAÇÕES Jan-Jul   2015           Produtos Básicos   337227341
## # ... with 1 more variables: MEDIA_KG <dbl>
{% endhighlight %}



{% highlight r %}
tail(arg.group)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [6 x 6]
## Groups: TIPO, PERIODO, CO_ANO [2]
## 
##          TIPO PERIODO CO_ANO               NO_FAT_AGREG SOMA_VL_FOB
##        <fctr>  <fctr>  <int>                     <fctr>       <dbl>
## 1 EXPORTAÇÕES Jan-Jul   2015     Produtos Manufaturados  7153038358
## 2 EXPORTAÇÕES Jan-Jul   2015 Produtos Semimanufaturados   186200525
## 3 EXPORTAÇÕES Jan-Jul   2016        Operações Especiais    14967542
## 4 EXPORTAÇÕES Jan-Jul   2016           Produtos Básicos   244468757
## 5 EXPORTAÇÕES Jan-Jul   2016     Produtos Manufaturados  7062731046
## 6 EXPORTAÇÕES Jan-Jul   2016 Produtos Semimanufaturados   231311143
## # ... with 1 more variables: MEDIA_KG <dbl>
{% endhighlight %}

## Entendendo o operador %>%

Vimos até agora como fazer separadamente algumas operações básicas de manipulação e comparamos com o R base. Mas uma das grandes vantagens do pacote dplyr é justamente poder fazer uma operação "atrás da outra" sem precisar fazer novas atribuições. Como exemplo, refazendo tudo que fizemos até agora, em sequência, temos:


{% highlight r %}
arg.dplyr <- arg %>% 
      select(TIPO, PERIODO, NO_FAT_AGREG, VL_FOB, KG_LIQUIDO) %>%
      filter(TIPO != 'IMPORTAÇÕES' & PERIODO == 'Jan-Jul') %>%
      mutate(PRECO_VL_KG = VL_FOB/KG_LIQUIDO, LOG_KG = log(KG_LIQUIDO), VL_FOB_2 = VL_FOB^2) %>%
      arrange(NO_FAT_AGREG, desc(VL_FOB))

head(arg.dplyr)
{% endhighlight %}



{% highlight text %}
##          TIPO PERIODO        NO_FAT_AGREG  VL_FOB KG_LIQUIDO
## 1 EXPORTAÇÕES Jan-Jul Operações Especiais 9023778    7894708
## 2 EXPORTAÇÕES Jan-Jul Operações Especiais 7265362    1841428
## 3 EXPORTAÇÕES Jan-Jul Operações Especiais 5964271    3392399
## 4 EXPORTAÇÕES Jan-Jul Operações Especiais 5565702    8639868
## 5 EXPORTAÇÕES Jan-Jul Operações Especiais 5057158   10482224
## 6 EXPORTAÇÕES Jan-Jul Operações Especiais 4203581    2527950
##   PRECO_VL_KG   LOG_KG     VL_FOB_2
## 1   1.1430161 15.88170 8.142857e+13
## 2   3.9455042 14.42605 5.278548e+13
## 3   1.7581278 15.03705 3.557253e+13
## 4   0.6441883 15.97190 3.097704e+13
## 5   0.4824509 16.16519 2.557485e+13
## 6   1.6628418 14.74292 1.767009e+13
{% endhighlight %}



{% highlight r %}
tail(arg.dplyr)
{% endhighlight %}



{% highlight text %}
##             TIPO PERIODO               NO_FAT_AGREG VL_FOB KG_LIQUIDO
## 1007 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados  21868      12000
## 1008 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados  19630      44425
## 1009 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados  12373       1370
## 1010 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados   8424      24455
## 1011 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados   1200       1000
## 1012 EXPORTAÇÕES Jan-Jul Produtos Semimanufaturados     98        200
##      PRECO_VL_KG    LOG_KG  VL_FOB_2
## 1007   1.8223333  9.392662 478209424
## 1008   0.4418683 10.701558 385336900
## 1009   9.0313869  7.222566 153091129
## 1010   0.3444694 10.104590  70963776
## 1011   1.2000000  6.907755   1440000
## 1012   0.4900000  5.298317      9604
{% endhighlight %}

A primeira chamada `arg %>%` é o data frame que você irá trabalhar a manipulação. As chamadas seguintes `select() %>% filter() %>% arrange()` etc... são os encadeamentos de manipulação que você pode ir fazendo sem precisar reatribuir resultados ou criar novos objetos.

Vamos ver a mesma sequência feita com o R base

## Próximos posts

Como dissemos no começo, esse post inaugura uma nova sequência onde iremos tratar sobre manipulação de dados. O dplyr tem mais funções do que as apresentadas. Nos próximos posts vamos tratar mais detalhadamente essas funcões, bem como outro pacotes bastante usados também em  manipulação de dados, como o `data.table`, `tidyr`, `stringr` e outros.

## Referências

[teste](teste)
