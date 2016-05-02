---
layout: post
title: "Kit de sobrevivência em R - Parte 7: Avançando e Aprofundando"
date: 2016-05-09 20:04:00 -0300
comments: true
categories: [r, básico, introdução r]
published: true
---
  


Chegamos ao fim do [kit de sobrevivência em R]({{root_url}}/blog/categories/introducao-r). Nesse último post da série vamos retomar alguns pontos que merecem ser complementados e revisados, além de apresentar um pouco mais de transformações e operações usando apenas funções básicas do R.

<!-- More -->

Se você seguiu a sequência e chegou até aqui, parabéns! Você provavelmente conhece o básico de R e o suficiente para começar a aprofundar em aspectos mais interessantes sobre operações com massas de dados.

## Variáveis

Além da simples atribuição de variáveis, existe uma mecância muito usada em R (e qualquer outra linguagem): variáveis incrementais. Incrementar variáveis é atribuir a uma variável seu proprio valor modificado de alguma forma:

{% highlight r %}
x <- 5
x <- x + x
x <- x + x
{% endhighlight %}

Essa construção de variável incremental é muito utilizada em loops e cálculos acumulativos. Um exemplo clássico é ....


## Breve revisão sobre pacotes 

Mostramos que pactoes são conjuntos de funções específicas agrupadas para objetivos temáticos: carregar dados, gráficos, machine learning. É muito simples carregar e utilizar pacotes. Vamos relembrar os principais comandos envolvidos:


{% highlight r %}
??dplyr #conhecendo um pacote que não foi carregado ainda
install.packages('dplyr') #instalando um pacote
library(dplyr) #carregando um pacote para uso
?dplyr::filter #conhecendo alguma função do pacote
{% endhighlight %}

## Carregando dados

Lembre-se que antes de carregar um arquivo de dados você precisa informar onde o R deve ler o arquivo. Para isso usamos o comando `setwd()`.

A função mais básica para leitura de dados estruturados (csv, tabular, tamanho fixo, com separadores, etc.) é o famoso `read.table()`. Lembra dos principais parâmetros? Nome do arquivo, separador, se tem cabeçalho ou não, e, no caso de campos com tamanho fixo, o tamanho de cada campo.

Se quiser exercitar com diversos arquivos de dados diferentes, tente o [Portal Brasileiro de Dados Abertos](http://dados.gov.br/) ou [esse repositório de dados públicos](https://github.com/caesar0301/awesome-public-datasets) (em inglês).

Comentamos de algumas funções básicas para começar a explorar seus dados carregados. Você lembra?


{% highlight r %}
?head()
?tail()
?str()
{% endhighlight %}

> Dica: se estiver usando o RStudio, tente visualizar seu data.frame com a função `View()` (com V maiúsculo). Ela cria uma planilha para ver melhor os dados!

## Tipos e estrutura de dados

Conhecer os tipos e estruturas de dados em R será fundamental daqui pra frente. Achamos importante revisar e apresentar alguns dos principais.

### Tipos básicos

| logical | Valor lógico, `TRUE` ou `FALSE`. Usado com os operadores lógicos `&, |, ==, !=, >, <, >=, <=` |
| integer | Valores de números inteiros |
| numeric | Valores de números decimais. Também representam números inteiros |
| character | Valores textuais, também conhecidos como string |


Existem algumas operações de conversões entre os tipos. São bastante usadas em transformações de campos. Por exemplo:


{% highlight r %}
as.numeric("20")
{% endhighlight %}



{% highlight text %}
## [1] 20
{% endhighlight %}



{% highlight r %}
as.character(20)
{% endhighlight %}



{% highlight text %}
## [1] "20"
{% endhighlight %}



{% highlight r %}
as.integer(3.14)
{% endhighlight %}



{% highlight text %}
## [1] 3
{% endhighlight %}

### Estruturas básicas

| vector | Coleção de elementos simples. Todos os elementos precisam ser do mesmo tipo básico de dado |
| array | Coleção que se parece com o vector, mas é possível adicionar atributos às posicões e dimensões |
| matrix | Tipo especial de array com mais de uma dimensão |
| list | Objeto complexo com elementos que podem ser de diferentes tipos |
| data.frame | Tipo especial de lista onde cada campo é um vetor de apenas um tipo e todos os campos tem o mesmo número de registros. É o tipo mais utilizado se trabalhar com dados |
| factor | Tipo especial de vector que só contém valores pré definidos (levels) e categóricos (characters). Não é possível adicionar novas categorias sem criação de novos levels |

## Data frame e transformações



## Referências

* []()
