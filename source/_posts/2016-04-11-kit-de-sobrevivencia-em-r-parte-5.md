---
layout: post
title: "Kit de sobrevivência em R - Parte 5: Tipos de dados e transformações"
date: 2016-05-11 21:00:00 -0300
comments: true
categories: [r, básico]
published: true
---

Você já aprendeu como carregar um arquivo de dados no R para começar a trabalhar com ele. Agora vamos conhecer o básico necessário para manipular os dados e prepará-los para a análise propriamente dita. Para isso será necessário saber sobre alguns tipos básicos de dados e algumas formas de transformação de dados.

<!-- More -->

# Porque transformar os dados?

Durante o processo de análise de dados é bastante comum precisar de mais informações que não estão explícitas em sua base de dados, ou seja, informações além das que estão disponíveis nas linhas e colunas. Transformar os dados permite extrair, ajustar e até mesmo criar informações com seus dados, criando novas colunas, novas linhas, ou quem sabe um outro arquivo de dados derivado do original.

Infelizmente, aqui vai uma notícia ruim: não existe padrão algum para transformação de dados, vai depender muito do design dos seus dados, das necessidades da sua análise e da sua criatividade!

A notícia boa é que, quanto mais você conhecer formas de transformar os dados e quanto mais dominar os tipos de dados existentes em R, a tarefa de transformação de dados será mais fácil e até mais divertida.

# Tipos de dados

Existem diversos tipos de dados em R, alguns mais básicos e outros mais complexos (não em termos de dificuldade, e sim de estrutura). Vamos tentar apresentr alguns na prática ao longo do post.

Lembra dos dados utilizados no [último post](2016-04-07-kit-de-sobrevivencia-em-r-parte-4)? Vamos usá-los novamente como exemplo. Lembre-se de informar ao R o local onde o arquivo está para que ele possa ler. 

Carregue algum dos arquivos de forma apropriada (todos arquivos tem o mesmo conteúdo). Como exemplo, escolhemos o arquivo com colunas delimitadas por `;`.




{% highlight r %}
dados <- read.table('desemprego_uf_ponto_virgula.txt', sep = ";", dec = ",", header = TRUE)  
{% endhighlight %}

Esses dados trazem informações trimestrais ao longo dos anos da taxa de desemprego das Unidades da Federação brasileira.

No post anterior conseguimos dar uma olhada superficial usando `head()` e `tail()`. Para começar a transformar os dados precisaremos aprofundar um pouco mais. Usaremos então o `class()` e o `str()` para investigar melhor nossos dados.


{% highlight r %}
class(dados)
{% endhighlight %}



{% highlight text %}
## [1] "data.frame"
{% endhighlight %}

A função `class()` recebe como parâmetro uma variável, e como resposta ela apresenta o tipo de dado dessa variável. Temos então um `data.frame`.

### Data.frame

Data frame é um tipo de dado complexo, um dos mais utilizados em R. É nele que você armazena conjuntos de dados estruturados em linhas e colunas. Um data frame possue colunas nomeadas, sendo que todas as colunas possuem a mesma quantidade de linhas.


{% highlight r %}
str(dados)
{% endhighlight %}



{% highlight text %}
## 'data.frame':	432 obs. of  4 variables:
##  $ Ano            : int  2012 2012 2012 2012 2013 2013 2013 2013 2014 2014 ...
##  $ Trimestre      : Factor w/ 4 levels "abr-mai-jun",..: 2 1 3 4 2 1 3 4 2 1 ...
##  $ UF             : Factor w/ 27 levels "Acre","Alagoas",..: 22 22 22 22 22 22 22 22 22 22 ...
##  $ Taxa_Desemprego: num  8.01 6.22 5.88 5.27 6.11 ...
{% endhighlight %}

Com a função `str()` podemos examinar melhor a estrutura do nosso data frame.
Reparem que é um conjunto de dados que possui 4 variáveis (colunas) e 432 observações (linhas). Temos ainda uma listagem com o nome das colunas, o tipo de dado presente em cada coluna e uma pequena amostra dos dados.

### Int

Trata-se de um tipo de dado básico que representa um número inteiro. É tão simples que não há muito o que comentar: 1, 2, 3, 4... até 2147483647.

### Factor

É um tipo de dado complexo que representa categorias (levels). Tentando ser o máximo simplesta, é uma lista de categorias enumeradas, ou seja, é uma sequência de informações texutais (palavras) representadas por um número. Você vê as categorias e o R "vê" os números que representam essas categorias. Esse tipo é muito útil para modelos estatísticos.

Parece um pouco confuso de entender, mas factor é a forma mais eficiente do R interpretar uma sequência de palavras. Veja o resultado do comando abaixo:


{% highlight r %}
unique(dados$UF)
{% endhighlight %}



{% highlight text %}
##  [1] Rondônia            Acre                Amazonas           
##  [4] Roraima             Pará                Amapá              
##  [7] Tocantins           Maranhão            Piauí              
## [10] Ceará               Rio Grande do Norte Paraíba            
## [13] Pernambuco          Alagoas             Sergipe            
## [16] Bahia               Minas Gerais        Espírito Santo     
## [19] Rio de Janeiro      São Paulo           Paraná             
## [22] Santa Catarina      Rio Grande do Sul   Mato Grosso do Sul 
## [25] Mato Grosso         Goiás               Distrito Federal   
## 27 Levels: Acre Alagoas Amapá Amazonas Bahia ... Tocantins
{% endhighlight %}



{% highlight r %}
unique(dados$Trimestre)
{% endhighlight %}



{% highlight text %}
## [1] jan-fev-mar abr-mai-jun jul-ago-set out-nov-dez
## Levels: abr-mai-jun jan-fev-mar jul-ago-set out-nov-dez
{% endhighlight %}

A visualização que o R fornece não ajuda muito, mas repare que cada categoria possui um número. Exemplo: "Rondônia" - 1, "Acre" - 2, "Mato Grosso" - 25, "Distrito Federal" - 27; ou ainda "jan-fev-mar" - 1, "abr-mai-jun" - 2, "jul-ago-set" - 3, "out-nov-dez" - 4.

Então podemos dizer que nossa coluna UF é um factor de 27 levels, e Trimestre é um factor de 4 levels.

Mas o que é esse cifrão `$`? É uma notação do R para quando você quer visualizar ou trabalhar com uma coluna (variável) de um data.frame. Você informa o nome do data frame, o $ e em seguida o nome da coluna que você quer. Experimente: `dados$Ano`, `dados$UF`, `dados$Trimestre` e `dados$Taxa_Desemprego`. Essa notação é muito importante e você a utilizará bastante.

E o que seria essa função `unique()`. É uma função básica do R para listar todos os valores de uma variável sem repetição. Olhando todos os dados em `dados$UF` você vai reparar que os nomes aparecem várias vezes em várias linhas, o `unique()` lista a ocorrência única de cada nome.

### Num

Continuando a exploração dos tipos, temos o `num`, um tipo básico capaz de representar números decimais. O tipo `num` também consegue representar inteiros.

# Transformações

Tendo consciencia dos tipos de dados que compõem nosso data frame já é possível começar a imaginar as análises que podem ser feitas. 

Vamos supor que surgiu a necessidade de analisarmos os dados de desemprego por semestre. Podemos observar nos dados que temos informações explícitas por trimestre e de certa forma por ano também. Para começarmos os cálculos então seria interessanter ter uma variável (coluna) indicando o semestre.

Ora, essa informação já existe no conjunto de dados, afinal, temos trimestres e anos. Porém, não está explícita em nenhuma variável. Então vamos transformar os dados e criar essa variável!

Primeiramente vamos criar a variável. A forma é muito semelhante à criação de uma variável normal, mas vamos usar o `$` para indicar que estamos criando uma variável dentro do data frame.


{% highlight r %}
dados$Semestre <- 1
head(dados, 4)
{% endhighlight %}



{% highlight text %}
##    Ano   Trimestre       UF Taxa_Desemprego Semestre
## 1 2012 jan-fev-mar Rondônia           8.008        1
## 2 2012 abr-mai-jun Rondônia           6.224        1
## 3 2012 jul-ago-set Rondônia           5.882        1
## 4 2012 out-nov-dez Rondônia           5.274        1
{% endhighlight %}



{% highlight r %}
head(dados, 4)
{% endhighlight %}



{% highlight text %}
##    Ano   Trimestre       UF Taxa_Desemprego Semestre
## 1 2012 jan-fev-mar Rondônia           8.008        1
## 2 2012 abr-mai-jun Rondônia           6.224        1
## 3 2012 jul-ago-set Rondônia           5.882        1
## 4 2012 out-nov-dez Rondônia           5.274        1
{% endhighlight %}

Acabamos de criar uma nova coluna e atribuir 1 a todas as linhas dessa coluna. Não é exatamente o que queremos. Queremos atribuir 1 para primeiro semestre e 2 para segundo semestre. Para conseguir isso precisaremos atribuir a variável segundo algumas condicões. 

Ou seja, quando for trimestre `jan-fev-mar` ou `abr-mai-jun` vamos atribuir 1, quando for o trimestre `jul-ago-set` ou `out-nov-dez` vamos atribuir 2:


{% highlight r %}
dados$Semestre[dados$Trimestre == 'jan-fev-mar' | dados$Trimestre == 'abr-mai-jun'] <- 1
dados$Semestre[dados$Trimestre == 'jul-ago-set' | dados$Trimestre == 'out-nov-dez'] <- 2
head(dados)
{% endhighlight %}



{% highlight text %}
##    Ano   Trimestre       UF Taxa_Desemprego Semestre
## 1 2012 jan-fev-mar Rondônia           8.008        1
## 2 2012 abr-mai-jun Rondônia           6.224        1
## 3 2012 jul-ago-set Rondônia           5.882        2
## 4 2012 out-nov-dez Rondônia           5.274        2
## 5 2013 jan-fev-mar Rondônia           6.114        1
## 6 2013 abr-mai-jun Rondônia           4.771        1
{% endhighlight %}



{% highlight r %}
tail(dados)
{% endhighlight %}



{% highlight text %}
##      Ano   Trimestre               UF Taxa_Desemprego Semestre
## 427 2014 jul-ago-set Distrito Federal           8.861        2
## 428 2014 out-nov-dez Distrito Federal           8.708        2
## 429 2015 jan-fev-mar Distrito Federal          10.784        1
## 430 2015 abr-mai-jun Distrito Federal           9.627        1
## 431 2015 jul-ago-set Distrito Federal          10.258        2
## 432 2015 out-nov-dez Distrito Federal           9.707        2
{% endhighlight %}

Repare que dessa vez que estamos usando `[ ]`. Os colchetes servem para fazermos filtragens "dentro" de um data frame, ou seja, quando queremos apenas um conjunto específico de linhas do data frame, colocamos as condições necessárias para fazer a filtragem dentro do colchete. E nesse caso queremos atribuir 1 ou 2 a uma quantidade de linhas específicas.

Quando falamos de filtragens, necessariamente falamos também de operadores lógicos. Operações lógicas são operações comparativas que respondem tipos booleanos: TRUE (verdadeir) ou FALSE (false).

Vamos com calma! Faça um pequeno experimento com o que tem dentro dos colchetes. Digite o seguinte comando: 


{% highlight r %}
dados$Trimestre == 'jan-fev-mar' | dados$Trimestre == 'abr-mai-jun'
{% endhighlight %}

O R faz essa comparação em todas as linhas e te retorna dizendo exatamente em quais linhas essa condição é verdadeira ou falsa. Esse comando vai retornar verdadeiro para todas as linhas em que trimestre for igual à `jan-fev-mar` **OU** `abr-mai-jun`. 

Para entender melhor, segue alguns operadores lógicos e seus significados:

- `==` igual a: compara dois objetos e se forem iguais, retorna TRUE, caso contrário, FALSE;
- `|` ou (or): compara dois objetos, se um dos dois for TRUE, retorna TRUE, se os dois forem FASE, retorna FALSE;
- `&` e (and): compara dois objetos, se os dois forem TRUE, retorna TRUE, se um dos dois ou os dois forem FALSE, retorna FALSE;

Ao longo dos próximos post vamos trabalhar melhor os operadores lógicos e as filtragens, não se preocupe.

Seguindo com as transformações, vamos supor também que, além de analisar os dados por UF, que extão explícitos na variável dados$UF, queremos também analisar o desemprego por Reigão (Norte, Sul, Nordeste, Centro Oeste e Sudeste)


{% highlight r %}
dados$Regiao[dados$UF %in% c('Rondônia', 'Acre', 'Amazonas', 'Roraima', 'Pará', 'Amapá', 'Tocantins')] <- 'Norte' 
dados$Regiao[dados$UF %in% c('Maranhão', 'Piauí', 'Ceará', 'Rio Grande do Norte', 'Paraíba', 'Pernambuco', 'Alagoas', 'Sergipe', 'Bahia')] <- 'Nordeste' 
dados$Regiao[dados$UF %in% c('Minas Gerais', 'Espírito Santo', 'Rio de Janeiro', 'São Paulo')] <- 'Sudeste'   
dados$Regiao[dados$UF %in% c('Paraná', 'Santa Catarina', 'Rio Grande do Sul')] <- 'Sul'
dados$Regiao[dados$UF %in% c('Mato Grosso do Sul', 'Mato Grosso Goiás', 'Distrito Federal')] <- 'Centro Oeste'
head(dados, 15)
{% endhighlight %}



{% highlight text %}
##     Ano   Trimestre       UF Taxa_Desemprego Semestre Regiao
## 1  2012 jan-fev-mar Rondônia           8.008        1  Norte
## 2  2012 abr-mai-jun Rondônia           6.224        1  Norte
## 3  2012 jul-ago-set Rondônia           5.882        2  Norte
## 4  2012 out-nov-dez Rondônia           5.274        2  Norte
## 5  2013 jan-fev-mar Rondônia           6.114        1  Norte
## 6  2013 abr-mai-jun Rondônia           4.771        1  Norte
## 7  2013 jul-ago-set Rondônia           4.534        2  Norte
## 8  2013 out-nov-dez Rondônia           4.902        2  Norte
## 9  2014 jan-fev-mar Rondônia           4.917        1  Norte
## 10 2014 abr-mai-jun Rondônia           4.112        1  Norte
## 11 2014 jul-ago-set Rondônia           4.111        2  Norte
## 12 2014 out-nov-dez Rondônia           3.575        2  Norte
## 13 2015 jan-fev-mar Rondônia           4.396        1  Norte
## 14 2015 abr-mai-jun Rondônia           4.919        1  Norte
## 15 2015 jul-ago-set Rondônia           6.679        2  Norte
{% endhighlight %}



{% highlight r %}
tail(dados)
{% endhighlight %}



{% highlight text %}
##      Ano   Trimestre               UF Taxa_Desemprego Semestre
## 427 2014 jul-ago-set Distrito Federal           8.861        2
## 428 2014 out-nov-dez Distrito Federal           8.708        2
## 429 2015 jan-fev-mar Distrito Federal          10.784        1
## 430 2015 abr-mai-jun Distrito Federal           9.627        1
## 431 2015 jul-ago-set Distrito Federal          10.258        2
## 432 2015 out-nov-dez Distrito Federal           9.707        2
##           Regiao
## 427 Centro Oeste
## 428 Centro Oeste
## 429 Centro Oeste
## 430 Centro Oeste
## 431 Centro Oeste
## 432 Centro Oeste
{% endhighlight %}

Novamente estamos usando os colchetes para fazer uma filtragem e atribuir `Norte`, `Nordeste`, `Sudeste`, `Sul` e `Centro Oeste` apenas às linhas específicas em que o filtro dentro dos colchetes retorne TRUE. 

Nesse caso estamos usando o operador `%in%`, que faz uma comparação para ver se o objeto está dentro de uma listagem de outros objetos. Nas linhas em que `dados$UF` estiver "dentro" da listagem de UFs, o filtro retornará TRUE.


Para finalizar os exemplos de transformações, vamos tentar uma abordagem com funções matemáticas. Imagine que sua equipe está planejando estimar um modelo com base nesses dados e por algum motivo específico surgiu a necessidade de usar a raiz quadrada e o logarítmo da taxa de desemprego. Não são informações explícitas mas certamente podemos produzir com o que já temos.


{% highlight r %}
dados$Log_Taxa_Desemprego <- log(dados$Taxa_Desemprego)
dados$Sqrt_Taxa_Desemprego <- sqrt(dados$Taxa_Desemprego)
head(dados, 15)
{% endhighlight %}



{% highlight text %}
##     Ano   Trimestre       UF Taxa_Desemprego Semestre Regiao
## 1  2012 jan-fev-mar Rondônia           8.008        1  Norte
## 2  2012 abr-mai-jun Rondônia           6.224        1  Norte
## 3  2012 jul-ago-set Rondônia           5.882        2  Norte
## 4  2012 out-nov-dez Rondônia           5.274        2  Norte
## 5  2013 jan-fev-mar Rondônia           6.114        1  Norte
## 6  2013 abr-mai-jun Rondônia           4.771        1  Norte
## 7  2013 jul-ago-set Rondônia           4.534        2  Norte
## 8  2013 out-nov-dez Rondônia           4.902        2  Norte
## 9  2014 jan-fev-mar Rondônia           4.917        1  Norte
## 10 2014 abr-mai-jun Rondônia           4.112        1  Norte
## 11 2014 jul-ago-set Rondônia           4.111        2  Norte
## 12 2014 out-nov-dez Rondônia           3.575        2  Norte
## 13 2015 jan-fev-mar Rondônia           4.396        1  Norte
## 14 2015 abr-mai-jun Rondônia           4.919        1  Norte
## 15 2015 jul-ago-set Rondônia           6.679        2  Norte
##    Log_Taxa_Desemprego Sqrt_Taxa_Desemprego
## 1             2.080441             2.829841
## 2             1.828413             2.494795
## 3             1.771897             2.425283
## 4             1.662789             2.296519
## 5             1.810581             2.472650
## 6             1.562556             2.184262
## 7             1.511605             2.129319
## 8             1.589643             2.214046
## 9             1.592699             2.217431
## 10            1.413910             2.027807
## 11            1.413666             2.027560
## 12            1.273965             1.890767
## 13            1.480695             2.096664
## 14            1.593105             2.217882
## 15            1.898968             2.584376
{% endhighlight %}

Estamos criando duas novas variáveis em nosso data frame, uma armazenando o `log()` e outra a raiz quadrada `sqrt()`. A função será aplica a todas as linhas do data frame, pois não estamos usando nenhum filtro. Em cada linha será usado o valor do campo `Taxa_Desemprego` como parâmetro das funções.

# Referências:

* [LINK](LINK)

