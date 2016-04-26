---
layout: post
title: "Kit de sobrevivência em R - Parte 6: Estruturas de Controle"
date: 2016-05-18 20:04:00 -0300
comments: true
categories: [r, básico, introdução r]
published: false
---
  


No último post, você aprendeu um pouco sobre os tipos de dados e como realizar algumas transformações. Neste post, trataremos um pouco sobre estruturas de controles (for, if, else, while etc.). Estruturas de controles serão bastantes usadas durante o processo de análise de dados, sendo importante que você domine esse tópico.

<!-- More -->

Para exemplificar, utilizaremos os dados de taxas de desemprego que estão disponíveis [neste link](https://www.dropbox.com/s/4tedgnkd85c5q5s/desemprego_uf_pnad.zip?dl=0).

Primeiramente, carregue os dados:

{% highlight r %}
desemprego.uf <- read.table("desemprego_uf_espaco.txt", sep = " ", dec = ",", stringsAsFactors = FALSE)
{% endhighlight %}

## for()

O `for()` é usado para realizar uma série de ordens para uma determinada sequência ou índices. No exemplo abaixo, faremos um _loop_ simples, mas que deixa claro como o `for()` funciona. Suponha que você necessita gerar um único plot com quatro gráficos, um para cada trimestre de 2015, da taxa de desemprego por unidade da federação.

Para facilitar, iremos criar um novo data.frame em que estejam selecionadas somente as linhas em que a variável ano é igual a 2015:


{% highlight r %}
desemprego.uf.2015 <- desemprego.uf[desemprego.uf$Ano == 2015,]
{% endhighlight %}

Perceba que no código base do R, para selecionar linhas de um data.frame, você utiliza o `[,]`. A vírgula divide as duas dimensões do data.frame. Assim, se o desejo é selecionar linhas, são utilizadas condições antes da vírgula. Para selecionar colunas, utiliza-se códigos após a vírgula. Funciona de maneira similar a uma matriz. No entanto, esta não é a única maneira de realizar esse filtro nos dados. Por exemplo, você poderia obter o mesmo resultado usando a função `subset()`. Dê uma olhadinha no help.

Além disso, iremos criar um vetor com os trimestres que serão usados como base para realização do loop.


{% highlight r %}
# Selecionar valores únicos da coluna Trimestre
trimestre <- unique(desemprego.uf.2015$Trimestre)
trimestre
{% endhighlight %}



{% highlight text %}
## [1] jan-fev-mar abr-mai-jun jul-ago-set out-nov-dez
## Levels: abr-mai-jun jan-fev-mar jul-ago-set out-nov-dez
{% endhighlight %}

Antes de criar o plot, vamos realizar um exemplo simples para exemplificar como o `for()` funciona.

{% highlight r %}
for(i in trimestre){
  print(i)
}
{% endhighlight %}



{% highlight text %}
## [1] "jan-fev-mar"
## [1] "abr-mai-jun"
## [1] "jul-ago-set"
## [1] "out-nov-dez"
{% endhighlight %}

Ele realizará a operação que está entre as `{}` para cada `i` do vetor trimestre. Você também pode passar números que poderão ser usados como índices.

{% highlight r %}
x <- c(1, 4, 5, 6, 10)
for(i in 1:5){
  print(x[i])
}
{% endhighlight %}



{% highlight text %}
## [1] 1
## [1] 4
## [1] 5
## [1] 6
## [1] 10
{% endhighlight %}

Agora, vamos definir alguns parâmetros do plot. Aqui usaremos o recurso base do R para geração dos gráficos. Atualmente, uma boa parte dos usuários (inclusive a gente) utiliza o [ggplot2](http://docs.ggplot2.org/current/). Com um pouco de criatividade e uma boa base de dados você poderá criar gráficos como o que está [neste post](https://medium.com/airbnb-engineering/using-r-packages-and-education-to-scale-data-science-at-airbnb-906faa58e12d#.z39ukskpb) do Airbnb. Os parâmetros do plot serão definidos usando a função `par()`. Utilize o `?par` para ver mais detalhes sobre esta função e as opções disponíveis.




{% highlight r %}
par(mfrow = c(2,2), # O plot terá 2 linhas e 2 colunas
    mar = c(8, 5, 4, 2), # margens inferior, esquerda, superior, direita
    las = 2) # rótulos perpendicular aos eixos
{% endhighlight %}

O código abaixo traz o loop. Temos 4 operações dentro do loop:

* Criar o data.frame `dados.tmp` a partir de um filtro no data.frame `desemprego.uf.2015`. Queremos somente as linhas em que o Trimestre é igual a `i`.
* Usando a função `order()`, ordenar as linhas dos `dados.tmp` de forma decrescente pelo valor da taxa de desemprego.
* Criar um objeto de texto que trará o título de cada gráfico. Usamos a função `paste()` que tem o papel de concatenar o que for passado como argumento. Usamos espaço como separador, mas você pode passar qualquer separador entre as aspas. Esta função tem mais um parâmetro: `collapse`. Dê uma olhada no help para ver alguns exemplos. Note também que ele já tem um valor padrão `NULL`.
* Por fim, usamos o `barplot()` para criar o gráfico de barra.


{% highlight r %}
for(i in trimestre){
  dados.tmp <- desemprego.uf.2015[desemprego.uf.2015$Trimestre == i,
                                  c('UF', 'Taxa_Desemprego')]
  dados.tmp <- dados.tmp[order(dados.tmp$Taxa_Desemprego, decreasing = T),]
  # Cria o título do plot
  title <- paste("Taxa de Desemprego 2015:", i, sep = " ")
  # Gera o gráfico de barras
  barplot(dados.tmp$Taxa_Desemprego, names.arg = dados.tmp$UF,
          col = "dodgerblue", border = NA, main = title,
          ylab="%")
}
{% endhighlight %}

Veja o resultado:

![plot of chunk unnamed-chunk-9](/figures/source/2016-04-11-kit-de-sobrevivencia-em-r-parte-6/unnamed-chunk-9-1.png)

O gif abaixo mostra como o R vai inserindo gráfico a gráfico. Adicionei o comando `Sys.sleep()` para que a execução fosse suspensa durante 1,5 segundo para ficar mais claro a criação de cada gráfico.

![alt Usando o for](/images/forloop.gif "Usando o for")

## if e else

Para exemplificar o uso do if e else, vamos continuar com o exemplo anterior, mas desta vez queremos que as barras para o trimestre `out-nov-dez` sejam vermelhas. Dessa forma, usaremos os controles if e else. A ideia é realizar um teste sobre `i` que assume um valor do vetor `trimestre`. Assim, se `i` for igual a `out-nov-dez` a cor será ver vermelha (`col = red`), caso contrário utilizaremos o azul (`col = dodgerblue`).


{% highlight r %}
par(mfrow = c(2,2), # O plot terá 2 linas e 2 colunas
    mar = c(10, 5, 4, 2), # margens inferior, esquerda, superior, direita
    las = 2) # rótulos perpendicular aos eixos
for(i in trimestre){
  dados.tmp <- desemprego.uf.2015[desemprego.uf.2015$Trimestre == i,
                                  c('UF', 'Taxa_Desemprego')]
  dados.tmp <- dados.tmp[order(dados.tmp$Taxa_Desemprego, decreasing = T),]
  title <- paste("Taxa de Desemprego 2015:", i, sep = " ")
  if(i == 'out-nov-dez'){
    barplot(dados.tmp$Taxa_Desemprego, names.arg = dados.tmp$UF,
          col = "red", border = NA, main = title,
          ylab="%")
  }else{
     barplot(dados.tmp$Taxa_Desemprego, names.arg = dados.tmp$UF,
          col = "dodgerblue", border = NA, main = title,
          ylab="%")
  }
}
{% endhighlight %}

![plot of chunk unnamed-chunk-10](/figures/source/2016-04-11-kit-de-sobrevivencia-em-r-parte-6/unnamed-chunk-10-1.png)

Podemos reescrever o código acima com o comando `ifelse()` e obter o mesmo resultado. Para isso, iremos usar o comando `ifelse()` no argumento `col`. O primeiro agumento dessa função é o teste que você deseja realizar (saber se o trimestre é ou não é igual a `out-nov-dez`), o segundo é o valor desejado caso seja verdade e o último é o valor a ser retornado caso a condição não seja satisfeita.


{% highlight r %}
par(mfrow = c(2,2), # O plot terá 2 linas e 2 colunas
    mar = c(10, 5, 4, 2), # margens inferior, esquerda, superior, direita
    las = 2) # rótulos perpendicular aos eixos
for(i in trimestre){
  dados.tmp <- desemprego.uf.2015[desemprego.uf.2015$Trimestre == i,
                                  c('UF', 'Taxa_Desemprego')]
  dados.tmp <- dados.tmp[order(dados.tmp$Taxa_Desemprego, decreasing = T),]
  title <- paste("Taxa de Desemprego 2015:", i, sep = " ")
  barplot(dados.tmp$Taxa_Desemprego, names.arg = dados.tmp$UF,
          col = ifelse(i == 'out-nov-dez', 'red', 'dodgerblue'),
          border = NA, main = title,
          ylab="%")
  
}
{% endhighlight %}

![plot of chunk unnamed-chunk-11](/figures/source/2016-04-11-kit-de-sobrevivencia-em-r-parte-6/unnamed-chunk-11-1.png)

O `ifelse()`tem uma característica importante. Enquanto o `if()` aceita apensas um único teste (comprimento um), o `ifelse` pode receber um vetor para testes e aplicar as condições para este conjunto de teste. Para ficar mais claro veja o exemplo abaixo.


{% highlight r %}
desemprego.uf.2015$Maior.que.9 <- ifelse(desemprego.uf.2015$Taxa_Desemprego > 9,
                                         "Maior que 9",
                                         "Menor ou igual a 9")
head(desemprego.uf.2015, 10)
{% endhighlight %}



{% highlight text %}
##     Ano   Trimestre       UF Taxa_Desemprego        Maior.que.9
## 13 2015 jan-fev-mar Rondônia           4.396 Menor ou igual a 9
## 14 2015 abr-mai-jun Rondônia           4.919 Menor ou igual a 9
## 15 2015 jul-ago-set Rondônia           6.679 Menor ou igual a 9
## 16 2015 out-nov-dez Rondônia           6.276 Menor ou igual a 9
## 29 2015 jan-fev-mar     Acre           8.722 Menor ou igual a 9
## 30 2015 abr-mai-jun     Acre           8.723 Menor ou igual a 9
## 31 2015 jul-ago-set     Acre           8.759 Menor ou igual a 9
## 32 2015 out-nov-dez     Acre           7.588 Menor ou igual a 9
## 45 2015 jan-fev-mar Amazonas           9.358        Maior que 9
## 46 2015 abr-mai-jun Amazonas           9.457        Maior que 9
{% endhighlight %}

## while, repeat, break, next

O `while()` é uma estrutura de controle utilizada para realizar um loop enquanto uma condição for satisfeita. Aqui realizaremos um loop simples somente para demonstrar o funcionamento do `while()`. Será criado um objeto `i` igual a 1 e iremos mostrá-lo no console enquanto for menor ou igual a 5. A cada iteração será adicionado 1 ao valor de `i`. 


{% highlight r %}
i <- 1
while(i <= 5){
  print(i)
  i <-i + 1
}
{% endhighlight %}



{% highlight text %}
## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
{% endhighlight %}

Como você notou no exemplo do `if` e `else`, o R permite que um loop seja elaborado com várias estruturas de controle. Usaremos isto para exemplificar o funcionamento do `repeat` e do `break`. Além disso, também utilizaremos o `if`. O `repeat` realiza as operações que estão entre `{}` indefinidamente. Obviamente, quase sempre  iremos querer que o loop termine caso alguma coisa aconteça. Dessa forma, temos que criar uma condição para que ele pare e uma instrução dizendo que o loop deve terminar caso a condição seja satisfeita. 

No exemplo abaixo, iremos novamente incrementar o objeto `i`, mas queremos que estas operações parem se ele superar 6. Veja o código abaixo.


{% highlight r %}
i <- 1
repeat{
  print(i)
  i <- i + 1
  if(i > 6){
    break # Se a condição é satisfeita, encerra o loop.
  }
}
{% endhighlight %}



{% highlight text %}
## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
## [1] 6
{% endhighlight %}

Por fim, o `next` é usado para pular para a próxima iteração caso uma determinada condição seja satisfeita.


{% highlight r %}
for(i in 1:10){
  if(i > 2 & i <= 4) next
  print(i)
}
{% endhighlight %}



{% highlight text %}
## [1] 1
## [1] 2
## [1] 5
## [1] 6
## [1] 7
## [1] 8
## [1] 9
## [1] 10
{% endhighlight %}

Perceba que não há necessidade das `{}` se a operação a ser executada em um estrutura de controle estiver na mesma linha. Você também poderia usar normalmente o `{}`.


## Algumas observações

Muitas operações que usam loops podem ser realizadas a partir de outros comandos de maneira mais rápida. Os loops no R são conhecidos por serem lentos e dependendo do seu problema eles se tornam inviáveis. No entanto, existem algumas práticas que tornam os loops mais rápidos. Não iremos tratar disso por agora, mas aqueles que tiverem mais curiosidade podem encontrar mais informações [aqui](https://www.datacamp.com/community/tutorials/tutorial-on-loops-in-r).

## Desafio

Fugindo um pouco dos exemplos dos gráficos, vamos lançar um desafio em relação ao método de [Newton-Raphson](https://pt.wikipedia.org/wiki/M%C3%A9todo_de_Newton-Raphson) para que seja encontrada a raiz de uma determinada função. O método consiste em um processo iterativo em que a cada período o valor da variável é atualizado de acordo com uma fórmula e há convergência quando o valor absoluto da função para aquele determinado é inferior a um nível de tolerância.

O objetivo é encontrar a raiz da função:
$$ f(x) = x^3 - 2x - 6 $$

Partindo de um valor inicial, o processo de iteração é o seguinte:

$$x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)} = x_n + \frac{x^3 - 2x - 6}{3x^2 - 2}$$

Use como critério de parada se $f(x_n) < 0.000001$ e como valor inicial $x_0 = -10$.



## Referências

* [How to write the first for loop in R](http://datascienceplus.com/how-to-write-the-loop-in-r/)
* [For loops (and how to avoid them)](http://rforpublichealth.blogspot.com.br/2013/01/for-loops-and-how-to-avoid-them.html)
* [Speed up the loop operation in R](http://stackoverflow.com/questions/2908822/speed-up-the-loop-operation-in-r)
