---
layout: post
title: "Kit de sobrevivência em R - Parte 7: Avançando e Aprofundando"
date: 2016-05-09 20:04:00 -0300
comments: true
categories: [r, básico, introdução ao r]
published: true
---
  


Chegamos ao fim do [kit de sobrevivência em R]({{root_url}}/blog/categories/introducao-ao-r). Nesse último post da série vamos retomar alguns pontos que merecem ser complementados e revisados, além de apresentar um pouco mais de transformações e operações usando apenas funções básicas do R.

<!-- More -->

Se você seguiu a sequência e chegou até aqui, parabéns! Você provavelmente conhece o básico de R e o suficiente para começar a aprofundar em aspectos mais interessantes sobre operações com massas de dados.

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

Comentamos sobre algumas funções básicas para começar a explorar seus dados carregados. Você lembra?


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
|------|:-------------|
| **logical** | Valor lógico, `TRUE` ou `FALSE`. Usado com os operadores lógicos `&, |, ==, !=, >, <, >=, <=` |
| **integer** | Valores de números inteiros |
| **numeric** | Valores de números decimais. Também representam números inteiros |
| **character** | Valores textuais, também conhecidos como string |

<br/>  

### Conversões

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

Dominar as estruturas de dados do R será fundamental no desenvolvimento das suas análises. Inicialmente, a ideia de estrutura de dados pode parecer um pouco abstrata, mas conhecê-las e saber suas características será útil para você perceber quais são as possibilidades.

A tabela abaixo apresenta um resumo das estruturas básicas. Ela está baseada na explicação que está no livro do [_Advanced R_](http://adv-r.had.co.nz/Data-structures.html) do Hadley Wickham (leitura recomendada pra quem deseja aprofundar seus conhecimento em R).

| Tipo | Descrição | Dimensões | Homogêneo |
|---|:---|---|---|---|
| **vector** | Coleção de elementos simples. Todos os elementos precisam ser do mesmo tipo básico de dado | 1 | Sim |
| **array** | Coleção que se parece com o vector, mas é multidimensional | n | Sim |
| **matrix** | Tipo especial de array com duas dimensões | 2 | Sim |
| **list** | Objeto complexo com elementos que podem ser de diferentes tipos | 1 | Não |
| **data.frame** | Tipo especial de lista onde cada coluna é um vetor de apenas um tipo e todos as colunas têm o mesmo número de registros. É o tipo mais utilizado se trabalhar com dados | 2 | Não |
| **factor** | Tipo especial de vector que só contém valores pré definidos (levels) e categóricos (characters). Não é possível adicionar novas categorias sem criação de novos levels | 1 |  Não |

<br/>  

Do que se trata o campo `Dimensões` na tabela? Na prática, isso afetará como você usará partes desse objeto. Por exemplo, um objeto com duas dimensões tem linhas e colunas. Assim, você usará `[ , ]` (com vírgula separando linha e coluna, respectivamente) para acessar a dimensão que você deseja selecionar. Já um objeto unidimensional terá seus elementos acessados usando apenas `[ ]`. A lista, por sua vez, tem seus elementos acessados com `[[ ]]`.

E o campo `Homogêneo` da tabela? Trata-se de mais uma características das estruturas de dados. Diz respeito à variedade de tipos básicos que um objeto pode conter. Por exemplo, vetores só aceitam um tipo de dado. Assim, se você atribuir dois tipos diferentes, ele forçará para um único tipo. Listas e data frames aceitam diferentes tipos de dados.

### Observações sobre listas 

Lista pode causar um pouco de confusão no começo. Daremos alguns exemplos para explicar melhor.

Iremos criar listas com duas bases de dados que já são fornecidas como exemplos no próprio R. Primeiramente, vamos carregar as duas bases de dados:


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

Veja que temos dois data frames. Agora, vamos criar um objeto único que irá receber essas duas bases. Além disso, a fim de mostrar a heterogeneidade, iremos incluir um objeto que será um vetor. 


{% highlight r %}
x <- 1:10
lista.teste <- list(mtcars, iris, x)
{% endhighlight %}

Faça um teste e digite `lista.teste` no console para ver o resultado. 

E como eu faço pra acessar partes específicas? Como dissemos a lista tem uma pequena diferença, será necessário usar o `[[ ]]`. Lembre-se que, como a lista é um objeto de dimensão 1, só precisaremos passar o índice que temos interesse. O vetor `x` é o terceiro elemento. Logo, para acessá-lo podemos fazer o seguinte:


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

<br/>

### Observações sobre vectors

Vectors possuem algumas propriedades muito úteis como `length()`, `typeof()` e `unique()`. Você também poderá usar o `length()` para saber o tamanho de uma lista. 

### Observações sobre data.frames

As funções `nrow()` e `ncol()` podem ser usadas para saber, respectivamente, o número de linhas e colunas de um data.frame (ou de uma matriz).

Data.frames também podem ter o nome das colunas alterados. Veja o exemplo a seguir:


{% highlight r %}
head(iris)
{% endhighlight %}



{% highlight text %}
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
{% endhighlight %}



{% highlight r %}
names(iris)
{% endhighlight %}



{% highlight text %}
## [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" 
## [5] "Species"
{% endhighlight %}



{% highlight r %}
names(iris) <- c("campo1", "campo2", "campo3", "campo4", "campo5")
head(iris)
{% endhighlight %}



{% highlight text %}
##   campo1 campo2 campo3 campo4 campo5
## 1    5.1    3.5    1.4    0.2 setosa
## 2    4.9    3.0    1.4    0.2 setosa
## 3    4.7    3.2    1.3    0.2 setosa
## 4    4.6    3.1    1.5    0.2 setosa
## 5    5.0    3.6    1.4    0.2 setosa
## 6    5.4    3.9    1.7    0.4 setosa
{% endhighlight %}

## Valores Faltantes (Missing)

O R atribui `NA` para valores faltantes. Ou seja, se por acaso uma determinada posição de um vetor ou de uma coluna de um data.frame não possui valor algum, o R mostrará `NA`. 

É muito comum lidar com conjuntos de dados que tenham ocorrências de `NA` em alguns campos. É importante saber o que fazer em casos de `NA`, e nem sempre a solução será a mesma, vai variar de acordo com as suas necessidades.

Em algumas bases de dados, quem gera o dado atribui valores genéricos como 999 ou até mesmo um "texto vazio" `' '`. Nesse caso, você provavelmente terá que substituir esses valores "omissos" por `NA`. 

Vamos explicar as funções básicas para começar a lidar com `NA` no R.

Em primeiro lugar, criaremos um simples data.frame para exemplificar:


{% highlight r %}
data.ex <- data.frame(col1 = letters[1:6], col2 = c(10, 20, 30, NA, 50, NA))
data.ex
{% endhighlight %}



{% highlight text %}
##   col1 col2
## 1    a   10
## 2    b   20
## 3    c   30
## 4    d   NA
## 5    e   50
## 6    f   NA
{% endhighlight %}



{% highlight r %}
summary(data.ex)
{% endhighlight %}



{% highlight text %}
##  col1       col2     
##  a:1   Min.   :10.0  
##  b:1   1st Qu.:17.5  
##  c:1   Median :25.0  
##  d:1   Mean   :27.5  
##  e:1   3rd Qu.:35.0  
##  f:1   Max.   :50.0  
##        NA's   :2
{% endhighlight %}

Usamos o `letters` que é uma lista pré construída no R e que retorna as 26 letras do alfabeto. No caso, usamos só as seis primeiras. Na segunda coluna, colocamos alguns `NA`'s. 

A função `summary` mostra que existem dois `NA`'s na `col2`. Nesse exemplo fica fácil para encontrar onde estão os `NA`'s e fazer alguma modificação caso deseje, mas considere um caso em que seu data.frame é grande. Você não iria conseguir identificar no olho. Assim, é necessário usar algumas funções. Vamos começar como o `is.na()`:


{% highlight r %}
is.na(data.ex$col2)
{% endhighlight %}



{% highlight text %}
## [1] FALSE FALSE FALSE  TRUE FALSE  TRUE
{% endhighlight %}



{% highlight r %}
which(is.na(data.ex$col2))
{% endhighlight %}



{% highlight text %}
## [1] 4 6
{% endhighlight %}

O `is.na()` realiza um teste para saber se cada elemento da variável `col2` é um missing. Além disso, se usarmos o `is.na()` dentro da função `which()` saberemos quais as posições que possuem o `NA`. Um detalhe importante sobre funções que retornam `TRUE` ou `FALSE` como o `is.na()` é que você pode usar a `!` para fazer o teste ao contrário. Isto é, se quisermos saber quais não são `NA`, faremos o seguinte:


{% highlight r %}
!is.na(data.ex$col2)
{% endhighlight %}



{% highlight text %}
## [1]  TRUE  TRUE  TRUE FALSE  TRUE FALSE
{% endhighlight %}

Notou que a função retornou o contrário de `is.na(data.ex$col2)`? 

Agora iremos introduzir a função `complete.cases()`. Bastante utilizada, essa função retorna `TRUE` para as linhas em que todas as colunas possuem valores válidos e `FALSE` para as linhas em que em alguma coluna existe um `NA`. Ou seja, essa função diz quais são as linhas (amostras) completas em todas suas características (campos).


{% highlight r %}
complete.cases(data.ex)
{% endhighlight %}



{% highlight text %}
## [1]  TRUE  TRUE  TRUE FALSE  TRUE FALSE
{% endhighlight %}



{% highlight r %}
!complete.cases(data.ex)
{% endhighlight %}



{% highlight text %}
## [1] FALSE FALSE FALSE  TRUE FALSE  TRUE
{% endhighlight %}

Podemos usar o retorno dessa função para selecionar linhas do nosso data.frame:


{% highlight r %}
data.ex[!complete.cases(data.ex),]
{% endhighlight %}



{% highlight text %}
##   col1 col2
## 4    d   NA
## 6    f   NA
{% endhighlight %}



{% highlight r %}
data.ex[complete.cases(data.ex),]
{% endhighlight %}



{% highlight text %}
##   col1 col2
## 1    a   10
## 2    b   20
## 3    c   30
## 5    e   50
{% endhighlight %}

Você poderia usar a função `na.omit()` para obter o mesmo resultado da seleção de linhas com o `complete.cases()`:


{% highlight r %}
na.omit(data.ex)
{% endhighlight %}



{% highlight text %}
##   col1 col2
## 1    a   10
## 2    b   20
## 3    c   30
## 5    e   50
{% endhighlight %}

Por fim, iremos imputar a média da `col2` nas linhas em que há `NA`. Para isso, usaremos o `ifelse()` que tratamos na [parte 6]({{root_url}}/blog/2016/05/01/kit-de-sobrevivencia-em-r-parte-6/) e o `is.na()`, além da função `mean()`.


{% highlight r %}
# Calcular a média da col2
media.col2 <- mean(data.ex$col2, na.rm = TRUE)
media.col2
{% endhighlight %}



{% highlight text %}
## [1] 27.5
{% endhighlight %}



{% highlight r %}
data.ex$col2[is.na(data.ex$col2)] <- media.col2
data.ex
{% endhighlight %}



{% highlight text %}
##   col1 col2
## 1    a 10.0
## 2    b 20.0
## 3    c 30.0
## 4    d 27.5
## 5    e 50.0
## 6    f 27.5
{% endhighlight %}

Note que na função `mean()` usamos o argumento `na.rm`. Ele significa "remover `NA`", o que é necessário nesse cálculo, pois se os `NA`'s não forem retirados, a média será `NA` também.

Imputar dados em casos de `NA` é uma das várias estratégias para lidar com ocorrência de missing no conjunto dos dados.

## Exemplo final: Titanic

Vamos dar um exemplo final de algumas transformações e manipulações de dados na tentativa de resumir todos os aspectos tratados no kit de sobrevivência em R.

Escolhemos a base de dados dos passageiros do Titanic! É uma base muito utilizada como tutorial de machine learning onde o objetivo é criar um modelo para prever os sobreviventes do acidente. Se você pretende aprender machine learning, certamente vai esbarrar (ou já esbarrou) com essa base de dados. Inclusive há uma série de [tutoriais de machine learning com essa base no Kaggle](https://www.kaggle.com/c/titanic).

Nosso objetivo não é criar nenhum modelo nem ensinar a fazer isso, vamos apenas explorar a base, manipular, transformar e criar algumas variáveis. Teremos muitos posts em breve sobre modelos preditivos e machine learning!

Primeiro criamos um novo script, lembre-se sempre de salvar o seu trabalho para não perder nada. Em seguida vamos limpar o ambiente de memória para começar.


{% highlight r %}
rm(list = ls())
{% endhighlight %}

Vamos instalar e carregar o pacote R que disponibiliza os dados.




{% highlight r %}
install.packages('titanic')
library(titanic)
{% endhighlight %}

O data frame que iremos usar já estará carregado na memória e se chama `titanic_train`. Trata-se da base de treinamento usada para treinar modelos. Vamos dar uma olhada. As bases de treinamento já vem com a resposta na variável que você quer descobrir na base de teste. Nesse caso os modelos que usam essa base são treinados para descobrir a variável `Survived`.


{% highlight r %}
str(titanic_train)
{% endhighlight %}



{% highlight text %}
## 'data.frame':	891 obs. of  12 variables:
##  $ PassengerId: int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Survived   : int  0 1 1 1 0 0 0 0 1 1 ...
##  $ Pclass     : int  3 1 3 1 3 3 1 3 3 2 ...
##  $ Name       : chr  "Braund, Mr. Owen Harris" "Cumings, Mrs. John Bradley (Florence Briggs Thayer)" "Heikkinen, Miss. Laina" "Futrelle, Mrs. Jacques Heath (Lily May Peel)" ...
##  $ Sex        : chr  "male" "female" "female" "female" ...
##  $ Age        : num  22 38 26 35 35 NA 54 2 27 14 ...
##  $ SibSp      : int  1 1 0 1 0 0 0 3 0 1 ...
##  $ Parch      : int  0 0 0 0 0 0 0 1 2 0 ...
##  $ Ticket     : chr  "A/5 21171" "PC 17599" "STON/O2. 3101282" "113803" ...
##  $ Fare       : num  7.25 71.28 7.92 53.1 8.05 ...
##  $ Cabin      : chr  "" "C85" "" "C123" ...
##  $ Embarked   : chr  "S" "C" "S" "S" ...
{% endhighlight %}



{% highlight r %}
head(titanic_train)
{% endhighlight %}



{% highlight text %}
##   PassengerId Survived Pclass
## 1           1        0      3
## 2           2        1      1
## 3           3        1      3
## 4           4        1      1
## 5           5        0      3
## 6           6        0      3
##                                                  Name    Sex Age
## 1                             Braund, Mr. Owen Harris   male  22
## 2 Cumings, Mrs. John Bradley (Florence Briggs Thayer) female  38
## 3                              Heikkinen, Miss. Laina female  26
## 4        Futrelle, Mrs. Jacques Heath (Lily May Peel) female  35
## 5                            Allen, Mr. William Henry   male  35
## 6                                    Moran, Mr. James   male  NA
##   SibSp Parch           Ticket    Fare Cabin Embarked
## 1     1     0        A/5 21171  7.2500              S
## 2     1     0         PC 17599 71.2833   C85        C
## 3     0     0 STON/O2. 3101282  7.9250              S
## 4     1     0           113803 53.1000  C123        S
## 5     0     0           373450  8.0500              S
## 6     0     0           330877  8.4583              Q
{% endhighlight %}

Repare que cada linha representa um passageiro e cada campo representa uma característica desse passageiro. As variáveis (campos) estão em inglês e talvez não sejam tão óbvias. Segue explicação de cada uma:

Nome do campo | Descrição do campo
--------------|:-------------
**Survived**  | Passageiro sobrevivente (1) ou morto (0)
**Pclass**    | Classe do passageiro
**Name**      | Nome do passageiro
**Sex**       | Gênero do passageiro (male ou female)
**Age**       | Idade do passageiro
**SibSp**     | Número de irmãos ou cônjuges a bordo
**Parch**     | Número de pais ou filhos a bordo
**Ticket**    | Número do tíquete
**Fare**      | Preço do tíquete
**Cabin**     | Cabine
**Embarked**  | Portão de embarque

<br/>

Vamos traduzir os nomes dos campos para facilitar o entendimento. Para isso usaremos a função `names()`


{% highlight r %}
names(titanic_train)
{% endhighlight %}



{% highlight text %}
##  [1] "PassengerId" "Survived"    "Pclass"      "Name"       
##  [5] "Sex"         "Age"         "SibSp"       "Parch"      
##  [9] "Ticket"      "Fare"        "Cabin"       "Embarked"
{% endhighlight %}



{% highlight r %}
names(titanic_train) <- c('id_passageiro', 'sobrevivente', 
			'classe', 'nome', 'sexo', 'idade',
			'irmaos_conjuge', 'pais_filhos', 'numero_ticket', 'valor_ticket', 'cabine', 'porta_embarque')
{% endhighlight %}

Como o objetivo dessa base de dados é treinar um modelo para descobrir se um passageiro vai sobreviver ou não, vamos manipular e criar variáveis para tentar ajudar a atingir esse objetivo. O ideal é fazer uma bela análise exploratória dos dados, com auxílio de gráficos e estatística básica, mas nosso foco agora é apenas na transformação de dados, portanto, tentaremos um pouco de intuição e criatividade para criar variáveis possivelmente úteis.

Vamos começar com a variável `idade`. Há um comportamento interessante nessa variável: missings!


{% highlight r %}
unique(titanic_train$idade)
{% endhighlight %}



{% highlight text %}
##  [1] 22.00 38.00 26.00 35.00    NA 54.00  2.00 27.00 14.00  4.00 58.00
## [12] 20.00 39.00 55.00 31.00 34.00 15.00 28.00  8.00 19.00 40.00 66.00
## [23] 42.00 21.00 18.00  3.00  7.00 49.00 29.00 65.00 28.50  5.00 11.00
## [34] 45.00 17.00 32.00 16.00 25.00  0.83 30.00 33.00 23.00 24.00 46.00
## [45] 59.00 71.00 37.00 47.00 14.50 70.50 32.50 12.00  9.00 36.50 51.00
## [56] 55.50 40.50 44.00  1.00 61.00 56.00 50.00 36.00 45.50 20.50 62.00
## [67] 41.00 52.00 63.00 23.50  0.92 43.00 60.00 10.00 64.00 13.00 48.00
## [78]  0.75 53.00 57.00 80.00 70.00 24.50  6.00  0.67 30.50  0.42 34.50
## [89] 74.00
{% endhighlight %}



{% highlight r %}
sum(is.na(titanic_train$idade))
{% endhighlight %}



{% highlight text %}
## [1] 177
{% endhighlight %}

Usando `sum()` junto com `is.na()` conseguimos contar a quantidade total de `NA` na variável.

Nesse nosso caso específico, vamos interpretar `NA` como se o passageiro tivesse a idade desconhecida, seja lá qual for o motivo. Dependendo do algoritmo de machine learning que será aplicado a esses dados, a presença de `NA` não é bem vinda. Portanto, precisamos lidar com os `NA`s dessa variável.

A título de exemplificação, vamos adicionar a média geral das idades quando não soubermos a idade do passageiro. (Veja, essa nem sempre é uma boa estratégia para imputação de dados. Vamos usá-la agora apenas por ser bem simples).


{% highlight r %}
media <- mean(titanic_train$idade, na.rm = TRUE)
media
{% endhighlight %}



{% highlight text %}
## [1] 29.69912
{% endhighlight %}



{% highlight r %}
titanic_train$idade <- ifelse(is.na(titanic_train$idade), round(media), titanic_train$idade)
{% endhighlight %}

Calculamos a média desconsiderando ocorrências de `NA`, em seguida atribuímos a média (arredondada) às ocorrências de `NA`. 

Agora todos os passageiros tem idade, alguns a idade correta, outros uma idade atribuída. Vamos criar agora uma classificação de `jovem`, `adulto` ou `idoso` para essa variável. 

Pode ser que isso ajude algum algoritmo a prever melhor quem vive ou quem morre no acidente, pois, intuitivamente, talvez jovens sejam imaturos fiquem mais assustados, talvez idosos tenham menos habilidade de fuga e adultos talvez lidem melhor com situações de emergência. 

Sendo assim, até 20 anos chamaremos de `jovem`, de 21 a 54 chamaremos de `adulto`, e acima de 55 chamaremos de `idoso`. Vamos chamar essa variável de `faixa_etaria`.


{% highlight r %}
titanic_train$faixa_etaria <- ifelse(titanic_train$idade <= 20, 'jovem', ifelse(titanic_train$idade > 21 & titanic_train$idade < 55, 'adulto', 'idoso'))
head(titanic_train[,c('idade', 'faixa_etaria')], 15)
{% endhighlight %}



{% highlight text %}
##    idade faixa_etaria
## 1     22       adulto
## 2     38       adulto
## 3     26       adulto
## 4     35       adulto
## 5     35       adulto
## 6     30       adulto
## 7     54       adulto
## 8      2        jovem
## 9     27       adulto
## 10    14        jovem
## 11     4        jovem
## 12    58        idoso
## 13    20        jovem
## 14    39       adulto
## 15    14        jovem
{% endhighlight %}

Uma outra variável que pode ser interessante para ajudar modelos preditivos pode ser o total de parentes. Será que quanto mais parentes o passageiro tiver, mais ele se preocupe em salvar a vida dos seus entes queridos, botando a sua vida em risco? Ou será que a prioridade "mulheres e crianças primeiro" ajudou quem tinha família a sobreviver? 

Há uma variável para irmãos e cônjuges, e outra para crianças ou pais. Vamos somá-las e criar o `total_parentes`.


{% highlight r %}
titanic_train$total_parentes <- titanic_train$irmaos_conjuge + titanic_train$pais_filhos
{% endhighlight %}

Para complementar essa ideia, vamos tentar distinguir quem tinha família e quem não tinha, criando uma variável categórica simplesmente indicando se o passageiro tem família ou não:


{% highlight r %}
titanic_train$familia <- ifelse(titanic_train$total_parentes > 0, 'Sim', 'Nao')
{% endhighlight %}

Seguindo com as transformações, o título do passageiro pode dizer algo sobre ele. Vamos tentar isolar o título em uma variável para explicitar isso aos possíveis algoritmos:


{% highlight r %}
titanic_train$titulo <- lapply(strsplit(titanic_train$nome, '[,.]'), "[", 2)
head(titanic_train[,c('nome', 'titulo')], 15)
{% endhighlight %}



{% highlight text %}
##                                                   nome  titulo
## 1                              Braund, Mr. Owen Harris      Mr
## 2  Cumings, Mrs. John Bradley (Florence Briggs Thayer)     Mrs
## 3                               Heikkinen, Miss. Laina    Miss
## 4         Futrelle, Mrs. Jacques Heath (Lily May Peel)     Mrs
## 5                             Allen, Mr. William Henry      Mr
## 6                                     Moran, Mr. James      Mr
## 7                              McCarthy, Mr. Timothy J      Mr
## 8                       Palsson, Master. Gosta Leonard  Master
## 9    Johnson, Mrs. Oscar W (Elisabeth Vilhelmina Berg)     Mrs
## 10                 Nasser, Mrs. Nicholas (Adele Achem)     Mrs
## 11                     Sandstrom, Miss. Marguerite Rut    Miss
## 12                            Bonnell, Miss. Elizabeth    Miss
## 13                      Saundercock, Mr. William Henry      Mr
## 14                         Andersson, Mr. Anders Johan      Mr
## 15                Vestrom, Miss. Hulda Amanda Adolfina    Miss
{% endhighlight %}

O comando usado talvez seja um pouco avançado, mas vamos tentar explicar por partes. Primeiramente usamos o `strsplit()`, uma função que lida com caracteres e divide uma string baseado numa marcação. Nesse caso, estamos dividindo o nome do passageiro em dois pontos: vírgula `,` e ponto `.`, que é justamente o padrão textual que separa o título no nome.

O resultado do `strsplit()` é uma lista com as partes da separação. Para acessar exatamente o segundo elemento da lista, que é onde está o título, usamos o `lapply()`, uma função da família `apply`, que executa um comando repetidamente ao longo de uma estrutura (coluna, array, listas, matrizes, etc...). O efeito prático das funções da família `apply` se assemelha muito à loops.

Dominar a família `apply` pode ser muito interessante para se tornar um bom analista de dados. Certamente faremos uma sequência de posts explicando detalhadamente todas as funções da família `apply`, aguarde!

## Conclusão

E é isso pessoal. Chegamos ao fim da sequência. Esperamos que tenha gostado e aprendido o kit básico de sobrevivência em R. Daqui em diante os posts serão intermediários e avançados, tratando de questões mais profundas como junção de dados, visualização de dados, análise exploratória, estatística, machine learning.


## Referências

* [Deal with missing data](http://www.uni-kiel.de/psychologie/rexrepos/posts/missingData.html)
* [Missing data](http://www.statmethods.net/input/missingdata.html)
* [A brief introduction to “apply” in R](https://nsaunders.wordpress.com/2010/08/20/a-brief-introduction-to-apply-in-r/)
* [R tutorial on the Apply family of functions](https://www.datacamp.com/community/tutorials/r-tutorial-apply-family)

## Demais posts da sequência:

* [Kit de sobrevivência em R - Parte 1: Visão Geral e Instalação]({{root_url}}/blog/2016/03/23/kit-de-sobrevivencia-em-r-parte-1)
* [Kit de sobrevivência em R - Parte 2: Operações, Variáveis e Funções]({{root_url}}/blog/2016/04/03/kit-de-sobrevivencia-em-r-parte-2)
* [Kit de sobrevivência em R - Parte 3: Pacotes]({{root_url}}/blog/2016/04/03/kit-de-sobrevivencia-em-r-parte-3)
* [Kit de sobrevivência em R - Parte 4: Carregando Dados]({{root_url}}/blog/2016/04/12/kit-de-sobrevivencia-em-r-parte-4)
* [Kit de sobrevivência em R - Parte 5: Tipos de Dados e Transformações]({{root_url}}/blog/2016/04/21/kit-de-sobrevivencia-em-r-parte-5)
* [Kit de sobrevivência em R - Parte 6: Estruturas de Controle]({{root_url}}/blog/2016/05/01/kit-de-sobrevivencia-em-r-parte-6)
* [Kit de sobrevivência em R - Parte 7: Avançando e Aprofundando]({{root_url}}/blog/2016/05/09/kit-de-sobrevivencia-em-r-parte-7)
