---
layout: post
title: "Manipulação de dados - Parte 1: dplyr básico"
date: 2016-08-16 19:22:00 -0300
comments: true
categories: [dplyr, manipulação de dados]
published: true
---

Dominar a manipulação de dados é uma das habilidades mais básicas que um analista de dados deve ter. Nesse post ensinaremos as principais atividades relacionadas a manipulação de dados utilizando o pacote dplyr, um dos melhores pacotes disponíveis no R para essa finalidade.

<!-- More -->

## O pacote

O [dplyr](https://github.com/hadley/dplyr) é um pacote criado por [Hadley Wickham](https://github.com/hadley), um dos maiores colaboradores da comunidade R. Se você não o conhece e pretende seguir em frente com o R, certamente vai ouvir falar muito dele, pois ele criou diversos pacotes extremamente úteis e fáceis de usar (ggplot2, devtools, tidyr, stringr, etc...). O dplyr foi só um deles.

Trata-se de um pacote otimizado para manipulação de dados, não só com boa performance, mas com sintaxe simples e concisa, facilitando o aprendizado e tornando o pacote um dos preferidos para as tarefas do dia a dia.

O dplyr cobre praticamente todas as tarefas básicas da manipulação de dados: agregar, sumarizar, filtrar, ordenar, criar variáveis, joins, dentre outras.

Para começar, instale, carregue e dê uma rápida olhada na documentação do dplyr. Em seguida cobriremos suas principais funções:



{% highlight r %}
install.packages("dplyr")
library(dplyr)
?dplyr
{% endhighlight %}

## Verbetes do dplyr e o operador %>%

As principais tarefas de manipulação de dados podem ser resumidas em algumas simples palavras, tal qual mencionamos na introdução do post. As funções do dplyr simplesmente reproduzem essas palavras de forma bastante intuitiva. Veja só:

* select()
* filter()
* arrange()
* mutate()
* group_by()
* summarise()

Esses são os principais verbetes, mas existem outros disponíveis como, por exemplo, `slice()`, `rename()` e `transmute()`. Como já dito, é importante dar uma olhada na documentação para ver as funções disponíveis.

Além de nomes de funções intuitivos, o dplyr também faz uso de um recurso disponível em boa parte dos pacotes do Hadley, o operador `%>%`. 

Esse operador (originalmente do pacote [magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html), que trataremos em outros posts) encadeia as chamadas de funções de forma que você não vai precisar ficar chamando uma função dentro da outra ou ficar fazendo atribuições para o fluxo de manipulações. Aliás, podemos dizer que esse operador `%>%` literalmente cria um fluxo sequencial bastante claro e legível para as atividades de manipulação. 

Passaremos todos os verbetes básicos encadeando um com o outro, explicando o uso das funções e do `%>%`, aos poucos seu uso ficará claro e intuitivo.


## Dados 

Vamos carregar uma pequena base de dados de testes para explicarmos os exemplos.

Escolhemos os dados brasileiros de comércio exterior (exportações e importações) com a Argentina, terceiro maior parceiro comercial do Brasil, que podem ser obtidos no [Comex Vis](http://www.mdic.gov.br/comercio-exterior/estatisticas-de-comercio-exterior/comex-vis/frame-pais?pais=arg), clicando em dados brutos.

Dando uma rápida olhada nos dados, temos:


{% highlight r %}
# Lembre-se de definir o diretório de trabalho para o 
# local que você salvou o arquivo.
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

Em nosso exemplo, queremos manipular esses dados de forma que possamos avaliar as exportações de janeiro a julho, por fator agregado (`NO_FAT_AGREG`), comparando os valores do mesmo período entre os anos disponíveis.

Vamos começar as operações para chegar nesse resultado!

## select()

A primeira e mais simples função que comentaremos é usada para selecionar variáveis (colunas) do seu data frame. Não queremos todas as variáveis, queremos apenas os campos TIPO, PERIODO, CO_ANO, NO_FAT_AGREG, NO_PPE_PPI, VL_FOB, KG_LIQUIDO. 


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

Além disso, o dplyr ainda possui algumas funções que podem ser úteis na seleção de variáveis. Veja:

{% highlight r %}
?select_helpers
{% endhighlight %}

Você notou que todas as variáveis que excluímos continham`PAIS` no nome? E se fossem 50 variáveis com essa características? Seria complicado escrever os 50 nomes. Contudo, tudo pode ser feito mais facilmente com o uso dessas funções auxiliares. Vamos utilizar o `contains()`:


{% highlight r %}
arg.select <- arg %>% select(-contains("PAIS"))

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

Excluímos todas as variáveis que contêm `PAIS` no nome. O resultado é exatamente o mesmo. Como quase tudo no R, existe mais de uma forma para obter o mesmo resultado. Geralmente, opta-se pela forma mais concisa.

Comparando com o procedimento em R base para obter o mesmo resultado, temos:


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

Enquanto o `select()` diz respeito a quais campos você quer, o filter() diz respeito a quais linhas você deseja selecionar. Em nosso exemplo, temos duas ocorrências distintas em `TIPO`, vamos selecionar apenas as exportações. Repare também que em `PERIODO` temos `Jan-Jul` e `Total`, queremos apenas o período `Jan-Jul` veja:


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
arg.filter <- arg.select %>% filter(TIPO == 'EXPORTAÇÕES' & PERIODO == 'Jan-Jul')

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
arg.filter.rbase <- arg.select[arg.select$TIPO == 'EXPORTAÇÕES' & arg.select$PERIODO == 'Jan-Jul', ]

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

## mutate()

O `mutate()` é uma função usada para criar novas variáveis (colunas) no data.frame que você está manipulando. Por exemplo, em nossos dados temos o valor (VL_FOB) e o quilograma líquido (KG_LIQUIDO), mas estamos interessados em algum valor mais próximo do valor unitário. Podemos aproximar esse valor dividindo VL_FOB por KG_LIQUIDO.

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

O `group_by()` e o `summarise()` são operações que trabalham na agregação dos dados, ou seja, um dado mais detalhado passa a ser um dados mais agregado, agrupado. 

Agrupamento de dados geralmente é trabalhado em conjunção com sumarizações, que usam funções matemáticas do tipo soma, média, desvio padrão, etc.

Enquanto o `group_by()` separa seus dados nos grupos que você selecionar, o summarise() faz operações de agregação de linhas limitadas a esse grupo. Com o exemplo ficará mais claro. 

Repare que, em relação ao produto, temos dois campos descritivos em nossos dados: NO_FAT_AGREG (nome do fator agregado) é uma classificação hierarquicamente superior ao NO_PPE_PPI (nome do produto), além dos campos de valor e peso de produto.

Queremos agora o valor total por cada classificação de fator agregado. Além disso, queremos também a média de quilograma por cada fator agregado. Queremos tudo isso mantendo as variáveis de tempo e tipo de operação, ou seja, a unica coluna que será suprimida será o nome do produto NO_PPE_PPI.

As demais colunas de valores devem ser somadas (ou ter a média calculada) no nível da variável agrupada:


{% highlight r %}
arg.group <- arg.filter %>% group_by(TIPO, PERIODO, CO_ANO, NO_FAT_AGREG) %>% 
    summarise(SOMA_VL_FOB = sum(VL_FOB), 
              MEDIA_KG = mean(KG_LIQUIDO))

options(dplyr.width = Inf) #apenas para mostrar todas as colunas no output do dplyr
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
##    MEDIA_KG
##       <dbl>
## 1   2546025
## 2 188459876
## 3   8627696
## 4   5847662
## 5   2554621
## 6 116532235
{% endhighlight %}

Aqui fica uma observação. Apesar de o `group_by()` estar intimamente relacionada ao `summarise()`, é importante ressaltar que essa função também pode ser utilizada para criar, com o `mutate()`, novas variáveis, que apresentam valores sumarizados de outras.

## arrange()

Selecionamos os campos com o `select()`, filtramos as linhas com o `filter()`, criamos variáveis com o `mutate()` e agrupamos e sumarizamos com o `group_by()` e `summarise()`. Agora queremos ordenar os resultados por alguns critérios para começarmos a avaliar os dados. 

Para isso usaremos o `arrange()`. Queremos ordenar nossos dados, em ordem alfabética, pelo nome do fator agregado `NO_FAT_AGREG` e em ordem decrescente de valor de cada fator agregado `SOMA_VL_FOB`.


{% highlight r %}
arg.arrange <- arg.group %>% arrange(NO_FAT_AGREG, desc(SOMA_VL_FOB))

head(arg.arrange)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [6 x 6]
## Groups: TIPO, PERIODO, CO_ANO [3]
## 
##          TIPO PERIODO CO_ANO        NO_FAT_AGREG SOMA_VL_FOB
##        <fctr>  <fctr>  <int>              <fctr>       <dbl>
## 1 EXPORTAÇÕES Jan-Jul   2014 Operações Especiais    18281140
## 2 EXPORTAÇÕES Jan-Jul   2016 Operações Especiais    14967542
## 3 EXPORTAÇÕES Jan-Jul   2015 Operações Especiais    13159527
## 4 EXPORTAÇÕES Jan-Jul   2014    Produtos Básicos   754707560
## 5 EXPORTAÇÕES Jan-Jul   2015    Produtos Básicos   337227341
## 6 EXPORTAÇÕES Jan-Jul   2016    Produtos Básicos   244468757
##    MEDIA_KG
##       <dbl>
## 1   2546025
## 2   2788688
## 3   2554621
## 4 188459876
## 5 116532235
## 6  98083030
{% endhighlight %}



{% highlight r %}
tail(arg.arrange)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [6 x 6]
## Groups: TIPO, PERIODO, CO_ANO [3]
## 
##          TIPO PERIODO CO_ANO               NO_FAT_AGREG SOMA_VL_FOB
##        <fctr>  <fctr>  <int>                     <fctr>       <dbl>
## 1 EXPORTAÇÕES Jan-Jul   2014     Produtos Manufaturados  7680228246
## 2 EXPORTAÇÕES Jan-Jul   2015     Produtos Manufaturados  7153038358
## 3 EXPORTAÇÕES Jan-Jul   2016     Produtos Manufaturados  7062731046
## 4 EXPORTAÇÕES Jan-Jul   2016 Produtos Semimanufaturados   231311143
## 5 EXPORTAÇÕES Jan-Jul   2014 Produtos Semimanufaturados   204338219
## 6 EXPORTAÇÕES Jan-Jul   2015 Produtos Semimanufaturados   186200525
##   MEDIA_KG
##      <dbl>
## 1  8627696
## 2  8303481
## 3  9477421
## 4 11577303
## 5  5847662
## 6  6275305
{% endhighlight %}

## Entendendo o operador %>%

Vimos até agora como fazer separadamente algumas operações básicas de manipulação e comparamos com o R base. No entanto, uma das grandes vantagens do pacote dplyr é justamente poder fazer uma operação "atrás da outra" sem precisar fazer novas atribuições. Como exemplo, refazendo tudo que fizemos até agora, em sequência, temos:


{% highlight r %}
arg.dplyr <- arg %>% 
      select(TIPO, PERIODO, CO_ANO, NO_FAT_AGREG, NO_PPE_PPI, VL_FOB, KG_LIQUIDO) %>%
      filter(TIPO == 'EXPORTAÇÕES' & PERIODO == 'Jan-Jul') %>%
      mutate(PRECO_VL_KG = VL_FOB/KG_LIQUIDO, LOG_KG = log(KG_LIQUIDO), VL_FOB_2 = VL_FOB^2) %>%
      group_by(TIPO, PERIODO, CO_ANO, NO_FAT_AGREG) %>% 
      summarise(SOMA_VL_FOB = sum(VL_FOB), MEDIA_KG = mean(KG_LIQUIDO)) %>%
      arrange(NO_FAT_AGREG, desc(SOMA_VL_FOB))

head(arg.dplyr)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [6 x 6]
## Groups: TIPO, PERIODO, CO_ANO [3]
## 
##          TIPO PERIODO CO_ANO        NO_FAT_AGREG SOMA_VL_FOB
##        <fctr>  <fctr>  <int>              <fctr>       <dbl>
## 1 EXPORTAÇÕES Jan-Jul   2014 Operações Especiais    18281140
## 2 EXPORTAÇÕES Jan-Jul   2016 Operações Especiais    14967542
## 3 EXPORTAÇÕES Jan-Jul   2015 Operações Especiais    13159527
## 4 EXPORTAÇÕES Jan-Jul   2014    Produtos Básicos   754707560
## 5 EXPORTAÇÕES Jan-Jul   2015    Produtos Básicos   337227341
## 6 EXPORTAÇÕES Jan-Jul   2016    Produtos Básicos   244468757
##    MEDIA_KG
##       <dbl>
## 1   2546025
## 2   2788688
## 3   2554621
## 4 188459876
## 5 116532235
## 6  98083030
{% endhighlight %}



{% highlight r %}
tail(arg.dplyr)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [6 x 6]
## Groups: TIPO, PERIODO, CO_ANO [3]
## 
##          TIPO PERIODO CO_ANO               NO_FAT_AGREG SOMA_VL_FOB
##        <fctr>  <fctr>  <int>                     <fctr>       <dbl>
## 1 EXPORTAÇÕES Jan-Jul   2014     Produtos Manufaturados  7680228246
## 2 EXPORTAÇÕES Jan-Jul   2015     Produtos Manufaturados  7153038358
## 3 EXPORTAÇÕES Jan-Jul   2016     Produtos Manufaturados  7062731046
## 4 EXPORTAÇÕES Jan-Jul   2016 Produtos Semimanufaturados   231311143
## 5 EXPORTAÇÕES Jan-Jul   2014 Produtos Semimanufaturados   204338219
## 6 EXPORTAÇÕES Jan-Jul   2015 Produtos Semimanufaturados   186200525
##   MEDIA_KG
##      <dbl>
## 1  8627696
## 2  8303481
## 3  9477421
## 4 11577303
## 5  5847662
## 6  6275305
{% endhighlight %}

A primeira chamada `arg %>%` é a passagem onde você informa o data.frame que você irá trabalhar a manipulação. A partir daí, as chamadas seguintes `select() %>% filter() %>% mutate()` etc, são os encadeamentos de manipulação que você pode ir fazendo sem precisar atribuir resultados ou criar novos objetos.

Usando o operador `%>%`, você estará informando que um resultado da operação anterior será a entrada para a nova operação. Esse encadeamento facilita muito as coisas, tornando a manipulação mais legível e intuitiva.

## Avaliação Não-Padrão (Non-standard evaluation - NSE)

O dplyr utiliza por padrão avaliação não-padrão. Na prática, isso significa que ao fazer alguma operação você não precisa utilizar as aspas, o que reduz a necessidade de digitação. No entanto, todo verbete possui uma versão com avaliação padrão. Para tal, adiciona-se `_` ao nome da função. Por exemplo, `filter_()` é a função com a avaliação padrão, enquanto `filter()` é a mesma função com avaliação não-padrão. 

Talvez saber isso agora não pareça útil, mas poderá ser caso você esteja lendo um código escrito por outra pessoa ou estiver escrevendo uma função em que os nomes das variáveis são argumentos da função. Para mais detalhes:

{% highlight r %}
vignette('nse')
{% endhighlight %}

## Próximos posts

Como dissemos no começo, esse post inaugura uma nova sequência onde iremos tratar sobre manipulação de dados. O dplyr tem mais funções do que as apresentadas. Nos próximos posts vamos tratar mais detalhadamente essas funções, bem como outro pacotes bastante usados também em  manipulação de dados, como o `data.table`, `tidyr`, `stringr` e outros.

## Referências

* [Data Wrangling with dplyr and tidyr](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
* [Introduction to dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
* [Introduction to dplyr for Faster Data Manipulation in R](https://rpubs.com/justmarkham/dplyr-tutorial)
