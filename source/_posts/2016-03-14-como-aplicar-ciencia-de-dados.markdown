---
layout: post

title: "Aplicando ciência de dados - parte 1: Workflow"
date: 2016-03-14 00:11:56 -0300
comments: true
categories: [conceito, workflow, equipe]
published: true
---

No geral, atividades envolvendo aplicação da ciência de dados assumem o formato de projeto: empreendimentos de esforços durante um tempo (início e fim), usando recursos (pessoas e ferramentas) para alcançar um objetivo específico.

<!-- More -->


Qualquer projeto precisa ter uma metodologia clara e um workflow mínimo para organizar os recurso, o trabalho e a equipe, aumentando assim as chances de ser concluído com sucesso. 


Nesse sentido, projetos com aplicação de ciência de dados não são diferentes: é muito importante estruturar e organizar o fluxo de trabalho.


Não há "o jeito certo" e "o jeito errado" de se estruturar um projeto em ciência de dados, pois os problemas na prática são tão variados, com características tão diferentes, que fica difícil definir uma única forma de executar o trabalho e obter sucesso no final. 


No entanto, existem modelos baseados em estudos e experiências anteriores que auxiliam bastante na hora de estruturar um projeto desse tipo.


Segundo [votação no KDnuggets (2014)](http://www.kdnuggets.com/polls/2014/analytics-data-mining-data-science-methodology.html) a metodologia [CRISP-DM](https://en.wikipedia.org/wiki/Cross_Industry_Standard_Process_for_Data_Mining) é a mais utilizada para projetos em análise de dados, mineração de dados e ciência de dados. _Cross Industry Standard Process for Data Mining_ é um modelo iterativo e incremental que define 6 grandes fases:


* Entendimento do negócio
* Entendimento dos dados
* Preparação dos dados
* Modelagem
* Avaliação e análise
* Resultados e lançamento do produto


Já o livro [Practical Data Science with R](http://www.amazon.com/Practical-Data-Science-Nina-Zumel/dp/1617291560), define 6 estágios, também iterativos, para o ciclo de vida de um projeto em ciência de dados:


* Definição do objetivo
* Coleta de dados
* Modelagem
* Avaliação e crítica
* Apresentação dos resultados
* Lançamento do produto


Repare que ambas as referências se parecem bastante ao definir as fases de um projeto. 


Ok, então devemos pegar todos essas fases e estágios e delimitar cada momento do projeto? Não necessariamente! 


É importante conhecer essas estruturas e saber o que acontece em cada fase, porém, na prática, todas as fases se sobrepõe em um grande loop com idas e vindas entre cada estágio e, dependendo do problema, uma ou outra fase ganha mais importância ou toma mais tempo. 

Tentaremos fazer um resumo do que é importante ter e mente antes de começar (e durante!) um projeto com aplicação de ciência de dados.


##Tenha perguntas bem definidas


O objetivo de um projeto desse tipo geralmente é responder uma pergunta (ou várias), descobrir ou prever algo, confirmar uma hipótese ou solucionar um problema. 


Se antes de começar o projeto você conseguir resumir seu objetivo em uma pergunta clara e objetiva, você já vai começar muito bem! Se começar o projeto sem uma pergunta clara, então seus objetivos também não serão claros, com isso o projeto correrá sérios riscos de não obter sucesso.


Nesse momento é importante conhecer bem sobre o assunto do projeto. Conversas com os interessados e "donos do problema" são muito bem vindas. Habilidades em [levantamento de requisitos](https://pt.wikipedia.org/wiki/An%C3%A1lise_de_requerimento_de_software) ajudam bastante a elucidar e entender bem o que se espera do projeto e o impacto do problema para o cliente. Entender verdadeiramente o problema é crucial para o sucesso do projeto.


##Obtenha os dados necessários


Esse momento é muito interessante, pois o projeto pode terminar aqui mesmo se não for possível obter os dados necessários. Nem sempre é fácil observar se os dados obtidos são adequados para atingir o objetivo. Eventualmente, somente ao final do processo é possível concluir que os dados foram insuficientes ou inadequados.


Obtenção dos dados também pode ser um momento um pouco traumático, pois nem sempre os dados estão dispostos da melhor forma possível ou nem sempre é fácil obtê-los. 


Por isso essa fase pode exigir alguns conhecimentos mais específicos, como entender de bancos de dados, dominar alguma linguagem de manipulação de dados, conhecer técnicas de limpeza e modelagem de dados, e eventualmente entender de [web scraping](https://en.wikipedia.org/wiki/Web_scraping) ou usar APIs específicas para consumo de dados.


##Explore os dados


Nessa fase é importante começar a investigar os dados em busca de insights, padrões e [outliers](https://en.wikipedia.org/wiki/Outlier), com o objetivo de aprofundar o conhecimento sobre os dados, entendendo melhor como eles se comportam.


Esse exercício muitas vezes exige a habilidade de plotar diferentes gráficos, extrair amostras e realizar análises estatísticas mais básicas.


##Escolha os modelos necessários


A escolha dos modelos é um momento crucial no desenvolvimento do projeto. É aqui que serão utilizados conhecimentos mais robusto em estatística e aprendizado de máquina. É fundamental conhecer as estratégias e os tipos de modelos para escolher bem os que podem ajudar a alcançar o objetivo do projeto.


Outro aspecto importante é saber balancear "complexidade e simplicidade". Como muitas vezes os beneficiários do projeto não serão pessoas especializadas nesse tipo de abordagem, o analista terá uma difícil missão de escolher um modelo que seja útil para o objetivo do projeto, mas que seja também, de certa forma, passível de explicação dos seus principais elementos. 


Por exemplo, em um caso de desenvolvimento de um modelo de classificação, haverá um trade-off entre a melhoria da acurácia e a complexidade do modelo. Ou seja, pode ser que valha a pena escolher um modelo mais simples e mais fácil de explicar do que um modelo super complexo com resultados marginalmente melhores. 


O bom entendimento dos objetivos do projeto e das necessidades do cliente vai repercutir positivamente na escolha correta dos modelos.


##Apresente os resultados


Na apresentação dos resultados, é preciso ter em mente qual é a audiência que você enfrentará, ou que tipo de uso os clientes do projeto farão com o resultado. 

Como na fase de exploração, a visualização pode ter um papel fundamental. Um bom gráfico, pode conseguir passar a mesma informação de dez tabelas diferentes. Ou, dependendo do objetivo, um dashboard dinâmico para o cliente "explorar" os resultados. Em algumas situações, o resultado poderá ser um algoritmo de uso mais amplo (sistema de recomendação, motor de previsões em tempo real, robô que monitora redes sociais, etc).


Outro ponto importante, é sempre deixar claro o que a análise realizada permite e o que ela não permite, apresentando assim os resultados e suas limitações. É fundamental que os clientes tenham o mínimo de conhecimento sobre a capacidade do produto (relatório, dashboard, algoritmo...) que será entregue para que não haja mal entendidos ou frustrações. 


Para apresentar bem os resultados não basta um bom trabalho analítico e bons modelos, é desejável uma boa habilidade de escrita, produzir gráficos interessantes, ["story telling"](https://hbr.org/2013/03/a-data-scientists-real-job-sto/), saber apresentar dados de maneira concisa e objetiva, habilidades interpessoais e, em alguns casos, até uma boa noção de design e interfaces gráficas.


##Faça loops entre as fases


Em qualquer fase e a qualquer momento, é normal que se retorne a fases anteriores ou se avance a fases posteriores. 

Por exemplo: redefinir os objetivos após a fase de exploração; necessidade de se obter mais dados ou explorar melhor os dados após a apresentação dos resultados; repensar os objetivos do projeto após o cliente usar o produto final; etc. Esse exercícios do loop é saudável para o projeto.


Tenha em mente que todas as fases são iterativas, parcialmente sobrepostas e complementares, de forma que, juntas, integram um grande loop de aprimoramento e refinamento até que se obtenha um resultado satisfatório.


Referências:


* [Parte 1 - Capítulo 1 "The data science process" - Practical Data Science with R](http://www.amazon.com/Practical-Data-Science-Nina-Zumel/dp/1617291560)
* [Wikipedia - Cross Industry Standard Process for Data Mining](https://en.wikipedia.org/wiki/)
* [Data Science Workflows – A Reality Check](http://guerrilla-analytics.net/2015/02/20/data-science-workflows-a-reality-check/)
* [Data Science Workflow: Overview and Challenges](http://cacm.acm.org/blogs/blog-cacm/169199-data-science-workflow-overview-and-challenges/fulltext)
