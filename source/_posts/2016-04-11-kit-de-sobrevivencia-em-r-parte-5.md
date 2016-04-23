---
layout: post
title: "Kit de sobrevivência em R - Parte 5: Tipos de dados e transformações"
date: 2016-04-21 19:00:00 -0300
comments: true
categories: [r, básico, introdução r]
published: true
---

Você já aprendeu como carregar um arquivo de dados no R para começar a trabalhar com ele. Agora vamos conhecer o básico necessário para manipular os dados e prepará-los para a análise propriamente dita. Para isso será necessário saber sobre alguns tipos básicos de dados e algumas formas de transformação de dados.

<!-- More -->

# Porque transformar os dados?

Durante o processo de análise de dados é bastante comum precisar de mais informações que não estão explícitas em sua base de dados, ou seja, informações além das que estão disponíveis nas linhas e colunas. 

Transformar os dados permite extrair, ajustar e até mesmo criar informações com seus dados, criando novas colunas, novas linhas, ou quem sabe um outro arquivo de dados derivado do original.

Infelizmente, aqui vai uma notícia ruim: não existe padrão algum para transformação de dados, vai depender muito do design dos seus dados, das necessidades da sua análise e da sua criatividade!

A notícia boa é que, quanto mais você conhecer formas de transformar os dados e quanto mais dominar os tipos de dados existentes em R, a tarefa de transformação de dados será mais fácil e até mais divertida.

# Tipos de dados

Existem diversos tipos de dados em R, alguns mais básicos e outros mais complexos (não em termos de dificuldade, e sim de estrutura). Vamos tentar apresentar alguns na prática ao longo do post.

Lembra dos dados utilizados no [último post]({{root_url}}/blog/2016/04/12/kit-de-sobrevivencia-em-r-parte-4)? Vamos usá-los novamente como exemplo. Lembre-se de informar ao R o local onde o arquivo está para que ele possa ler. 

Carregue algum dos arquivos de forma apropriada (todos arquivos tem o mesmo conteúdo). Como exemplo, escolhemos o arquivo com colunas delimitadas por `;`.




{% highlight r %}
dados <- read.table('desemprego_uf_ponto_virgula.txt', sep = ";", dec = ",", header = TRUE)  
{% endhighlight %}

Esses dados trazem informações trimestrais ao longo dos anos da taxa de desemprego das Unidades da Federação do Brasil.

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

> Matrizes também são objetos de duas dimensões (linhas e colunas). No entanto, diferentemente do data.frame, elas somente aceitam um tipo de dado.

### Integer

Trata-se de um tipo de dado básico que representa um número inteiro. É tão simples que não há muito o que comentar: 1, 2, 3, 4... até 2147483647. Tente `class(dados$Ano)` e veja que o ano é um tipo inteiro.

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

Mas o que é esse cifrão `$` que usamos nos comandos acima? É uma notação do R para quando você quer visualizar ou trabalhar com uma coluna (variável) de um data.frame. Você verá que o `$` também é utilizado em outros tipos de objetos, como listas. A ideia é acessar uma parte de um objeto. 

No caso data.frame, você informa o nome do objeto, o `$`, e em seguida o nome da coluna que você quer. Experimente: `dados$Ano`, `dados$UF`, `dados$Trimestre` e `dados$Taxa_Desemprego`. Essa notação é muito importante e você a utilizará bastante.

E o que seria essa função `unique()`? É uma função básica do R para listar todos os valores de uma variável sem repetição. Olhando todos os dados em `dados$UF` você vai reparar que os nomes aparecem várias vezes em várias linhas, o `unique()` lista a ocorrência única de cada nome.

### Numeric

Continuando a exploração dos tipos, temos o `numeric` ou `num`, um tipo básico capaz de representar números decimais. O tipo `numeric` também consegue representar inteiros. Tente `class(dados$Taxa_Desemprego)` e repare que é um tipo numerico.

# Transformações

Tendo consciência dos tipos de dados que compõem nosso data frame, já é possível começar a imaginar as análises que podem ser feitas. 

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
tail(dados, 4)
{% endhighlight %}



{% highlight text %}
##      Ano   Trimestre               UF Taxa_Desemprego Semestre
## 429 2015 jan-fev-mar Distrito Federal          10.784        1
## 430 2015 abr-mai-jun Distrito Federal           9.627        1
## 431 2015 jul-ago-set Distrito Federal          10.258        1
## 432 2015 out-nov-dez Distrito Federal           9.707        1
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

Repare que dessa vez estamos usando `[ ]`. Os colchetes servem para fazermos filtragens "dentro" de um vetor ou um data frame. Mas o que é um vetor? O vetor é um objeto unidimensional. Além disso, ele só aceita um tipo de dado.

Mas o que tem isso tem a ver com o código acima? Bem, quando selecionamos a variável semestre, o objeto resultante não será mais um data.frame, e sim um vetor. 


{% highlight r %}
is.vector(dados$Semestre)
{% endhighlight %}



{% highlight text %}
## [1] TRUE
{% endhighlight %}

Veja que a função `is.vector()` verifica se o objeto é um vetor. Ou seja, o objeto tem apenas uma dimensão. Isto tem implicações sobre `[ ]`. Se o objeto possuir duas dimensões, será preciso dizer em qual dimensão você está fazendo a seleção ou filtragem. 

As dimensões são separadas por vírgulas. Por exemplo, no caso do data frame, como existem duas dimensões (linhas e colunas) será preciso dizer em qual nós estamos interessados. Por exemplo, teste os seguintes comandos:


{% highlight r %}
# Selecionar as 5 primeiras linhas
dados[1:5, ]
# Selecionar as 5 primeiras linhas e as duas primeiras colunas
dados[1:5, 1:2]
# Selecionar todas as linhas e as duas primeiras colunas
dados[, 1:2]
{% endhighlight %}

Apesar de ter sido usado apenas números, você pode usar condições e nomes das colunas. Tente o seguinte:


{% highlight r %}
# Selecionar as 5 primeiras linhas e a coluna UF e Taxa_Desemprego
dados[1:5, c("UF", "Taxa_Desemprego")]
{% endhighlight %}

Nesse caso usamos um vetor `c()` para informar a listagem de nomes de colunas. No próximo post aprofundaremos mais no uso das filtragens de linha e coluna dentro do data frame.

No caso da variável semestre, estamos tratando apenas de uma coluna, portanto teremos um vetor unidimensional, logo, as condições que estão dentro `[ ]` serão utilizadas para selecionar as posições exatas que receberão o valor da atribuição `<-`.

Concluindo, vamos usar um exemplo mais complexo. Suponha que você queira criar um data.frame novo apenas com as linhas em que UF é igual a São Paulo e com as colunas `Ano`, `Trimestre` e `Taxa_Desemprego`. Para isto, você irá fazer uma filtragem em um data frame (duas dimensões) e atribuir o resultado para uma variável nova `SP`:


{% highlight r %}
SP <- dados[dados$UF == "São Paulo", c("Ano", "Trimestre", "Taxa_Desemprego")]
head(SP)
{% endhighlight %}



{% highlight text %}
##      Ano   Trimestre Taxa_Desemprego
## 305 2012 jan-fev-mar           7.792
## 306 2012 abr-mai-jun           7.524
## 307 2012 jul-ago-set           6.889
## 308 2012 out-nov-dez           6.754
## 309 2013 jan-fev-mar           7.718
## 310 2013 abr-mai-jun           7.405
{% endhighlight %}

### Logical

Quando falamos de filtragens, necessariamente falamos também de operadores lógicos. Operações lógicas são operações comparativas que respondem um tipo específico de dados, os tipos lógicos(booleanos): TRUE (verdadeiro) ou FALSE (falso). Tente `class(TRUE)` ou `class(FALSE)`. 

Faça um pequeno experimento com o que tem dentro dos colchetes. Digite o seguinte comando: 


{% highlight r %}
dados$Trimestre == 'jan-fev-mar' | dados$Trimestre == 'abr-mai-jun'
{% endhighlight %}

O R faz essa comparação em todas as linhas e te retorna dizendo exatamente em quais linhas essa condição é verdadeira ou falsa. Esse comando vai retornar verdadeiro para todas as linhas em que trimestre for igual à `jan-fev-mar` **OU** for igual a `abr-mai-jun`. 

Para entender melhor, segue alguns operadores lógicos e seus significados:

- `==` igual a: compara dois objetos e se forem iguais, retorna TRUE, caso contrário, FALSE;
- `!=` diferente: compara dois objetos e se forem diferentes, retorna TRUE, caso contrário, FALSE;
- `|` ou (or): compara dois objetos, se um dos dois for TRUE, retorna TRUE, se os dois forem FASE, retorna FALSE;
- `&` e (and): compara dois objetos, se os dois forem TRUE, retorna TRUE, se um dos dois ou os dois forem FALSE, retorna FALSE;
- `>`, `>=`, `<`, `<=` maior, maior ou igual, menor, menor ou igual: compara grandeza de dois números e retorna TRUE ou FALSE confome a condição;

Segue alguns exemplos para entender os operadores lógicos:


{% highlight r %}
5 <= 4
{% endhighlight %}



{% highlight text %}
## [1] FALSE
{% endhighlight %}



{% highlight r %}
5 <= 5
{% endhighlight %}



{% highlight text %}
## [1] TRUE
{% endhighlight %}



{% highlight r %}
5 <= 6
{% endhighlight %}



{% highlight text %}
## [1] TRUE
{% endhighlight %}



{% highlight r %}
5 < 5
{% endhighlight %}



{% highlight text %}
## [1] FALSE
{% endhighlight %}



{% highlight r %}
(5 < 6) | (5 < 3)
{% endhighlight %}



{% highlight text %}
## [1] TRUE
{% endhighlight %}



{% highlight r %}
(5 < 6) & (5 < 3)
{% endhighlight %}



{% highlight text %}
## [1] FALSE
{% endhighlight %}



{% highlight r %}
2 != 1
{% endhighlight %}



{% highlight text %}
## [1] TRUE
{% endhighlight %}



{% highlight r %}
2 == 1
{% endhighlight %}



{% highlight text %}
## [1] FALSE
{% endhighlight %}

Ao longo dos próximos posts vamos trabalhar melhor os operadores lógicos e as filtragens, aos poucos o uso ficará intuitivo.

Seguindo com as transformações, vamos supor também que, além de analisar o desemprego por UF, que estão explícitos na variável `dados$UF`, queremos também analisar o desemprego por Região (Norte, Sul, Nordeste, Centro Oeste e Sudeste):


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

Novamente estamos usando os colchetes para fazer uma filtragem e atribuir `Norte`, `Nordeste`, `Sudeste`, `Sul` e `Centro Oeste` apenas às linhas específicas em que o filtro dentro dos colchetes retorne `TRUE`. 

Nesse caso estamos usando o operador `%in%`, que faz uma comparação para ver se o objeto está dentro de uma listagem (vetor) de outros objetos. Nas linhas em que `dados$UF` estiver "dentro" da listagem de UFs, o filtro retornará TRUE e a atribuição da variável será feita, caso contrário retornará FALSE e não vai atribuir o valor à `dados$Regiao`.

Para finalizar os exemplos de transformações, vamos tentar uma abordagem com funções matemáticas. Imagine que sua equipe está planejando estimar um modelo com base nesses dados e por algum motivo específico surgiu a necessidade de usar o logarítmo da taxa de desemprego. Não é uma informações explícita mas certamente podemos produzir com o que já temos.


{% highlight r %}
dados$Log_Taxa_Desemprego <- log(dados$Taxa_Desemprego)
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
##    Log_Taxa_Desemprego
## 1             2.080441
## 2             1.828413
## 3             1.771897
## 4             1.662789
## 5             1.810581
## 6             1.562556
## 7             1.511605
## 8             1.589643
## 9             1.592699
## 10            1.413910
## 11            1.413666
## 12            1.273965
## 13            1.480695
## 14            1.593105
## 15            1.898968
{% endhighlight %}

Estamos criando uma novas variável em nosso data frame, armazenando o `log()` na nova variável `Log_Taxa_Desemprego` em nosso data frame. 

A função será aplicada a todas as linhas do data frame, pois não estamos usando nenhum filtro. Em cada linha será usado o valor do campo `Taxa_Desemprego` como parâmetro da função.

# Desafio

Apenas para treinar, tente criar uma variável nesse data frame para classificar a taxa de desemprego em `alta`, `média` ou `baixa`, com o critério que quiser. Crie também uma variável armazenando a raiz quadrada da taxa de desemprego. 

Muitas outras transformações são possíveis com essa simples base de dados usando atribuição com filtros e funções matemáticas. Consegue imaginar outras transformações? Deixe um comentário sobre os resultados que conseguiu!

# Referências:

* [Basic Data Types](http://www.cyclismo.org/tutorial/R/types.html)
* [Basic Data Types II](http://www.r-tutor.com/r-introduction/basic-data-types)
* [4 data wrangling tasks in R for advanced beginners](http://www.computerworld.com/article/2486425/business-intelligence/business-intelligence-4-data-wrangling-tasks-in-r-for-advanced-beginners.html)


