---
layout: post
title: "Manipulação de dados - Parte 1: dplyr básico"
date: 2016-07-30 19:22:00 -0300
comments: true
categories: [geral]
published: true
---

Manipulação de dados é uma das habilidades mais básicas que um analista de dados deve ter. Nesse post ensinaremos as principais atividades relacionadas a manipulação de dados utilizando o pacote dplyr, um dos melhores pacotes disponíveis no R para essa finalidade.

<!-- More -->

## O pacote

O [dplyr](https://github.com/hadley/dplyr) é um pacote criado por [Hadley Wickham](https://github.com/hadley), um dos maiores colaboradores da comunidade R. Se você não o conhece e pretende seguir em frente com o R, certamente vai ouvir falar muito dele, pois ele criou diversos pacotes extremamente úteis e fáceis de usar (ggplot2, devtools, tidyr, strigr, etc...). O dplyr foi só um deles.

Trata-se de um pacote otimizado para manipulação de dados, não só com boa performance, mas com sintaxe simples e concisa, facilitando o aprendizado e tornando o pacote um dos preferidos para as tarefas do dia a dia.

O dplyr cobre praticamente todas as tarefas básicas da manipulação de dados: agregar, sumarizar, filtrar, ordenar, criar variáveis, joins, dentre outras.

Para começar, instale, carregue, e dê uma rápida olhada na documentação do dplyr. Em seguida cobriremos suas principais funcões:



{% highlight r %}
install.packages("dplyr")
library(dplyr)
?dplyr
{% endhighlight %}

## Verbetes do dplyr e o operador %>%

As principais tarefas de manipulação de dados podem ser resumidas em algumas simpels palavras, tal qual mencionamos na introdução do post. As funcões do dplyr simplesmente reproduzem essas palavras de forma bastante intuitiva. Veja só:

* select()
* filter()
* arrange()
* distinct()
* mutate()
* group_by()

Além de nomes de funcões intuitivos, o dplyr também faz uso de um recurso disponível em boa parte dos pacotes do Hadley, o operador `%>%`. 

Esse operador encadeia as chamadas de funcões de forma que você não vai precisar ficar chamando uma função dentro da outra ou ficar fazendo atribuições para o fluxo de manipulações. Alias, podemos dizer que esse operador `%>%` literalmente cria um fluxo sequêncial bastante claro e legível para as atividades de manipulação. 

Passaremos todos os verbetes básicos encadeando um com o outro, explicando o uso das funções e do `%>%`, aos poucos seu uso ficará claro e intuitivo.

## select()

Verbo usado para selecionar variáveis do seu data frame.

## filter()

## arrange()

## distinct()

## mutate()

## group_by()


## Título

## Referências

[teste](teste)
