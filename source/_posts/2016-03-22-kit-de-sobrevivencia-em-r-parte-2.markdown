---
layout: post
title: "Kit de sobrevivência em R - Parte 2"
date: 2016-03-22 20:50:09 -0300
comments: true
categories: [r, básico, rstudio]
published: false
---


Seguindo a sequência do *Kit de sobrevivência em R*, vamos abordar um pouco sobre uma das partes iniciais de qualquer análise ou trabalho que vá ser feito no R: carregamento e leitura de dados.

<!-- More -->

Eis aqui uma notícia ruim: não existe um padrão dominante para armazenamento de dados. O que isso significa? Significa que, na vida real, você vai se deparar com os mais diferentes tipos de fontes de dados e mesmo assim vai ter que dar um jeito de analisá-las e estudá-las para concluir seus trabalhos. 

Ou seja, existem diversas formas de carregar dados para trabalhar com eles no R. Em prol da objetividade, vamos tratar dos casos mais comuns e mais básicos primeiro. Esse assunto pode ser extremamente vasto, então, criaremos primeiro uma base para, em posts futuros, aprofundarmos em fontes de dados mais complexas.

## Estrutura dos dados

Você vai encontrar dados disonbilizados basicamente em três formas básicas: estruturados, não estruturados e semi-estruturados. 

Dados estruturados basicamente são conjuntos de informações organizadas em colunas (atribuos, variáveis, _features_, etc.) e linhas (registros, itens, observacões, etc.). São dados encontrados em bancos de dados, arquivos com algum tipo de separação entre as colunas, excel (nem todos!), arquivos com campos de tamanho fixo, etc. *foto de uma tabela??*

Dados não estruturados, como o nome diz, não tem um estrutura previsível, ou seja, cada arquivo possui uma forma única de ser carregado e manejado. Geralmente são arquivos com forte teor textual. Podemos citar, por exemplo, emails, twitters, PDFs, imagens, etc. Muito usados em mineração de dados.

Já os arquivos semi-estruturados também possuem uma estrutura fixa, porém, não seguem o padrão de estrutura linha/coluna, ou seja, é uma estrutura mais complexa e flexível, geralmente hierárquica, estruturada em tags ou marcadores de campos. São exemplos de arquivos semi-estruturados: JSON, XML, HTML, YAML, etc. É o formato mais usado em troca de dados pela internet e consumo de APIs. *foto de um exemplo de JSON?*, *colocar links*

Como dito anteriormente, trataremos primeiro dos arquivos estruturados. Em futuros posts vamos abordar os outros tipos, pois são abordagens um puco mais complexa e é sempre bom começar pelo básico!

## Preparando o ambiente

### Limpando tudo 
(é correto falar de sessão? ou melhor "ambiente"?)
Antes de começar os trabalhos, é uma boa prática ter certeza de que não tem nada na sessão (entenda como memória RAM) impedindo o R de trabalhar. Um simples comando garante que está tudo limpo pronto para começar:

{% highlight r  %}
 rm(list=ls())
{% endhighlight %} 

```r
rm(list=ls())
```

Lembra de onde os comandos em R devem ser digitados? Não? [Relembre aqui um pouco sobre RStudio]

Esse comando na verdade está usando outros dois comandos:

* `rm()` é o comando para remover um objeto da sessão do R

* `ls()` é o comando para listar os nomes de todos objetos da sessão do R

Os dois comandos conjugados significa dizer *remova tudo que estiver na lista de objetos da sessão do R.*

Pronto. Seus ambiente está limpo.

### Definindo diretório de trabalho

O R vai "ler" os dados de algum lugar do seu computador. Normalmente ele inicial em um diretório padrão, mas nem sempre os arquivos estarão nesse mesmo diretório. Para dizer ao R onde ele deve ler os arquivos, usaremos o comando _set working directory_:

{% highlight r  %}
 setwd("Local/Do/Seus/Arquivos/De/Trabalho/")
{% endhighlight %}

Também pode ser realizado pelos menus do RStudio em `Session > Set Working Directory > Choose Directory...` e escolha a pasta onde seus arquivos de dado estarão.

Ok! Agora si

## falar do caminho via RStudio tmb
aproveitar e explicar getwd()

## falar sobre delimitadores
campos e colunas
linhas e registros

### delimitador TAB
read.table()

### csv
read.csv()
atalho de read.table()

### outros delimitadores
read.delim()
atalho de read.table()

### excel
XLConnect?
readxl?
xls?

### campos de tamanho fixo?
read.fwf()
dados de comércio exterior

### loaders para outros sistemas estatísticos
spss
dta

### carregar um .Rdata ?

### carregar de banco de dado??

### JSON?

### XML?

### Deixas para mais um post sobre carregamento
list.files() e loop de leitura
webscraping
PDF
SQL







