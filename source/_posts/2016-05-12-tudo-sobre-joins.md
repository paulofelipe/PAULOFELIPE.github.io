---
layout: post
title: "Tudo sobre Joins (merge) em R"
date: 2016-05-25 21:00:00 -0300
comments: true
categories: [r, intermediário]
published: true
---

Nessa sequência de posts aprenderemos tudo sobre Joins (merges) em R, abordando questões teóricas e práticas, com exemplos usando R base e o pacote dplyr. Após ler esse post, você vai saber o que é, para que serve, quando e como usar diversos tipo de joins.

<!-- More -->

Join é um conceito bastante comum para quem já trabalha com bancos de dados (principalmente com SQL). Porém, para quem está se desenvolvendo em Análise de Dados sem um background em programação de sistemas, talvez esse conceito não seja básico.

## Afinal, o que é Join (ou merge)? 

Nada mais é do que juntar dois conjuntos de dados por meio de um ou mais campos em comum. Esses campos em comum são geralmente chamados de chaves.

Existem vários tipos de joins, dos mais simples aos mais complexos, cada um com sua utilidade e momento certo de uso. Além disso existem várias questões que devem ser observadas no uso de joins, como a granularidade dos dados e ocorrência das amostras nos dois conjuntos de dados.

## Por que usar joins?

Se você é novo no mundo da manipulação de dados, talvez já tenha se perguntado: "De onde vem essa necessidade de usar joins? Por que insistem em usar tantos códigos e separar os dados uns dos outros em tabelas e arquivos diferentes? Por que não simplificar as coisas?". 

Pois saiba que o uso dos joins é uma consequência direta de uma boa prática imposta pelos bancos de dados relacionais: a normalização. Normalização são "regras" para estruturar seus dados de forma que eles ocupem o menor espaço possível e fiquem bastante consistentes na hora de inserir, alterar ou excluir dados. 

No entanto, essas regras adicionam complexidade à estrutura dos dados, e graças a essa complexidade estrutural que surge a necessidade dos joins: juntar dados separados num lugar só.

Em um conjunto de dados normalizado (praticamente TODOS originados de sistemas), existe o conceito de chave: um código que representa uma ocorrência de forma única e inconfundível. Exemplos intuitivos de chave seriam o CPF, o CNPJ, código de um produto, o título de eleitor, etc...

Existem vários tipos de chaves (chave natural, surrogate, chave estrangeira, etc...), mas não vamos entrar nesse nível de detalhe. Para aprofundar mais sobre isso, sugiro [essa leitura](http://www.programmerinterview.com/index.php/database-sql/differences-between-primary-and-foreign-keys/).

Apenas mais uma observação: Os termos e conceitos usados a seguir são originários do mundo dos bancos de dados e SQL, mas, acredite, vale muito a pena conhecer os termos. Portanto, não se assuste! Os conceitos e a utilidade dos tipos de junções são mais importantes do que as nomenclaturas.

> Dica: se você tem familiaridade com Excel, join nada mais é do que o famoso PROCV().

## Inner join (ou apenas join)

Trata-se do join mais simples, mais básico e mais usado dentre todos os outros tipos. Vamos explicar com um exemplo bem simples. Primeiro, vamos montar o conjunto de dados e carregar o pacote `dplyr`:

* `empregados`, com id, nome, idade, uf e id de um cargo


{% highlight r %}
library(dplyr)

id.empregado <- 1:11
nome.empregado <- c('Renato', 'Miguel', 'Paulo', 'Patrícia', 'Inês', 'Saulo', 'Diego', 'Maria', 'Jose', 'Julia', 'Tiago')
idade <- c(30, 31, 29, 30, 25, 30, 30, 35, 24, 31, 29)
uf <- c('MG', 'DF', 'CE', 'DF', 'DF', 'DF', 'RJ', 'SP', 'RS', 'SC', 'BA')
id.cargo <- c(4, 4, 4, 4, 5, 4, 6, 3, 1, 2, 8)
(empregados <- data.frame(id.empregado, nome.empregado, idade, uf, id.cargo))
{% endhighlight %}



{% highlight text %}
##    id.empregado nome.empregado idade uf id.cargo
## 1             1         Renato    30 MG        4
## 2             2         Miguel    31 DF        4
## 3             3          Paulo    29 CE        4
## 4             4       Patrícia    30 DF        4
## 5             5           Inês    25 DF        5
## 6             6          Saulo    30 DF        4
## 7             7          Diego    30 RJ        6
## 8             8          Maria    35 SP        3
## 9             9           Jose    24 RS        1
## 10           10          Julia    31 SC        2
## 11           11          Tiago    29 BA        8
{% endhighlight %}

* `cargos`, com id, nome, e salário do cargo


{% highlight r %}
id.cargo <- 1:7
nome.cargo <- c('Técnico', 'Assistente', 'Consultor', 'Analista', 'Auditor', 'Gerente', 'Gestor')
salario <- c(7000, 4000, 15000, 11000, 10000, 13000, 20000)
(cargos <- data.frame(id.cargo, nome.cargo, salario))
{% endhighlight %}



{% highlight text %}
##   id.cargo nome.cargo salario
## 1        1    Técnico    7000
## 2        2 Assistente    4000
## 3        3  Consultor   15000
## 4        4   Analista   11000
## 5        5    Auditor   10000
## 6        6    Gerente   13000
## 7        7     Gestor   20000
{% endhighlight %}

Imagine que você recebeu essas dois conjuntos de dados será necessário calcular uma média salarial dos empregados por UF. 

Se olharmos apenas `empregados`, cada ocorrência possui um código de cargo que ocupa, mas não temos nem o nome nem o salário do cargo. Se olharmos apenas `cargos`, cada ocorrência possui código de cargo mas não informações de quem o ocupa.

Para calcular a média por UF, precisaremos juntar esses dois conjuntos. Nesse caso, faremos isso usando o *INNER JOIN*. 

Esse tipo de join cria um data frame com todos os campos de ambos conjuntos, mas  retornando somente as ocorrências (linhas) que possuem chaves iguais. Nossa chave é o campo `id.cargo`. Veja:


{% highlight r %}
(merge.r.base <- merge(empregados, cargos)) # inner join com R Base
{% endhighlight %}



{% highlight text %}
##    id.cargo id.empregado nome.empregado idade uf nome.cargo salario
## 1         1            9           Jose    24 RS    Técnico    7000
## 2         2           10          Julia    31 SC Assistente    4000
## 3         3            8          Maria    35 SP  Consultor   15000
## 4         4            1         Renato    30 MG   Analista   11000
## 5         4            2         Miguel    31 DF   Analista   11000
## 6         4            4       Patrícia    30 DF   Analista   11000
## 7         4            6          Saulo    30 DF   Analista   11000
## 8         4            3          Paulo    29 CE   Analista   11000
## 9         5            5           Inês    25 DF    Auditor   10000
## 10        6            7          Diego    30 RJ    Gerente   13000
{% endhighlight %}



{% highlight r %}
(join.dplyr <- inner_join(empregados, cargos)) # inner join com Dplyr
{% endhighlight %}



{% highlight text %}
##    id.empregado nome.empregado idade uf id.cargo nome.cargo salario
## 1             1         Renato    30 MG        4   Analista   11000
## 2             2         Miguel    31 DF        4   Analista   11000
## 3             3          Paulo    29 CE        4   Analista   11000
## 4             4       Patrícia    30 DF        4   Analista   11000
## 5             5           Inês    25 DF        5    Auditor   10000
## 6             6          Saulo    30 DF        4   Analista   11000
## 7             7          Diego    30 RJ        6    Gerente   13000
## 8             8          Maria    35 SP        3  Consultor   15000
## 9             9           Jose    24 RS        1    Técnico    7000
## 10           10          Julia    31 SC        2 Assistente    4000
{% endhighlight %}

> Dica: coloque parênteses entre as atribuições e o R mostrará o resultado dela imediatamente 

Repare que nenhuma pessoa tem o cargo de `id.cargo` 7, então o cargo `Gestor` não aparece no conjunto final já que não há chave igual. Repare também que a pessoa `Tiago` possui `id.cargo` 8, que não é igual a nenhum cargo, então ele também não aparece.

Tanto o `merge()` do R base quanto o `inner_join()` do dplyr tentam descobrir as chaves em comum buscando campos com o mesmo nome. Mas vamos supor que os campos chave tivessem nomes diferentes (o que é bem comum!). Para simular, trocaremos o nome `id.cargo` em `cargos`:


{% highlight r %}
names(cargos) <- c("cargo", "nome.cargo", "salario") 
(merge.r.base <- merge(empregados, cargos, by.x = "id.cargo", by.y = "cargo")) # inner join com R Base, com nomes de chaves diferentes
{% endhighlight %}



{% highlight text %}
##    id.cargo id.empregado nome.empregado idade uf nome.cargo salario
## 1         1            9           Jose    24 RS    Técnico    7000
## 2         2           10          Julia    31 SC Assistente    4000
## 3         3            8          Maria    35 SP  Consultor   15000
## 4         4            1         Renato    30 MG   Analista   11000
## 5         4            2         Miguel    31 DF   Analista   11000
## 6         4            4       Patrícia    30 DF   Analista   11000
## 7         4            6          Saulo    30 DF   Analista   11000
## 8         4            3          Paulo    29 CE   Analista   11000
## 9         5            5           Inês    25 DF    Auditor   10000
## 10        6            7          Diego    30 RJ    Gerente   13000
{% endhighlight %}



{% highlight r %}
(join.dplyr <- inner_join(empregados, cargos, by = c("id.cargo" = "cargo"))) # inner join com Dplyr com nomes de chaves diferentes
{% endhighlight %}



{% highlight text %}
##    id.empregado nome.empregado idade uf id.cargo nome.cargo salario
## 1             1         Renato    30 MG        4   Analista   11000
## 2             2         Miguel    31 DF        4   Analista   11000
## 3             3          Paulo    29 CE        4   Analista   11000
## 4             4       Patrícia    30 DF        4   Analista   11000
## 5             5           Inês    25 DF        5    Auditor   10000
## 6             6          Saulo    30 DF        4   Analista   11000
## 7             7          Diego    30 RJ        6    Gerente   13000
## 8             8          Maria    35 SP        3  Consultor   15000
## 9             9           Jose    24 RS        1    Técnico    7000
## 10           10          Julia    31 SC        2 Assistente    4000
{% endhighlight %}

No R base usamos `by.x` e `by.y` para especificar o nome do campo chave do primeiro e segundo data.frame. No `inner_join()` do dplyr usamos um vetor no formato `c("chave.x" = "chave.y")`.

Resumindo, o inner join retorna todos os campos de ambos os data.frames, mas somente as linhas em que as chaves são iguais.

## Outer join

O inner join despreza os registros de ambos os data.frames onde as chaves não coincidem. Mas existem situações em que esse descarte de registro não é interessante. Nesses casos usamos Outer join.

Existem 3 tipos básicos de outer join: full outer join (ou apenas full join), left outer join (ou só left join) e o right outer join (ou só right join).

Vejamos o seguinte exemplo:

* `pacientes`, com id do paciente, nome abreviado, e resultados de exame A, B e C


{% highlight r %}
id.paciente <- 1:9
nome.abreviado <- c("A.A.M", "S.S.G.F", "T.I.A", "L.O.S.M", "Y.Q.W", "F.A", "T.B.N", "J.J.L", "M.S.S")
exame.a <- c(3.8, 3.8, 3.9, 4.0, 4.4, 3.8, 3.7, 3.6, 4.0)
exame.b <- c(109.98, 109.90, 109.89, 109.99, 110.01, 109.95, 109.98, 109.93, 110.00)
exame.c <- c(0, 1, 1, 0, 1, 1, 0, 0, 1)
pacientes <- data.frame(id.paciente, nome.abreviado, exame.a, exame.b, exame.c)
pacientes
{% endhighlight %}



{% highlight text %}
##   id.paciente nome.abreviado exame.a exame.b exame.c
## 1           1          A.A.M     3.8  109.98       0
## 2           2        S.S.G.F     3.8  109.90       1
## 3           3          T.I.A     3.9  109.89       1
## 4           4        L.O.S.M     4.0  109.99       0
## 5           5          Y.Q.W     4.4  110.01       1
## 6           6            F.A     3.8  109.95       1
## 7           7          T.B.N     3.7  109.98       0
## 8           8          J.J.L     3.6  109.93       0
## 9           9          M.S.S     4.0  110.00       1
{% endhighlight %}

* `controle`, com id do paciente, e o tipo de remédio que tomou


{% highlight r %}
id.paciente <- c(1, 4, 5, 7, 8, 11, 15, 25)
tipo.remedio <- c("A", "B", "A", "B", "A", "A", "B", "B")
controle <- data.frame(id.paciente, tipo.remedio)
controle
{% endhighlight %}



{% highlight text %}
##   id.paciente tipo.remedio
## 1           1            A
## 2           4            B
## 3           5            A
## 4           7            B
## 5           8            A
## 6          11            A
## 7          15            B
## 8          25            B
{% endhighlight %}

Em `pacientes` temos uma lista de pessoas hospitalizadas com uma mesma doença e o resultado de seus exames. Em `controle` temos uma lista controlada de pessoas que participaram de um experimento tomando tipo A e tipo B de um remédio. 

Você precisa montar um conjunto consolidado para avaliar o se houve impacto dos remédios nos exames dos pacientes hospitalizados, para isso, precisa comparar o exame dos que tomaram remédio e dos que não tomaram. Mas nesse caso queremos um join que preserve todos os registros dos `pacientes`, e queremos desprezar os registros de `controle` que não correspondem a pacientes hospitalizados.

### Left outer join (Left join)

Portanto, usaremos o left outer join (ou simplesmente left join):


{% highlight r %}
(left.join.r.base <- merge(pacientes, controle, all.x = TRUE)) # left join com R base
{% endhighlight %}



{% highlight text %}
##   id.paciente nome.abreviado exame.a exame.b exame.c tipo.remedio
## 1           1          A.A.M     3.8  109.98       0            A
## 2           2        S.S.G.F     3.8  109.90       1         <NA>
## 3           3          T.I.A     3.9  109.89       1         <NA>
## 4           4        L.O.S.M     4.0  109.99       0            B
## 5           5          Y.Q.W     4.4  110.01       1            A
## 6           6            F.A     3.8  109.95       1         <NA>
## 7           7          T.B.N     3.7  109.98       0            B
## 8           8          J.J.L     3.6  109.93       0            A
## 9           9          M.S.S     4.0  110.00       1         <NA>
{% endhighlight %}



{% highlight r %}
(left.join.dplyr <- left_join(pacientes, controle)) # left join com dplyr
{% endhighlight %}



{% highlight text %}
##   id.paciente nome.abreviado exame.a exame.b exame.c tipo.remedio
## 1           1          A.A.M     3.8  109.98       0            A
## 2           2        S.S.G.F     3.8  109.90       1         <NA>
## 3           3          T.I.A     3.9  109.89       1         <NA>
## 4           4        L.O.S.M     4.0  109.99       0            B
## 5           5          Y.Q.W     4.4  110.01       1            A
## 6           6            F.A     3.8  109.95       1         <NA>
## 7           7          T.B.N     3.7  109.98       0            B
## 8           8          J.J.L     3.6  109.93       0            A
## 9           9          M.S.S     4.0  110.00       1         <NA>
{% endhighlight %}

Repare que nos resultados temos todos os campos de `pacientes` e `controle` e temos também todos registros de `pacientes`. Quando não há ocorrência da chave `id.paciente` em `controle`, é colocado um `NA` no campo.

Chama-se LEFT outer join pois o "conjunto da esquerda", `pacientes`, deve prevalecer além da interseção. Ou seja, retorna todos os registros onde as chaves são iguais com todos os campos preenchidos dos dois conjuntos, mas também retorna os registros onde as chaves não são iguais sem valor para os campos do conjunto à direita.

### Right outer join (Right join)

O princípio é EXATAMENTE o mesmo do left join. A única diferença é a permanência dos registros do conjunto da direita. Vamos simular o mesmo resultado, usando right join, apenas mudando os conjuntos de lugar na chamada da função:


{% highlight r %}
(right.join.r.base <- merge(controle, pacientes, all.y = TRUE)) # left join com R base
{% endhighlight %}



{% highlight text %}
##   id.paciente tipo.remedio nome.abreviado exame.a exame.b exame.c
## 1           1            A          A.A.M     3.8  109.98       0
## 2           2         <NA>        S.S.G.F     3.8  109.90       1
## 3           3         <NA>          T.I.A     3.9  109.89       1
## 4           4            B        L.O.S.M     4.0  109.99       0
## 5           5            A          Y.Q.W     4.4  110.01       1
## 6           6         <NA>            F.A     3.8  109.95       1
## 7           7            B          T.B.N     3.7  109.98       0
## 8           8            A          J.J.L     3.6  109.93       0
## 9           9         <NA>          M.S.S     4.0  110.00       1
{% endhighlight %}



{% highlight r %}
(right.join.dplyr <- right_join(controle, pacientes)) # left join com dplyr
{% endhighlight %}



{% highlight text %}
##   id.paciente tipo.remedio nome.abreviado exame.a exame.b exame.c
## 1           1            A          A.A.M     3.8  109.98       0
## 2           2         <NA>        S.S.G.F     3.8  109.90       1
## 3           3         <NA>          T.I.A     3.9  109.89       1
## 4           4            B        L.O.S.M     4.0  109.99       0
## 5           5            A          Y.Q.W     4.4  110.01       1
## 6           6         <NA>            F.A     3.8  109.95       1
## 7           7            B          T.B.N     3.7  109.98       0
## 8           8            A          J.J.L     3.6  109.93       0
## 9           9         <NA>          M.S.S     4.0  110.00       1
{% endhighlight %}

Temos o mesmo conteúdo, apenas mudando a ordem dos data.frames e ajustando alguns parâmetros na função.

Tanto o left quanto o right join são usados pra preservar todos os registros de apenas "um lado" do join, trazendo os demais campos do outro conjunto como vazio, e preenchido apenas os registros em que as chaves forem iguais.

### Full outer join (Full join)

Há situações em que é necessário preservar todos os registros de ambos os conjuntos de dados. Vamos testar o seguinte exemplo:

* `exportacoes`, com produto e valor exportado 


{% highlight r %}
produto <- c("A", "C", "D", "H", "I", "J", "K", "O", "Y")
valor <- c(993801, 1829300, 833952, 775831, 59143, 1192920, 6938018, 2927318, 393178)
(exportacoes <- data.frame(produto, valor))
{% endhighlight %}



{% highlight text %}
##   produto   valor
## 1       A  993801
## 2       C 1829300
## 3       D  833952
## 4       H  775831
## 5       I   59143
## 6       J 1192920
## 7       K 6938018
## 8       O 2927318
## 9       Y  393178
{% endhighlight %}

* `importacoes`, com produto e valor importado


{% highlight r %}
produto <- c("B", "C", "D", "E", "F", "H", "I", "J", "M", "N", "O", "Z")
valor <- c(983125, 71983, 61328, 51939, 10928810, 979192, 6019278, 352918, 178263, 64129229, 447009, 1620129)
(importacoes <- data.frame(produto, valor))
{% endhighlight %}



{% highlight text %}
##    produto    valor
## 1        B   983125
## 2        C    71983
## 3        D    61328
## 4        E    51939
## 5        F 10928810
## 6        H   979192
## 7        I  6019278
## 8        J   352918
## 9        M   178263
## 10       N 64129229
## 11       O   447009
## 12       Z  1620129
{% endhighlight %}

Você recebeu dois conjuntos de dados que representam as importações e as exportações de produtos de um pequeno país. Sua missão é fazer uma simples análise de saldo, balança e fluxo de comércio exterior desse país, e produzir alguns relatórios e gráficos comparando produto a produto.

Sendo assim, não é interessante perder nenhum registro de nenhum dos dois data.frames, ambos devem ser preservados para a comparação.

O join da vez é o full join (nome do blog!). Vejamos:


{% highlight r %}
(full.join.r.base <- merge(exportacoes, importacoes, by.x = "produto", by.y = "produto", all.x = TRUE, all.y = TRUE)) # left join com R base
{% endhighlight %}



{% highlight text %}
##    produto valor.x  valor.y
## 1        A  993801       NA
## 2        C 1829300    71983
## 3        D  833952    61328
## 4        H  775831   979192
## 5        I   59143  6019278
## 6        J 1192920   352918
## 7        K 6938018       NA
## 8        O 2927318   447009
## 9        Y  393178       NA
## 10       B      NA   983125
## 11       E      NA    51939
## 12       F      NA 10928810
## 13       M      NA   178263
## 14       N      NA 64129229
## 15       Z      NA  1620129
{% endhighlight %}



{% highlight r %}
(full.join.dplyr <- full_join(exportacoes, importacoes, by = c("produto" = "produto"))) # left join com dplyr
{% endhighlight %}



{% highlight text %}
##    produto valor.x  valor.y
## 1        A  993801       NA
## 2        C 1829300    71983
## 3        D  833952    61328
## 4        H  775831   979192
## 5        I   59143  6019278
## 6        J 1192920   352918
## 7        K 6938018       NA
## 8        O 2927318   447009
## 9        Y  393178       NA
## 10       B      NA   983125
## 11       E      NA    51939
## 12       F      NA 10928810
## 13       M      NA   178263
## 14       N      NA 64129229
## 15       Z      NA  1620129
{% endhighlight %}

Repare que em nosso exemplo há uma particularidade com as chaves. Quando não explicitamos na função os nomes das chaves em `by`, o join é feito pelos campos com nomes iguais. Mas nesse caso, ambos os campos `produto` e `valor` têm nomes iguais nos dois data.frames. Precisamos então explicitar o que queremos que seja chave: apenas `produto`.

O full join preserva todos os registros de ambos os conjuntos. Quando as chaves são iguais, retorna preenchido em todos os campos, quando não são iguais, retorna `NA` em qualquer um dos "lados".

Em nosso exemplo, alguns produtos foram somente exportados e alguns foram somente importados, bem como alguns foram exportados e importados. Como precisamos da totalidade das exportações e importações, o full join atende bem nossa necessidade. Com esse resultado já poderíamos partir para análise do comércio desse país.

## Próximos posts

Em breve faremos mais posts sobre joins, explicando alguns outros tipos menos comuns, como CROSS JOIN, SEMI JOIN, ANTI JOIN, SELF JOIN. 

Até o momento apresentamos junções baseadas na igualdade de joins (equi joins), mas nos próximos posts sobre o assunto mostraremos exemplos onde a comparação das chaves não se da por relação de igualdade (theta join).

## Referências

* [Cheatsheet for dplyr join functions](http://stat545.com/bit001_dplyr-cheatsheet.html)
* [R for Excel users: Merging Data Frames](http://www.rforexcelusers.com/book/shape-your-data/merging-data-frames/)
* [How to Use the merge() Function with Data Sets in R](http://www.dummies.com/how-to/content/how-to-use-the-merge-function-with-data-sets-in-r.html)
* [R for Stat users: Join datasets](http://www.princeton.edu/~mattg/statar/join-and-reshape.html)


