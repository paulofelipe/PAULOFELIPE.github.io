---
layout: post
title: "Kit de sobrevivência em R - Parte 1"
date: 2016-03-18 21:14:06 -0300
comments: true
categories: [r, básico, rstudio]
published: true
---

Nesta sequênciade posts, iremos tratar o básico necessário para quem deseja iniciar o aprendizado em R. Serão quatros posts em que serão discutidos tópicos como instalação, importação de dados, tipos de dados etc. A nossa expectativa é que com essa sequência seja quebrada a barreira inicial para aqueles que prentendem entrar nesse mundo (cuidado que esse é um caminho sem volta).

<!-- More -->

## Por que o R?

Um motivo básico é que o R é **livre**. Em circustâncias de restrição orçamentária, isso pode ser um fator determimante. No entanto, a escolha do R ultrapassa a questão dos custos. Algumas pessoas têm o costume de pensar que soluções livres são geralmente inferiores às proprietárias. Todavia, no caso de ciência de dados, os softwares livres parecem que vieram para ficar em posição dominante. O grande "concorrente" do R é o Python, outro software livre. 

E qual seria o melhor? Depende. Como tudo na vida, cada um apresenta vantagens e desvantagens. Talvez a sua necessidade dirá qual é o software mais adequado. Se a sua necessidade é de realização de estudos e análises que não serão diretamente ligada a outras plataformas, como uma aplicação web, o R é o ideal para você. O Python parece ser mais indicado em casos de análises serão utilizadas em produção. Este post [aqui](http://www.kdnuggets.com/2015/05/r-vs-python-data-science.html) pode ser útil se você desejar saber mais sobre esse ponto.

## Sobre o RStudio

O [RStudio](https://www.rstudio.com/) é uma interface muito útil pra quem deseja usar o R. Com certeza, a maioria dos usuários de R utilizam o RStudio como IDE (integrated development environment). Nele, você terá um editor de código, um console, um dispositivo para gráficos, além de outras funcionalidades. 

Na figura abaixo, está a "cara" do RStudio. Note que há 4 janelas (ambientes) separadas. As posições delas podem ser alteradas nas opções (`tools` -> `global options`). Além disso, você pode alterar o tema e outras tantas opções. 

<table class="image">
<caption align="bottom">Visão geral do RStudio</caption>
<tr><td><img src="/images/rstudio.png" alt="Uma visão geral do RStudio"/></td></tr>
</table>
<p></p>


Vamos tratar, ainda que superficialmente, de algumas funcionalidades do RStudio. 

#### 1. Editor de Código
No editor de código, você poderá escrever e editar os scripts que conterão um conjunto de comandos que serão executados. O editor do RStudio oferece facilidades como indentação, _code complete_, destaque da sintaxe etc. 

#### 2. Console
No console aparecerão os resultados dos comandos. Você também pode escrever no console e obter os resultados, sem uso do editor de código. Também pode-se chamar a ajuda diretamente pelo console. Por exemplo: `?lm`.

#### 3. _Workspace_ e _History_

No _Workspace_ ficarão guardados todos os objetos que forem criados na sessão. E na aba _History_, como você deve imaginar, o RStudio cria um histórico de comandos. 

#### 4. _Files_, _Plots_, _Packages_, _Help_ e _Viewer_.

Nessa janela, estão várias funcionalidades do RStudio. Na aba _Files_, você terá uma navegação de arquivos do seu computador. Também será possível definir o diretório de trabalho (você também pode definir diretamente no código, mas isto será tratado posteriormente), ou seja, o R  entende o seu diretório de trabalho como ponto de partida para localizar arquivos que sejam chamados no script.

A aba _Plots_ trará os gráficos gerados, possibilitando a exportação para alguns formatos diferentes, como png e pdf.  

Em _Packages_, estão listados os pacotes que estão instalados e você pode verificar quais estão carregados e, caso necessário, poderá carregar algum pacote necessário para a sua análise. Também é possível instalar e atualizar pacotes. Novamente, tudo isso é possível fazer diretamente no código.

_Help_ o nome já diz tudo. Essa aba será bastante utilizada por você. Saber usar o _help_ é fundamental para evitar desperdiço de tempo. Os usuários de R, em geral, são bastante solícitos. Entretanto, uma olhadinha rápida no help pode evitar que você gaste "créditos" desnecessariamente. 

Por fim, o _Viewer_. Essa funcionalidade é utilizada para visualizar localmente conteúdo web. O gráfico da figura está na aba _Viewer_ porque é uma visualização em javascript, que pode ser adicionada a documentos htmls gerados usando o [RMarkdown](http://rmarkdown.rstudio.com/) ou em aplicações web com suporte do [Shiny](http://shiny.rstudio.com/).
	

## Instalando o R e o RStudio

### Windows

Para instalar o R no windows basta realizar o download do executável [aqui](https://cran.r-project.org/bin/windows/base/) e proceder a instalação como qualquer outro software. 

O Rstudio pode ser baixado [neste link](https://www.rstudio.com/products/rstudio/download/). Novamente, a instalação deve ser tranquila, sem a necessidade de maiores detalhes.