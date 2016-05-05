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

Além da simples atribuição de variáveis, existe uma mecância muito usada em R (e qualquer outra linguagem): variáveis incrementais. Incrementar variáveis é atribuir a uma variável seu próprio valor modificado de alguma forma:

{% highlight r %}
x <- 5
x <- x + x
x <- x + x
{% endhighlight %}

Essa construção de variável incremental é muito utilizada em loops e cálculos acumulativos. Um exemplo clássico é ....


## Breve revisão sobre pacotes 

Mostramos que pacotes são conjuntos de funções específicas agrupadas para objetivos temáticos: carregar dados, gráficos, machine learning. É muito simples carregar e utilizar pacotes. Vamos relembrar os principais comandos envolvidos:


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

| Tipo | Descrição |
|------|-------------|
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

Conhecer as estruturas de dados do R será fundamental no desenvolvimento das suas análises. Inicialmente, a ideia de estrutura de dados pode parecer um pouco abstrata, mas conhecê-las e saber suas características será útil para você perceber quais são as possibilidades.

Além do tipo e descrição, incluímos uma coluna sobre o número de dimensões do objeto. Isso fará diferença na hora de usar `[ ]`. No caso das listas, usaremos `[[]]`. O que implica dizer que um objeto tem duas dimensões? Na prática, isso afetará como você usará partes desse objeto. Por exemplo, um objeto com duas dimensões tem linhas e colunas. Assim, você usará `[ , ]` (com vírgula) para separar a dimensão que você deseja selecionar.

Além disso, os objetos diferenciam em relação ao variedade de tipos que eles podem receber. Por exemplo, vetores só aceitam um tipo de dado. Assim, se você atribuir dois tipos diferentes, ele forçará para um único tipo.

A tabela abaixo apresenta um resumo das estruturas básicas. Ela está baseada na explicação que está no livro do [_Advanced R_](http://adv-r.had.co.nz/Data-structures.html) do Hadley Wickham (leitura recomendada pra quem deseja aprofundar seus conhecimento em R).



| Tipo | Descrição | Dimensões | Homogêneo |
|---|---|---|---|---|
| vector | Coleção de elementos simples. Todos os elementos precisam ser do mesmo tipo básico de dado | 1 | Sim |
| array | Coleção que se parece com o vector, mas é possível adicionar atributos às posicões e dimensões | n | Sim |
| matrix | Tipo especial de array com mais de uma dimensão | 2 | Sim |
| list | Objeto complexo com elementos que podem ser de diferentes tipos | 1 | Não |
| data.frame | Tipo especial de lista onde cada campo é um vetor de apenas um tipo e todos os campos tem o mesmo número de registros. É o tipo mais utilizado se trabalhar com dados | 2 | Não |
| factor | Tipo especial de vector que só contém valores pré definidos (levels) e categóricos (characters). Não é possível adicionar novas categorias sem criação de novos levels | 1 |  Não |

<br/>  

Para ficar mais claro, vamos dar um exemplo de uma lista. Como já dito em outros posts, o R e seus pacotes fornecem bases de dados para teste das funções. Iremos criar uma lista com duas dessas bases de dados. Assim, ficará mais fácil de entender com ela funciona. 

Primeiramente, iremos carregar duas bases de dados:


{% highlight r %}
data("mtcars")
data("iris")
class(mtcars)
{% endhighlight %}



{% highlight text %}
## [1] "data.frame"
{% endhighlight %}



{% highlight r %}
class(iris)
{% endhighlight %}



{% highlight text %}
## [1] "data.frame"
{% endhighlight %}

Veja que temos dois data frames. Agora, vamos criar um objeto único que irá receber essas duas bases. Além disso, a fim de mostrar a heterogeneidade, iremos incluir um objeto que será um vetor. Veja abaixo:


{% highlight r %}
x <- 1:10
lista.teste <- list(mtcars, iris, x)
{% endhighlight %}

Faça um teste e digite `lista.teste` no console para ver o resultado. E como eu faço pra acessar partes específicas? Como dissemos a lista tem uma pequena diferença, será necessário usar o `[[ ]]`. Lembre-se que, como a lista é um objeto de dimensão 1, só precisaremos passar o índice que temos interesse. O vetor `x` é o terceiro elemento. Logo, para acessá-lo podemos fazer o seguinte:

{% highlight r %}
lista.teste[[3]]
{% endhighlight %}



{% highlight text %}
##  [1]  1  2  3  4  5  6  7  8  9 10
{% endhighlight %}

Para terminar essa breve explicação sobre listas, vamos mostrar que cada objeto de uma lista pode ter um nome:

{% highlight r %}
lista.teste <- list(base1 = mtcars, base2 = iris, vetor1 = x)
{% endhighlight %}

Dessa forma, você *também* poderá acessar usando o nome com o auxílio do `$`:

{% highlight r %}
lista.teste$vetor1
{% endhighlight %}



{% highlight text %}
##  [1]  1  2  3  4  5  6  7  8  9 10
{% endhighlight %}


Complementando as informações sobre os outros tipos, vectors possuem algumas propriedades muito úteis como `length()`, `typeof()` e `unique()`. Você também poderá usar o `length()` para saber o tamanho de uma lista. As funções `nrow()` e `ncol()` podem ser usadas para saber, respectivamente, o número de linhas e colunas de um data.frame ou de uma matriz.

## Data frame e transformações

data frame, atribuição, propriedades...

## Exemplo de uso das funções básicas

carregar um dado, manipular, transformar e visualizar

## Referências

* []()
