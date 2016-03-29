---
layout: post
title: "Kit de sobrevivência em R - Parte 2"
date: 2016-03-25 15:20:01 -0300
comments: true
categories: [r, básico]
published: true
---

# TESTE 
Seguindo a proposta da sequência *Kit de sobrevivência em R*, vamos aprofundar um pouco mais no funcionamento do R e como fazer uso disso. Nesse post trataremos sobre comandos de console, operações básicas, variáveis, funções, e script R no editor de códigos.

<!-- More -->

Como dito no post anterior, o RStudio apresenta [4 janelas](link para o post), cada uma com sua função. No entanto, podemos dizer que as duas janelas que você mais vai usar são *Editor de Códigos* e o *Console*. 
	
# Usando o console

Sendo bem simplista, R é uma linguagem que funciona com base em comandos. O console é o lugar onde você digita um comando (uma instrução) e em seguida recebe uma resposta com o resultado. Para quem nunca teve contato com nenhuma outra linguagem de programação, esse simples conceito pode parecer um pouco abstrato. Não há como entendê-lo sem ser praticando.

Observe no console do RStudio que há um símbolo `>`. Esse símbolo indica o lugar onde você vai escrever os seus comandos. Pois bem, clique lá e digite `2*5` em seguida aperte _enter_. Você verá o seguinte:


{% highlight r %}
2*5
{% endhighlight %}



{% highlight text %}
## [1] 10
{% endhighlight %}

O que aconteceu? Você digitou o comando "multiplique 2 vezes 5" no console, e o R respondeu com o resultado 10. E o que é esse `[1]` na resposta do R? Bom, isso significa que o resultado do seu comando só teve uma linha. Em alguns casos o resultado será mais de uma linha, então o R usa essa notação de índices `[x]` para mostrar os resultados do comando. Não se preocupe muito com isso por agora.

# Uma grande calculadora

O R interpreta os seus comandos e da um resultado apropriado para cada um. Para que os comandos sejam interpretados corretamente você deve usar os elementos da linguagem. Por ser uma linguagem estatística, o R já vem com muitas operações prontas para serem usadas. Por exemplo, todas as operações básicas da matemática. Digite os seguintes comandos no console, apertando _enter_ após cada linha, para ver o resutlado:


{% highlight r %}
5 + 3 #Soma
{% endhighlight %}



{% highlight text %}
## [1] 8
{% endhighlight %}



{% highlight r %}
5 - 3 #Subração
{% endhighlight %}



{% highlight text %}
## [1] 2
{% endhighlight %}



{% highlight r %}
5 * 3 #Multiplicação
{% endhighlight %}



{% highlight text %}
## [1] 15
{% endhighlight %}



{% highlight r %}
5 / 3 #Divisão
{% endhighlight %}



{% highlight text %}
## [1] 1.666667
{% endhighlight %}



{% highlight r %}
5 ^ 3 #Exponenciação
{% endhighlight %}



{% highlight text %}
## [1] 125
{% endhighlight %}



{% highlight r %}
2 ^ (4 - 2) * -8 / (5 * (10 + 3)) #expressões matemáticas e seus precedentes
{% endhighlight %}



{% highlight text %}
## [1] -0.4923077
{% endhighlight %}

Mas o que é esse `#`? Trata-se de um símbolo indicando um comentário. Um comentário é alguma explicação que você escreve em seus comandos e que o R não interpreta, ou seja, não influencia no resultado final. Serve apenas para documentar, comentar ou explicar alguma parte dos seus comandos.

Reaprem que, com o que foi dito até agora, já da pra usar o R como uma grande calculadora de luxo!

>Dica: no console, aperte seta para cima do teclado e você terá os últimos comandos digitados.

# Variáveis

Na maioria dos casos, o tabalho que você precisará fazer vai exigir mais do que uma simples calculadora pode oferecer, será necessário conhecer mais das possiblidades do R. 

A estrutura mais básica que você irá utilizar é chamada *variável*. Mais uma vez, buscando ser simplista, variável nada mais é do que um pequeno espaço na memória do seu computador onde você armazena o resultado de um comando. E para esse pequeno espaço de memória você da o nome que você quiser!

O uso de variáveis é extremamente útil, pois muito provavelmente você precisarar armazenar resultados de comandos para operá-los em conjunto logo em seguida.

Para armazenar uma variável no R você deve usar o seguinte símbolo `<-`, formando uma setinha direcionada para a esquerda. Você pode chamar suas variáveis do que você quiser! Elas podem conter letras, números, ponto `.`, e _underscore_ `_`, e podem ter o tamanho qualquer tamanho. Há apenas uma regra: o nome das variáveis deve começar com letras (maiúsculas ou minúsculas).


{% highlight r %}
minha_PRIMEIRA.variavel <- 9 ^ 10 #Nome esdruxulo de variávei apenas para exemplificar!
{% endhighlight %}

"Ué, apertei enter e nada aconteceu?". Aconteceu sim! Você colocou o resultado de `9 ^ 10` dentro da variável chamada `minha_PRIMEIRA.variavel`. Para comprovar e para ver o que tem "dentro da variável", digite apenas o nome da variável e aperte enter:


{% highlight r %}
minha_PRIMEIRA.variavel
{% endhighlight %}



{% highlight text %}
## [1] 3486784401
{% endhighlight %}

Sempre que precisar usar o valor de 9 ^ 10, basta usar sua variável `minha_PRIMEIRA.variavel` e pronto, terá o resultado dessa operação armazenado sem precisar calcular novamente. Você pode fazer diversas operações com as variáveis. Por exemplo:


{% highlight r %}
x <- 5 / 2
y <- 3 ^ 2
z <- y - x #Resultado da operação y menos o resultado da operação x
z
{% endhighlight %}



{% highlight text %}
## [1] 6.5
{% endhighlight %}

>Dica: use nomes explicativos! Talvez não pareça muito útil agora, mas existem alguns padrões e boas práticas para escrever comando sem R que vai ajudar muito na hora de você mesmo ou outras pessoas entenderem o que foi feito. Recomendamos a leitura de alguns padrões de nomenclatura, [como este aqui](padrão de R, qual?).



{% highlight r %}
primeira.variavel <- -5 * 4 #padrão com ponto, mais comum em R
primeiraVariavel <- -5 * 4 #padrão camel case, comum em outras linguagens de programação
primeira_variavel <- -5 * 4 #padrão underscore
{% endhighlight %}

Pronto, você já sabe usar o console para comandos com os operadores matemáticos básicos e sabe armazenar resultados em variáveis. 

# Funções

Precisaremos mais do que simples variáveis e simples operações matemáticas para usar toda potencialidade do R.

Existem alguns "programas" prontos para uso no R, ou seja, algumas sequências de comandos preparados para serem usados de forma simples e facilitar sua vida. Esses "programas" prontos são chamados de funções, e são usados para tudo que você possa imaginar: cálculos mais complexos, estatística, análise de dados, manipulação de dados, gráficos, relatórios, etc. 

Na verdade, uma das coisas que torna o R uma ótima linguagem estatística é a gigantesca quantidade de funções disponíveis. Para (quase) tudo que você quiser fazer, existe uma função que facilita as coisas. Algumas funções já vem com a instalação base do R, outras você precisa instalar um pacote extra (falaremos disso em breve). 

Uma funcão tem dois elementos básicos: o nome e o(s) parâmetro(s). Por exemplo, função para cálculo de raiz quadrada:


{% highlight r %}
raiz.quadrada <- sqrt(16) 
raiz.quadrada
{% endhighlight %}



{% highlight text %}
## [1] 4
{% endhighlight %}

Ou seja, `sqrt` é o nome da função para calcular raiz quadrada, e `16` é o parâmetro que você informa para função calcular. Detalhe: o resultado das funções também podem ser armazenados em variáveis, tal qual demonstra o exemplo.

Um outro exemplo, é a função para arredondar um número:


{% highlight r %}
x <- 5.99999
round(x, 2)
{% endhighlight %}



{% highlight text %}
## [1] 6
{% endhighlight %}

Ou seja, `round` é o nome da função para arredondamento. Já o `x`, a variável que armazena `5.99999`, é o primeiro parâmetro, informando o número que você quer arredondar. E temos o `2` como segundo parâmetro, informando até quantas casas decimais você quer arredondar. 

Como dito, a instalação base do R já vem com algumas funções muito utilizadas. Segue [uma](link funções R base) lista para conhecer melhor cada uma dessas funcões básicas. Na sequência de posts apresentaremos pacotes com muito mais funções importantes disponíveis.

# Script.R (editor)

Você agora consegue fazer cálculos básicos, armazenar resultados em variáveis e usar funções para auxiliar nos cálculos. Mas tudo isso usando o console.

O console é extremamente útil para algumas atividades exploratórias, mas, no geral, para trabalhos envolvendo ciência de dados, será necessário escrever um script.

Script nada mais é do que uma sequência de comandos, iguais aos que você escreveria no console, mas escritos em um *arquivo de texto*, de forma que todos eles possam ser executados em um momento único pelo R, e os resultados apresentados de uma vez só.

No console você digita um comando, aperta enter e em seguida recebe o resultado. No editor de texto você digita todos os comandos na sequência que você gostaria, e manda o R executar tudo de uma vez.

Um script é outro conceito abstrato que fica mais fácil de entender praticando.

Deixe o console um pouco de lado agora. Clique em `File > New File > R script`(explicar como criar um novo script em branco? Português? Atalho?). Procure a janela com o editor de código e escreva o seguinte:


{% highlight r %}
x <- sqrt(4)
y <- sqrt(16)
total <- x + y
total
{% endhighlight %}



{% highlight text %}
## [1] 6
{% endhighlight %}

Agora clique em `Source` (atalho?). O resultado do seu script irá aparecer no console.  Agora salve o seu script em `File > Save` escolha uma pasta, de um nome e, ao final do nome, escreva `.R`. Pronto. Você criou, executou e salvou um script em R! Agora você pode abrir esse script sempre que você quiser e executá-lo novamente.

Ao salvar, repare que o formato do arquivo ficou `.R`. Esse é o formato convencionado para scripts em R. 

Foi um longo post, mas finalmente chegamos ao fim! Esperamos que esse post tenha dado uma boa noção de como usar o console com operações e funções básicas, bem como armazenar resultados em variáveis. A partir de agora, salve seus trabalhos em scripts com formato .R e sempre que quiser executá-los use o botão Source. Até a próxima.

