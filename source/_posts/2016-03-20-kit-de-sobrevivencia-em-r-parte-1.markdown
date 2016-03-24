---
layout: post
title: "Kit de sobrevivência em R - Parte 1"
date: 2016-03-23 21:14:06 -0300
comments: true
categories: [r, básico, rstudio]
published: true
---

Nesta sequênciade de posts, iremos tratar o básico necessário para quem deseja iniciar o aprendizado em [R](https://www.r-project.org/about.html). Trata-se de uma linguagem de programação muito usada para cálculos estatísticos. Neste e nos próximos posts, discutiremos tópicos como instalação, importação de dados, tipos de dados, etc. 

A nossa expectativa é que, com essa sequência, seja quebrada a barreira inicial para aqueles que prentendem entrar nesse mundo (cuidado que esse é um caminho sem volta!).

<!-- More -->

## Por que aprender uma linguagem estatística?

Qualquer um que trablhe um pouco mais com dados já esbarrou nas limitações do "excel" ou de softwares de planilha. Nada contra, são ótimos, mas as vezes eles dificultam mais do que ajudam. Abrir a mente e se permitir novas formas de trabalho pode render bons frutos.

Trabalhos de manipulação de dados, verificação, limpeza e junção de dados, ou até alguns cálculos com uma massa de dados um pouco maior podem se tornar um pouco traumáticos se você não usar as ferramentas mais adequadas.

As linguagens de programação estatística ajudam muito nesse sentido. São ferramentas poderosíssimas que praticamente derrubam os limites das possibilidades de se trabalhar com dados: você pode fazer praticamente qualquer coisa!

"Eu trabalho com dados de forma básica, mas não quero me tornar um ciêntista de dados... ainda assim é útil?". Com certeza! Linguagens de programação estatística, mesmo que aprendendo apenas o básico, aumentam muito a produtividade.

Portanto, sugerimos fortemente que aprenda uma linguagem estatística o quanto antes!

## Por que o R?

Um motivo básico é que o R é **livre**. Em circustâncias de restrição orçamentária, isso pode ser um fator determimante. No entanto, a escolha do R ultrapassa a questão dos custos. Algumas pessoas têm o costume de pensar que soluções livres são geralmente inferiores às proprietárias.

Todavia, no caso de ciência de dados, os softwares livres parecem que vieram para ficar em posição dominante. De acordo com [essa pesquisa](http://blog.dominodatalab.com/open-source-winning-against-proprietary-data-science-vendors/), o mercado da ciência de dados está sendo dominado por softwares livres.

Podemos dizer, então, que grande "concorrente" do R no momento é o Python, outro software livre. 

E qual seria o melhor? Depende. Como tudo na vida, cada um apresenta vantagens e desvantagens. O importante é tirar proveito das diferenças. Sua necessidade dirá qual é o software mais adequado. 

Se a sua necessidade é de realização de estudos e análises que não serão diretamente ligada a outras plataformas, como uma aplicação web por exemplo, o R é o ideal para você. O Python costuma ser mais indicado em casos de análises que resultarão em algo mais sistemático. Este post [aqui](http://www.kdnuggets.com/2015/05/r-vs-python-data-science.html) pode ser útil se você desejar saber mais sobre esse ponto.

## Sobre o RStudio

O [RStudio](https://www.rstudio.com/) é uma interface muito útil pra quem deseja usar o R. Com certeza, a maioria dos usuários de R utilizam o RStudio como [IDE (integrated development environment)](https://pt.wikipedia.org/wiki/Ambiente_de_desenvolvimento_integrado). Nele, você terá um editor de código, um console, um dispositivo para gráficos, um [_debugger_](https://pt.wikipedia.org/wiki/Depura%C3%A7%C3%A3o), além de outras funcionalidades. 

Na figura abaixo, está a "cara" do RStudio. Note que há 4 janelas (ambientes) separadas. As posições delas podem ser alteradas nas opções (`tools` -> `global options`). Além disso, você pode alterar o tema e outras tantas opções. 

<table class="image">
<caption align="bottom">Visão geral do RStudio</caption>
<tr><td><img src="/images/RStudio_001.png" alt="Uma visão geral do RStudio"/></td></tr>
</table>
<p></p>


Vamos tratar, ainda que superficialmente, de algumas funcionalidades do RStudio. 

#### 1. Editor de Código
No editor de código, você poderá escrever e editar os scripts. [Script](https://pt.wikipedia.org/wiki/Linguagem_de_script) nada mais é do que um conjunto de comandos que serão executados em sequência. O editor do RStudio oferece facilidades como indentação, _code complete_, destaque da sintaxe, etc. 

#### 2. Console
No console aparecerão os resultados dos comandos. Você também pode escrever no console e obter os resultados, sem uso do editor de código. Também pode-se chamar a ajuda diretamente pelo console. Por exemplo: `?lm`. Voltaremos a falar desse comando `?` mais pra frente.

#### 3. _Workspace_ e _History_
No _Workspace_ ficarão guardados todos os objetos que forem criados na sessão. Entenda sessão como o espaço de tempo entre o momento em que você inicia o R e o momento que finaliza. Nesse período tudo que você faz usa memória RAM e o processador do computador. E na aba _History_, como você deve imaginar, o RStudio cria um histórico de comandos. 

#### 4. _Files_, _Plots_, _Packages_, _Help_ e _Viewer_.
Nessa janela, estão várias funcionalidades do RStudio. Na aba _Files_, você terá uma navegação de arquivos do seu computador. Também será possível definir o diretório de trabalho (você também pode definir diretamente no código, mas isto será tratado posteriormente), ou seja, o R  entende o seu diretório de trabalho como ponto de partida para localizar arquivos que sejam chamados no script.

A aba _Plots_ trará os gráficos gerados, possibilitando a exportação para alguns formatos diferentes, como png e pdf.  

Em _Packages_, estão listados os pacotes que estão instalados e você pode verificar quais estão carregados e, caso necessário, poderá carregar algum pacote necessário para a sua análise. Também é possível instalar e atualizar pacotes. Novamente, tudo isso é possível fazer diretamente no código.

_Help_ o nome já diz tudo. Essa aba será bastante utilizada por você. Saber usar o _help_ é fundamental para evitar desperdiço de tempo. Os usuários de R, em geral, são bastante solícitos. Entretanto, uma olhadinha rápida no help pode evitar que você gaste "créditos" desnecessariamente. 

Por fim, o _Viewer_. Essa funcionalidade é utilizada para visualizar localmente conteúdo web. O gráfico da figura está na aba _Viewer_ porque é uma visualização em [javascript](https://pt.wikipedia.org/wiki/JavaScript), que pode ser adicionada a documentos htmls gerados usando o [RMarkdown](http://rmarkdown.rstudio.com/) ou em aplicações web com suporte do [Shiny](http://shiny.rstudio.com/).


Bem, isso foi uma breve explicação. Se você quiser saber mais, esta [_cheat sheet_](http://www.rstudio.com/wp-content/uploads/2016/01/rstudio-IDE-cheatsheet.pdf) criada pelo time do RStudio é muito útil.
	

## Instalando o R e o RStudio

### Windows

Para instalar o R no windows basta realizar o download do executável [aqui](https://cran.r-project.org/bin/windows/base/) e proceder a instalação como qualquer outro software. 

O Rstudio pode ser baixado [neste link](https://www.rstudio.com/products/rstudio/download/). Novamente, a instalação deve ser tranquila, sem a necessidade de maiores detalhes.

### Ubuntu

No ubuntu, você pode instalar o R via terminal ou pela central de programas.

Pelo terminal, tecle `ctrl + alt + T` e faça o seguinte:

```
sudo apt-get update
sudo apt-get install r-base
```

Na central de aplicativos, basta buscar por `r-base`.

O RStudio pode ser baixado no mesmo [link](https://www.rstudio.com/products/rstudio/download/) citado quando foi explicada a instalação no windows.

### Mac OS X

Para instalar o R no Mac basta realizar o download da última versão do pacote (pkg) [aqui](https://cran.rstudio.com/bin/macosx/), de um duplo click e proceda com a instalação como qualquer outro pacote no Mac. 

O Rstudio pode ser baixado [neste link](https://www.rstudio.com/products/rstudio/download/). Procure na lista o instalador para Mac Os. Dessa vez será um arquivo DMG. De um duplo click e arraste o ícone do Rstudio para a pasta Aplicações. Pronto!


### Buscando Ajuda

Esta parte é fundamental. Independente do seu nível de conhecimento, sempre haverá a necessidade de buscar ajuda. A nossa experiência diz que é muito difícil você ficar sem uma solução. No entanto, saber procurar é fundamental tanto para você encontrar uma solução desejável quanto para economizar tempo. 

Entre, as fontes de ajuda estão o próprio _help_ do R, o bom e velho google para uma busca mais ampla, o [stack overflow](http://stackoverflow.com/tags/r) (ou [em português](http://pt.stackoverflow.com/questions/tagged/r)), o [reddit](https://www.reddit.com/r/rprogramming) e, é claro, o **full join**. Estaremos aqui para te ajudar.

Se você puder, faça suas pesquisas em inglês. Isto porque as possibilidades de você encontrar alguém que teve uma mesma dúvida crescem consideravalmente. 

Se você for realizar uma pergunta em algum fórum ou site de perguntas e respostas, é importante atentar para alguns pontos que deverão ser informados:

* Versão do R;
* Sistema Operacional;
* Forneça um exemplo replicável;
* Veja se a sua dúvida já não foi abordada em outro tópico.

Bom, por enquanto é isso! Nos próximos posts, iremos abordar partes específicas e iniciar a utilização de fato do R. Até lá!


