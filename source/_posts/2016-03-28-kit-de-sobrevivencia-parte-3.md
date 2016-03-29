---
layout: post
title: "Kit de Sobrevivência em R - Parte 3"
date: 2016-03-28 22:10:52 -0300
comments: true
categories: [básico, r]
---


Neste post, você aprenderá um pouco mais sobre os pacotes, trabalhará com o console para fazer algumas operações e ir se familiarizando um pouco mais com o R e aprenderá um pouco sobre como usar as funções disponíveis no R e em seus pacotes.

## Pacotes

Os pacotes do R são um conjunto de funções que são carregadas conjuntamente e que possuem uma documentação sobre as funções disponíveis e como usá-las. Além disso, alguns pacotes também fornecem um conjunto de dados que são usados para replicar os exemplos fornecidos. Por exemplo, o `dplyr` é um pacote que possui um série de funções que facilitam consideravelmente a manipulação de dados.

Você tem duas opções para instalar um pacote: via comando ou usando a funcionalidade do RStudio.

Para instalar via comando, você pode digitar o seguinte comando no terminal:


{% highlight r %}
install.packages('readxl')
{% endhighlight %}

Este comando irá instalar o pacote `readxl` que fornece funções para facilitar a importação de dados em arquivos `xls` e `xlsx`. No caso, o pacote fornece duas funções. Uma para listar todas as planilhas que estão em um arquivo do excel e outra para ler os dados de uma planilha pro excel. Em um post futuro sobre a importação de dados, trataremos mais sobre esse pacote. Por enquanto, estamos usando somente como exemplo.

Para realizar a instalação com ajuda do RStudio, basta clicar na aba _Packages_ e depois no botão _Install_. O RStudio irá abrir uma janela como na figura abaixo. Basta você incluir o nome do pacote e clicar em _install_.


[INSERIR FIGURA AQUI]

Mas como saber quais pacotes estão disponíveis para uma determinada tarefa? Muitos pacotes você irá encontrar após uma busca por uma função específica. Todavia, existem algumas páginas que apresentam uma lista de pacotes relacionadas a uma determinada tarefa, que são denominadas de _Task View_. Para exemplificar, veja [aqui](https://cran.r-project.org/web/views/Graphics.html) uma lista de pacotes para realização de gráficos e visualizações. 

Para utilizar as funções de um pacote, você deve carregá-lo antes. Para isso, você deve usar o seguinte comando:

{% highlight r %}
library(readxl)
{% endhighlight %}

Esse comando irá carregar o pacote e tornará possível a utilização de todas funções disponíveis nele. Também existe a possibilidade de carregamento de pacotes usando a função `require()`, que é mais indicado no caso de carregamento de um pacote dentro de uma função. Por enquanto, não nos preocupemos com ele.

Ao trabalhar com pacotes, muitas vezes irá aparecer o termo **CRAN**. Ele significa _Comprehensive R Archive Network_. Este é o principal repositório de pacotes do R. Um pacote que está lá passou por uma série de requisitos antes de ser publicado. Atualmente, estao disponiveis mais de 8.000 pacotes no CRAN. Porém, este é o único local onde os pacotes estão disponíveis? Não. 

Vários pacotes já são disponibilizados pelos autores antes de mesmo da submissão ao CRAN está completa. Não são apenas novos pacotes. Novas versões de um pacote podem se encaixar aqui também. Geralmente, eles estão disponíveis no [github](https://pt.wikipedia.org/wiki/GitHub). Para realizar a instalação desses pacotes, será necessária a instalação do `devtools`. Por exemplo, o `ggplot2` já possui uma versão estável no CRAN. No entanto, se você desejar instalar a versão que está em desenvolvimento, que pode possuir uma nova funcionalidade, faça o seguinte:

{% highlight r %}
install.packages('devtools') # Caso já não esteja instalado ainda
devtools::install_github("hadley/ggplot2")
{% endhighlight %}

Aqui temos um ponto interessante. Para usar funções de pacote, usualmente carrega-se usando o `library()`. Contudo, se você quiser pontualmente uma função de um pacote, pode-se optar pela forma acima: `nome_do_pacote::nome_da_função`.

## Ajuda no R

Você baixou um pacote e não sabe muito bem como usar as funções que estão disponíveis. Nesse caso, você precisará de ajuda. O primeiro passo é buscar uma ajuda geral do pacote em que serão listadas as funções disponíveis e links para a página de _help_ de cada função. Isto pode ser feito a partir do seguinte comando:


{% highlight r %}
help(package = 'readxl')
{% endhighlight %}

Para buscar ajuda sobre uma função específica, existem algumas possibilidades a depender se o pacote já está carregado ou não. Por exemplo:


{% highlight r %}
?read_excel # se o pacote já estiver sido carregado com library(readxl)
?readxl::read_excel # Se o pacote não estiver carregado
??read_excel  # Pacote não carregado. Demora mais para apresentar um resultado
{% endhighlight %}

É importante destacar o `??`, que faz uma busca mais ampla por funções, demonstrações e arquivos que trazem uma visão geral (vignette) de algum pacote/função.

Sendo mais específico, ao buscar a ajuda por uma função específica, será apresentado um texto com uma estrutura padrão: _Description_, _Usage_, _Arguments_ e _Examples_. Além dessas, podem constar outras seções como _Details_ e _Value_, por exemplo. 

É importante destacar o uso (_Usage_) que trará uma forma genérica de utilização dos parâmetros. Em regra, uma função tem uma série de argumentos que serão inseridos na função. Os argumentos são separados por vírgula e os que apresentam `=` possuem um valor padrão. Além disso, nem todos os parâmetros são obrigatórios. Após executar uma função, ela retornará o que está descrito na seção _Value_. Pode ser um único número ou uma lista (nos próximos posts ficará mais claro o que é uma lista) de elementos que pode variar de uma vetor a um texto. 
