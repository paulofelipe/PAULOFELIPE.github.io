---
layout: post
title: "Séries Temporais Brasileiras no R - Pacote BETS"
date: 2017-01-14 15:01:00 -0300
comments: true
categories: [pacotes, séries temporais]
published: false
---




## Sobre o pacote

O pacote `BETS` (_Brazilian Economic Time Series_) fornece uma séries de facilidades para acesso de séries temporais brasileiras disponíveis pela FGV, pelo Banco Central e pelo IBGE. Além disso, estão disponíveis uma série de funcionalidades para uma análise inicial dessas séries. 

Quem tem rotinas baseadas em análises dessas séries, tem uma noção de quão útil pode ser esse pacote. Sem ele, era necessário criar rotinas específicas para obter esses dados automaticamentes ou, pior ainda, criar uma rotina manual.

[Aqui](http://slides.com/johnazevedo/deck-5/fullscreen#/) está o link da apresentação realizada pelos desenvolvedores do pacote.

<!-- More -->


## Instalando o pacote

Em primeiro lugar, tive alguns problemas com a instalação do pacote no Ubuntu 16.04. O erro ocorria na instalação da dependência `rgl`. Para solucionar, tive que instalar dois pacote no ubuntu:


{% highlight r %}
sudo apt-get install mesa-common-dev libglu1-mesa-dev
{% endhighlight %}

Agora, instalando o pacote:


{% highlight r %}
install.packages("BETS")
{% endhighlight %}

## Usando o pacote


{% highlight r %}
library(BETS)
{% endhighlight %}



{% highlight text %}
## Warning: replacing previous import by 'stringr::%>%' when loading
## 'BETS'
{% endhighlight %}



{% highlight text %}
## Warning: replacing previous import by 'zoo::as.yearmon' when loading
## 'BETS'
{% endhighlight %}



{% highlight text %}
## Warning: replacing previous import by 'zoo::as.yearqtr' when loading
## 'BETS'
{% endhighlight %}



{% highlight text %}
## Warning: replacing previous import by 'stats::predict' when loading
## 'seasonal'
{% endhighlight %}



{% highlight text %}
## Warning: replacing previous import by 'stats::update' when loading
## 'seasonal'
{% endhighlight %}



{% highlight text %}
## Warning: replacing previous import by 'zoo::zooreg' when loading
## 'BETS'
{% endhighlight %}



{% highlight r %}
# Procurando uma série

BETS.search(description = "Exports")
{% endhighlight %}



{% highlight text %}
## Warning in dir.create(meta.dir, recursive = T): não foi possível criar
## o diretório '/etc/xdg/xdg-ubuntu', motivo 'Permissão negada'
{% endhighlight %}



{% highlight text %}
## Warning in gzfile(file, "wb"): não foi possível abrir o arquivo
## comprimido '/etc/xdg/xdg-ubuntu/Metadata/bacen_v7.Rda', motivo
## provável 'Arquivo ou diretório não encontrado'
{% endhighlight %}



{% highlight text %}
## Error in gzfile(file, "wb"): não é possível abrir a conexão
{% endhighlight %}



{% highlight r %}
exp_brasil <- BETS.get(4192)
{% endhighlight %}



{% highlight text %}
## Warning in dir.create(meta.dir, recursive = T): não foi possível criar
## o diretório '/etc/xdg/xdg-ubuntu', motivo 'Permissão negada'
{% endhighlight %}



{% highlight text %}
## Warning in dir.create(meta.dir, recursive = T): não foi possível abrir
## o arquivo comprimido '/etc/xdg/xdg-ubuntu/Metadata/bacen_v7.Rda',
## motivo provável 'Arquivo ou diretório não encontrado'
{% endhighlight %}



{% highlight text %}
## Error in gzfile(file, "wb"): não é possível abrir a conexão
{% endhighlight %}


