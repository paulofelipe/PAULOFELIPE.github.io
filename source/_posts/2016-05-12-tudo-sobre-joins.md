---
layout: post
title: "Tudo sobre Joins (merge) em R"
date: 2016-05-12 21:00:00 -0300
comments: true
categories: [r, intermediario]
published: true
---

Nessa sequência de posts aprenderemos tudo sobre Joins (merges) em R, abordando questões teóricas e práticas e exemplificando com as 3 formas mais comuns: R base, pacote dplyr e pacote data table. Após ler esse post, você vai saber o que é, para que serve e como usar os diversos tipo de join (inner, outer, cross, anti e self), bem como conhecer o conceito de natural, equi e theta join

<!-- More -->

Join é um conceito bastante comum para quem já trabalha com bancos de dados (principalmente SQL). Porém, para quem está se desenvolvendo em Análise de Dados sem um background em programção de sistemas, talvez esse conceito não seja básico.

## Afinal, o que é Join (ou merge)? 

Nada mais é do que juntar dois conjuntos de dados por meio de um ou mais campos em comum.
Esses campos em comum são geralmente chamados de chaves e para que o join aconteça ele deve estar presente nos dois conjuntos de dados. Por exemplo: (**PENSAR EM UM EXEMPLO SIMPLES E INTUITIVO**)

Existem vários tipos de joins, dos mais simples aos mais complexos, cada um com sua utilidade e momento certo de uso. Além disso existem várias questões que devem ser observadas no uso de joins, como a granularidade dos dados e ocorrência das amostras.

## Por que usar joins?

Se você é novo no mundo da manipulação de dados, talvez já tenha se perguntado: "De onde vem essa necessidade de usar joins? Por que insistem em usar tantos códigos e separar os dados uns dos outros em tabelas e arquivos diferentes? Por que não simplificar as coisas?". 

Pois saiba que o uso dos joins é uma consequência direta de uma boa prática imposta pelos bancos de dados relacionais: a normalização. Normalização são "regras" para estrutruar seus dados de forma que eles ocupem o menor espaço possível e fiquem bastante consistentes na hora de inserir, alterar ou excluir dados do seu conjunto de dados. 

No entanto, essas regras adicionam complexidade à estrutura dos dados, e graças à essa complexidade estrutural que surge a necessidade dos joins: juntar dados separados num lugar só.

Em um conjunto de dados normalizado (praticamente TODOS originados de sistemas), existe o conceito de chave: um código que representa uma ocorrência de forma única e inconfundível. Exemplos intuitivos de chave seriam o CPF, o CNPJ, código de um produto, o título de eleitor, etc...

O conceito de chave é fundamental para entender joins, pois é com base nas chaves que os joins acontecem. Existem vários tipos de chaves (chave natural, surrogate, chave estrageira, etc...), mas não vamos entrar nesse nível de detalhe agora. Para aprofundar mais sobre chaves, sugiro [essa leitura](LINK).

Antes de começar com os exemplos, apenas mais uma observação. Os termos e conceitos usados a seguir são originários do mundo dos bancos de dados e SQL, mas conhecer profundamente sobre os tipos de relações com os dados vai te ajudar a solucionar problemas do dia a dia em sua Análise de Dados de forma muito mais simples e intuitiva, sem necessariamente ser especialista em bancos de dados e SQL. Sendo assim, não se assuste com os termos! O mais importante são os conceitos e a utilidade dos tipos de junções.

Vamos aos joins!

## Inner join (ou apenas join)

Trata-se do join mais simples, mais básico e mais usado dentre todos os outros tipos.
Montamos uma pequena base de dados para fins didáticos e vermos na prática o resultado de cada join!


{% highlight r %}
codigo <- 1:10
nome <- c('Renato', 'Miguel', 'Paulo', 'Patrícia', 'Inês', 'Saulo', 'Diego', 'Maria', 'Jose', 'Julia')
idade <- c(30, 31, 29, 30, 25, 30, 30, 35, 24, 31)
uf <- c('MG', 'DF', 'CE', 'DF', 'DF', 'DF', 'RJ', 'SP', 'RS', 'SC')
dados <- data.frame(codigo, nome, idade, uf)
{% endhighlight %}

#### R Base

teste de tamanho de subtítulo

#### Dplyr

teste tes te

testestestse

#### Data Table

asdfasdfasfd
asdf

asdfasdf

## Outer join

Enquanto o inner join retorna "a parte de dentro", ou seja, somente a interseção das chaves, o outer join retorna a interseção e os registros que não coincidirem, ou seja "a parte de fora". Existem 3 tipos básicos de outer join: full outer join, left outer join (ou só left join) e o right outer join (ou só right join)

### Left outer join (Left join)

### Right outer join (Right join)

### Full outer join (Full join)


## Proximos posts


## Referências

* []()

