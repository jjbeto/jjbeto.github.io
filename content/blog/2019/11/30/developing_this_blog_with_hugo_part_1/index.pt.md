---
title: 'Setup Completo Para Este Site - Parte 1'
subtitle: 'Crie um site simples e fácil, de graça e em tempo recorde :rocket:'
summary: Crie um site simples e fácil, de graça e em tempo recorde.
slug: setup_completo_para_este_site_parte_1
authors:
- jjbeto
tags:
- Hugo
- Tutorial
date: "2019-11-30T14:00:00Z"
diagram: true
featured: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Placement options: 1 = Full column width, 2 = Out-set, 3 = Screen-width
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  placement: 1
  caption: 'Créditos: [**Hugo Game**](https://en.wikipedia.org/wiki/Hugo_(franchise))'
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---
<aside>
<div class="ox-hugo-toc toc">
<header>
<h2>Índice</h2>
</header>
- [1. Visão Geral](#visao-geral)
- [2. Objetivo](#objetivo)
- [3. Setup](#setup)
- [4. Ok, então.. Aonde estou?](#aonde-estou)
- [5. Primeira Página: Currículo](#curriculo)
- [6. Home Page: Revisão](#homepage-revisao)
- [7. Postando](#postando)
- [8. Publicando](#publicando)
- [9. Conclusão](#conclusao)
</div>
</aside>
<!--endtoc-->

## 1. Visão Geral {#visao-geral}

Eu finalmente decidi fazer um site no estilo Blog 🏆. E não, o [Hugo](https://gohugo.io/) que vamos falar neste post não é o [Hugo Game](https://en.wikipedia.org/wiki/Hugo_(franchise)) 😂

Enfim...  Eu gosto muito de tecnologia, viagens, cervejas e algumas outras coisa, por isso acho que posso compartilhar um pouco do que sei (ou acho que sei) com qualquer um que esteja disposto a ler sobre isso aqui 🤓

Como meu primeiro post, **quero compartilhar minha experiência com [Hugo](https://gohugo.io/)**, vocês poderão encontrar todo o código fonte no meu repositório do [GitHub](https://github.com/jjbeto/jjbeto.github.io/tree/source) (preste atenção na branch 😉).

## 2. Objetivo {#objetivo}

Pra mim fazer um blog não deveria ser algo tão complexo de se criar, e na verdade não é. Para serviços de blogs complexos com várias funcionalidades especiais e que ainda precisam lidar com a carga de prover infraestrutura pra diversos clientes ao mesmo tempo, é obviamente mais complexo de se manter como um projeto.
 
Mas esse não é o meu caso.

O que eu preciso e de um lugar pra por minhas anotaçōes, compartilhar algum conteúdo que possa ser interessante pra outras pessoas e quem sabe iniciar conversas interessantes sobre tecnologia (principalmente, mas não exclusivamente).

Então fiz uma pesquisa e finalmente decidi usar o [Hugo](https://gohugo.io/). Vocês encontrarão vários posts comparando diversos geradores de sites estáticos (pra blogs ou sites de uso geral como o Hugo), mas eu não vou entrar nesse mérito aqui. Se você quer pesquisar mais profundamente sobre esse item, você pode começar por estas comparaçōes interessantes [aqui](https://www.techiediaries.com/jekyll-hugo-hexo/) e [aqui](https://stackshare.io/stackups/hexo-vs-hugo-vs-jekyll) so pra começar (links em inglês).

Então vamos bloggar 🤓

## 3. Setup {#setup}

- Para instalar o Hugo siga as intruçōes [descritas aqui](https://gohugo.io/getting-started/quick-start/) na documentação oficial;
  - Escolhi instalar com `brew` pois uso Mac e é muito fácil;
- Para criar meu projeto inicial eu segui os passos [descritos aqui](https://sourcethemes.com/academic/docs/install/) na documentação oficial do tema Academics;
  - Decidi usar o opção 'Install with Git' (instalar usando Git) apenas para manter os créditos para o repositório oficial através do link no github `forked from` :smile:

Depois de fazer a instalação básica de acordo com a documentação, usei linha de comando bash para ir até o diretório do projeto e executei o seguinte comando:

```
hugo server
```

{{< figure src="1-hugo_serve.png" title="Executando `hugo server` na linha de comando" >}}

Então ao acessar o link [localhost](http://localhost:1313/) é possível ver um site assim:

{{< figure src="2-first-home-view.png" title="Págima Inicial" >}}

Muito bom, agora temos um template completo executando localmente 😬

## 4. Ok, então.. Aonde estou? {#aonde-estou}

Sim! Está vivo! Mas, então.. E agora? Tem um monte de arquivos pra todo lado e várias páginas que na realidade eu nem preciso. Encontrei um artigo interessante falando exatamente sobre isso [aqui](https://andreaczhang.rbind.io/post/my-1st-blogpost/) (inglês) e é um fato, agente se sente um pouco perdido.

Mas ok, primeiro as coisas primeiras: vamos limpar o código e definir o [MVP](https://en.wikipedia.org/wiki/Minimum_viable_product), certo?

### 4.1. config.toml & params.toml

Não há muito o que fazer aqui, apenas a url, informaçōes basicas e dados de contato (também alguma configuração do tema que achar necessário).
A documentação nos próprios arquivos são muito boas e auto explicativas, mas você pode conhecer algumas funcionalidades extras na [documentação do Academic](https://sourcethemes.com/academic/docs/page-builder/).

### 4.2. Páginas Mínimas e Organização de Conteúdo

De acordo com a documentação do [Hugo](https://gohugo.io/content-management/organization/), a organização básica é baseada em diretórios e arquivos, como é possível ver nesse exemplo:

```
.
└── content
    └── about
    |   └── index.md  // <- https://example.com/about/
    ├── posts
    |   ├── firstpost.md   // <- https://example.com/posts/firstpost/
    |   ├── happy
    |   |   └── ness.md  // <- https://example.com/posts/happy/ness/
    |   └── secondpost.md  // <- https://example.com/posts/secondpost/
    └── quote
        ├── first.md       // <- https://example.com/quote/first/
        └── second.md      // <- https://example.com/quote/second/
```

Então decidi tentar trazer algum consenso pra esse `caos` usando um padrão simples: no diretório `posts` vou organizar as postagens usando uma estrutura de data `ano/mês/dia` e por todos os arquivos relativos ao post no mesmo diretório, se eu precisar criar multiplas postagens no mesmo dia eu também posso controlar com um diretório pra reservar o nome do post: `.content/posts/2019/11/30/meu-post-bacana/index.md`. Também vou renomear o diretório `posts` para `blog` (é mais relevante no meu entendimento, também considerando a url). Então o conteúdo do blog será organizado assim:

```
.
└── content
    └── blog
        └── 2019
            └── 11
            |   └── 30
            |       └── developing_this_blog_with_hugo.md // <- https://jjbeto.com/blog/2019/11/30/developing_this_blog_with_hugo/
            └-- 12
                └-- 01
                    └── following_awesome_post.md // <- https://jjbeto.com/blog/2019/12/05/following_awesome_post/

```

Dessa forma é possível agregar todos os conteúdos relacionados em um mesmo lugar, também chegar rapidamente até uma postagem pela data e de repente posso até criar um plugin pra fazer algo mais personalizado no futuro (quem sabe?).

Fora a organização do post, também preciso decidir sobre o conteúdo em geral do site, então inicialmente vou preparar o seguinte:

| Página                                   | Motivação                                                         |
| ---------------------------------------- | ----------------------------------------------------------------- |
| Sobre (página padrão de autores do Hugo) | Currículo mínimo                                                  |
| Currículo                                | É bom ter um online e também já testar algumas funcionalidades 😄 |
| Contato                                  | Er, disponibilizar algumas formas de contato via redes sociais    |
| Página básica do `/blog`                 | Página para agregar a lista de postagens                          |

Depois é só adicionar outras páginas com mais funcionalidades, como:

+ Cursos: para páginas com conteúdo no estilo tutorial como esse aqui 🤔
+ Palestras: para meetups e/ou palestras que eu ache interessante de acompanhar

O plano básico está todo definido. Vamos começar a trabalhar nele :smile:

## 5. Primeira Página: Currículo {#curriculo}

A página padrão do tema Academic tem componentes demais (claro, eles querem exibir o máximo possível de funcionalidades, certo?), e como esse tema é mais voltado à academia/ensino em geral, tem várias ferramentas e páginas muito boas para ajudar a **mostrar minhas habilidades**, mas eu quero uma página inicial mais limpa, com apenas as últimas postagens e uma apresentação simplificada de quem sou eu.

Então vou criar o diretório `resume` (em português será traduzido pra `curriculo` usando uma feature do Hugo chamada `slug`, mas falarei disso em outra postagem - eu acho) e testar como usar as funcionalidades do Hugo lá, transferindo tudo relacionado ao tema da `home` para `resume`. Isso pode limpar a página inicial mas mantendo várias coisas legais. Você pode fazer um fork da última versão do meu currículo [no meu GitHub](https://github.com/jjbeto/jjbeto.github.io/tree/source/content/resume) e atualizar com seus próprios dados e adicionar o diretório no seu próprio site (se utilizar Hugo).

1. Criar o diretório `./content/resume`
2. Criar arquivo `./content/resume/index.md` que define o widget: no meu caso caso é apenas uma página vazia onde adicionarei sessões exatamente como na página inicial

```
---
title: "Currículo"
date: "2019-11-30T12:00:00Z"
type: "widget_page"
---
```

3. Copiar `./content/home/about.md` para `.content/resume/` para funcionar da mesma forma que a página inicial
4. Mover `./content/home/accomplishments.md`, `./content/home/skills.md` e `./content/home/experience.md` para `.content/resume/`
5. Duplicar `./content/resume/accomplishments.md` para `./content/resume/certifications.md` para reusar esta funcionalidade, separando certificações de cursos
6. Preencher todos os dados! Mudar também os dados em `./content/authors/admin/_index.md` (que eu renomeei para `./content/authors/jjbeto/_index.md`) e atualizar as outras páginas em `.content/resume/` com dados customizados já é o suficiente para ter um resultado muito bom

{{< figure src="3-resume-view.png" title="Currículo inicial" >}}

Também usei um pequeno truque de CSS descrito [aqui](https://varya.me/en/posts/pseudo-tag-cloud-css/), assim pude criar uma núvem de tags pra listar as tecnologias que tenho experiência:

{{< figure src="4-cloud-tags.png" title="Núvem de tags" >}}

Como fazer isso? Você pode verificar no [código fonte](https://github.com/jjbeto/jjbeto.github.io/tree/source/content/resume/experience.md), mas pra ser mais fácil vou listar aqui. São necessários apenas 2 itens:

```html
<!-- O HTML para a nuvem -->
<div class="cloud_wrapper">
    <ul class="cloud">
        <li>Item 01</li>
        <li>Item 02</li>
    </ul>
</div>

...

<!-- O CSS para a nuvem -->
<style>
.cloud_wrapper { text-align: center; }
.cloud { display: inline; list-style-type: none; width: 80%; margin: auto; }
.cloud li { list-style: none; display: inline; margin: 2px; }
.cloud li:nth-of-type(3n+1) { font-size: 1.25em; }
.cloud li:nth-of-type(4n+3) { font-size: 1.5em; }
.cloud li:nth-of-type(5n-3) { font-size: 1em; }
</style>
```

Outra coisa que adicionei foi os ícones do [devicons](http://konpa.github.io/devicon/) para poder mostrar imagens da stack que estou utilizando!

Para fazer isso apenas adicionei em `./content/resume/skills.md` a referência do estilo:

```html
<link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
```

Assim posso utilizar ícones dessa forma:

```markdown
[[feature]]
  icon = "apache-plain"
  icon_pack = "devicon"
  name = "Apache"
  description = ""
```

Com certeza existe uma forma melhor de adicionar ícones no Hugo de forma global, assim eu poderia usar esses ícones em qualquer lugar do site, mas não fiz isso por enquanto apenas porque quero usar esses ícones exclusivamente em `./content/resume/skills.md`, logo não preciso obrigar baixar o CSS em qualquer página lida.

Sensacional, né?! Agora podemos brincar com o resto do conteúdo e mudar outros pontos que sejam interessantes e/ou úteis.

## 6. Home Page: Revisão {#homepage-revisao}

Agora que a página do [currículo](/resume/) está pronta, podemos terminar a página inicial:

+ Activate `./content/home/hero.md` para usar como "bem vindo";
+ Desabilitar as seguintes páginas (sem remover pois eu posso precisar dessas páginas em breve):
    + `./content/home/featured.md`;
    + `./content/home/projects.md`;
    + `./content/home/publications.md`;
    + `./content/home/tags.md`;
    + `./content/home/talks.md`;

Eu renomeei o diretório `./content/post` para `./content/blog` anteriormente, logo o widget `./content/home/posts.md` parou de funcionar! Não, na verdade o tipo de itens listados por padrão é `post`, então eu apenas mudei para `blog` (nome do diretório) e tudo voltou a funcionar.

```markdown
[content]
  # Page type to display. E.g. post, talk, or publication.
  page_type = "blog"
```

Outra pequena mudança que eu quiz fazer foi o favicon (aquele ícone que fica no topo do navegador). Para mudar isso primeiro precisei encontrar onde ele estava sendo usado: `./themes/academic/layout/partials/site_head.html` na linha `125`:

```html
<link rel="icon" type="image/png" href="{{ "img/icon-32.png" | relURL }}">
```

O tema Academics tem o seu próprio icone guardado em `./themes/academic/static/img/icon-32.png`, então tudo que eu precisei fazer foi sobreescrever isso com o meu próprio ícone em `.static/img`, adicionando uma imagem PNG com o mesmo nome 🥇

Mas qual ícone usar? 🤔

Decidi não investir muito tempo nisso por agora, então fui nesse [site muito legal](http://fa2png.io/icons/) e gerei um ícone baseado no [Devicons](https://konpa.github.io/devicon/)! Apenas guardei o PNG em `.static/img/icon-32.png` e está pronto!

Ok, página inicial completamente limpa e também uma página de currículo pronta!

## 7. Postando {#postando}

Para criar um post precisamos apenas escrever um monte de coisas legais, ne?

**A resposta é: na verdade não.**

Eu sou meio metódico, nã gosto de ler blogs ou sites que parecem estar sobre carregados de conteúdo misturado e com informação demais em um só lugar.

Por conta disso resolvi pesquisar mais sobre `como organizar meus posts de um jeito que outras pessoas possam entender` e... Não tive muita sorte 😅

Então como uma primeira tentativa, decidi postar como mini-publicações, como um dos meus blogs favoritos relacionados a Java faz ([Baeldung](https://www.baeldung.com/)):

1. Criar uma estrutura básica para um post: 
    - Visão Geral
    - Items
    - Conclusão
2. Usar todas as ferramentas possíveis para mostrar exemplos
3. Disponibilizar um código funcional em um [repositório](https://github.com/jjbeto/jjbeto.github.io/tree/source/) ao final para mostrar um [demo operacional](https://jjbeto.com/)

Como ferramenta extra, vou criar um `Índice` como primeiro item em cada postagem para facilitar a navegaçao.

É possível verificar no [código fonte desta página](https://github.com/jjbeto/jjbeto.github.io/tree/source/content/blog/2019/11/30/developing_this_blog_with_hugo_part_1/index.md), mas vou listar os pontos que me tomaram algum tempinho extra de como fazer:

### 7.1. Anchors e Índine

Não encontrei uma forma fácil/pronta pra criar esse `Índice` no tema do Academics, mas encontrei nesse [post](https://discourse.gohugo.io/t/creating-anchors-in-hugo-pages-solved/9552) um [link bem interessante](https://raw.githubusercontent.com/kaushalmodi/ox-hugo/master/test/site/content/posts/link-to-headings-by-name.md) (em inglês) que me ajudaram a desenvolver uma versão inicial.

Agora o post começa assim:

```html
<aside>
    <div class="ox-hugo-toc toc">
        <header>
            <h2>Índice</h2>
        </header>
        - [1. Visão Geral](#visao-geral)
        - [2. Item](#item)
        - [3. Conclusão](#conclusao)
    </div>
</aside>
<!--endtoc-->
```

Dessa forma é muito simples de acompanhar a postagem em si e o código também. Se algum leitor souber de uma forma melhor (ou mais bonita) de fazer isso, **por favor entre em contato!**

Se você não sabe o que é um `HTML Anchor`, você deveria [pesquisar mais](https://lmgtfy.com/?q=html+anchor) sobre o tema :smile:

### 7.2. Lidando com Imagens

Como um framework guiado por diretórios e arquivos, vou guardar todas as imagens e arquivos necessários para cada post no mesmo diretório. E possível verificar no [código fonte](https://github.com/jjbeto/jjbeto.github.io/tree/source/content/blog/2019/11/30/developing_this_blog_with_hugo_part_1/) dessa postagem, e no final foi incrivelmente fácil de mostrar uma imagem:

```markdown
![This is an image](featured.jpg)
```

O único problema é que dessa forma a imagem e adicionada diretamente no corpo da página de forma estática, e dependendo da imagem se torna dificil ler algum conteúdo ou ver detalhes de forma correta. Entã encontrei uma forma mais interessante [no diretório de exemplos](https://github.com/gcushen/hugo-academic/tree/6d92b0e8ab5512a4489173a560b27adf91c0b260/exampleSite) com formas mais elegantes de exibir imagens usando código Go, para mais detalhes veja a [documentação](https://gohugo.io/content-management/shortcodes/#example-figure-input).

Ah e também é possível referenciar imagens via URL :smile:

## 8. Publicando {#publicando}

{{% alert note %}}
**TL;TR**

Execute o seguinte comando para gerar a versão final do seu site:

```
hugo --gc --minify
```

Dessa forma um diretório `public` será gerado com todo o site estático pronto pra ser publicado, a última coisa que falta para completar é commitar o diretório `public` em um repositório do GitHub com o padrão `<seu usuário github>.github.io`.
 
Isso é tudo, você pode acessar seu site hospedado pelo GitHub Pages em `<seu usuário github>.github.io` e ser feliz ⭐️
{{% /alert %}}

Existe muito conteúdo explicando como fazer o setup de sites usando Hugo no GitHub Pages, por exemplo na própria [documentação do Hugo](https://gohugo.io/hosting-and-deployment/hosting-on-github/).

Mas para ser honesto, acho que isso deve ser feito automaticamente por algum serviço/ferramenta de [CI/CD](https://medium.com/@nirespire/what-is-cicd-concepts-in-continuous-integration-and-deployment-4fe3f6625007). Por ser um pouco mais complexo, vou deixar isso pra um **próximo post**!

## 9. Conclusão {#conclusao}

Esse foi um loooooongo primeiro post, wow! No próximo vou tentar fazer um pouco mais curto (quem sabe).

Hugo é muito útil, tem uma comunidade gigante, ótimos temas e plugins e uma extensa documentação. E obiviamente uma excelente ferramenta pra se usar, muito intuitivo e facil de se acostumar pra usar.

Estou ansioso para usar novas funcionalidades, e **esse post em Português já está marcando uma evolução do site**, pois estou estendendo para gerar conteúdo agora em Português tambem (o site foi pensado inicialmente pra ser somente em inglês),
mas também quero explorar outras funcionalidades como Google Analytics e Comentários com redes sociais! Fique ligado para novidades, onde falarei sobre performance tunning no Hugo, CI/CD (com **GitHub Actions**) e mais.
