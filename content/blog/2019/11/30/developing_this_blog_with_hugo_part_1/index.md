---
title: 'Complete Setup for this Website - Part 1'
subtitle: 'Create a smart and simple website for free in a record time :rocket:'
summary: Create a smart and simple website for free in a record time.
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
  caption: 'Credit: [**Hugo Game**](https://en.wikipedia.org/wiki/Hugo_(franchise))'
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
<h2>Table of Contents</h2>
</header>
- [1. Overview](#overview)
- [2. The Goal](#goal)
- [3. Setup](#setup)
- [4. Ok, so.. Where am I?](#where-am-i)
- [5. First Page: Resume](#resume)
- [6. Home Page: Review](#homepage-review)
- [7. Blogging](#blogging)
- [8. Publish](#publish)
- [9. Conclusion](#conclusion)
</div>
</aside>
<!--endtoc-->

## 1. Overview {#overview}

So I've finally decide to have a blog-like website 🏆. And no, the [Hugo](https://gohugo.io/) that we are going to talk about in this first post is not from [Hugo Game](https://en.wikipedia.org/wiki/Hugo_(franchise)) 😂

Whatever...  I do like tech, travel, beers, and a couple of other stuff, I think that I can share a bit of this experience with anybody that wants to take some time to read about it 🤓

As my first post, **I want to share my personal experience with [Hugo](https://gohugo.io/)**, for this you can find the complete source code on my [GitHub](https://github.com/jjbeto/jjbeto.github.io/tree/source) (pay attention to the branch 😉).

## 2. The Goal {#goal}

For me blogging shouldn't be so complex to setup, and actually it isn't. For complex blog providers which brings a lot of fancy features and also has no manage multiple blogs in the same structure, it's obviously going to be way more complex to maintain the entire application and it's infrastructure.

That's not my case.

What I need is just a place to put my notes, share some content that may be useful and start nice talks about technology (mainly, but not only).

So I did some research and I finally choose [Hugo](https://gohugo.io/). You can find a lot of posts comparing different static website generators (for blog or general purposes like Hugo), but I'm not going too much into it here. If you want to go a bit deeper you can find some nice comparisons [here](https://www.techiediaries.com/jekyll-hugo-hexo/) and [here](https://stackshare.io/stackups/hexo-vs-hugo-vs-jekyll) just to start.

So, let's blog 🤓

## 3. Setup {#setup}

- To install Hugo you can follow [this steps](https://gohugo.io/getting-started/quick-start/) from Hugo docs;
  - I choose to install with `brew`;
- To setup the initial environment I have followed [this steps](https://sourcethemes.com/academic/docs/install/) from Academics docs;
  - I decided to use the 'Install with Git' option just to keep the credits on the original repo via `forked from` mentioning :smile:

After doing the basic installation steps according to Hugo's and Academic's websites, I've entered on the website root folder and ran this command to test locally:

```
hugo server
```

{{< figure src="1-hugo_serve.png" title="Running `hugo server` on command line." >}}

Then accessing [localhost](http://localhost:1313/) you can find something like this:

{{< figure src="2-first-home-view.png" title="Initial home page" >}}

Nice, we have a complete blog-template running locally 😬

## 4. Ok, so.. Where am I? {#where-am-i}

Yes! It's alive! But, then.. Now what? There is dozens of files everywhere and a lot of pages and things that actually I don't need at all. I found a good post about this [here](https://andreaczhang.rbind.io/post/my-1st-blogpost/) and indeed, it's quite overwhelming.

But ok, first things first: let's clean up the code and define the [MVP](https://en.wikipedia.org/wiki/Minimum_viable_product), right?

### 4.1. config.toml & params.toml

Not much to do, just url, mail contacts and basic information (also some minimal theme configuration).
The documentation in the files itself is pretty good and self explanatory, but you can also see extra features on [Academic docs](https://sourcethemes.com/academic/docs/page-builder/).

### 4.2. Minimum Pages and Content Organization

According to [Hugo's docs](https://gohugo.io/content-management/organization/) the base organization is directory/file based, as you can see in their sampe:

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

So I decided to try to bring some sense to this `chaos` using simple pattern: on `posts` folder I'm going to organize the posts using the date structure `year/month/day` and put all related data to that post in this folder, if I want to add multiple posts in the same day I can also controll it using `post-path/index.md` pattern. I'm also going to rename folder `posts` to `blog` (in my sense it is more meaningful, also url-wise). So the blog content will be organized like that:

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

This way it's possible to aggregate related content in one place, track down by date and maybe in the future create some plugin to deal better with the content per directory (who knows?).

Aside of the post organization, I need to decide also about general content, so initially I'm going to prepare the following:

| Page                                 | Motivation                                            |
| ------------------------------------ | ----------------------------------------------------- |
| About (Hugo's default author's page) | `Too Long To Read` resume                             |
| Resume                               | It's good to have it online and also test features 😄 |
| Contact                              | Er, to get in touch via social media                  |
| Posts Root Page `/blog`              | To has a root page for blog posts                     |

Next is to add more featured pages like:

+ Courses: for tutorial-like purposes like this one 🤔
+ Talks: for meetups and/or talks that I find interesting to track

All basic plan is defined. Let's start to work on it :smile:

## 5. First Page: Resume {#resume}

The default Academic's home page is just too crowded (obviously, they want to show off as much features as possible, right?), and as this theme is more related to academic's in general, there is a lot of really good tools/pages to help you to *show yourself*, but I want a cleaner homepage, with only latest news and a quick presentation about myself.

So I decided to create a `resume` folder and see how it looks like to use Academic's features, and also learn a bit of page builder and content organization. This can clean up my home page but maintaining a lot of cool features in the website anyway for who is interested: you can [fork my website's repo on GitHub](https://github.com/jjbeto/jjbeto.github.io/tree/source/content/resume) and update the `resume` folder according to your needs and just add this folder to your Hugo's website.

1. Create folder `./content/resume`
2. Create file `./content/resume/index.md` to define the widget: in my case it's just an empty page where I want to add sections like the homepage does

```
---
title: "Resume"
date: "2019-11-30T12:00:00Z"
type: "widget_page"
---
```

3. Copy `./content/home/about.md` to `.content/resume/` to work as the homepage's ref
4. Move `./content/home/accomplishments.md`, `./content/home/skills.md` and `./content/home/experience.md` to `.content/resume/`
5. Duplicate `./content/resume/accomplishments.md` to `./content/resume/certifications.md` to reuse the feature, separating certificates from on-line courses
6. Fullfil the data! Changing the data on `./content/authors/admin/_index.md` (which I renamed to `./content/authors/jjbeto/_index.md`) and updating the other pages on `.content/resume/` with custom data is enought to have a really nice page already

{{< figure src="3-resume-view.png" title="Resume initial page." >}}

Another small CSS trick is [here](https://varya.me/en/posts/pseudo-tag-cloud-css/): creating a small tag cloud for my experience stack list:

{{< figure src="4-cloud-tags.png" title="Cloud tags." >}}

How to do it here? You can check the [source code](https://github.com/jjbeto/jjbeto.github.io/tree/source/content/resume/experience.md), but to make it easier, you will need 2 things:

```html
<!-- The HTML for the cloud -->
<div class="cloud_wrapper">
    <ul class="cloud">
        <li>Item 01</li>
        <li>Item 02</li>
    </ul>
</div>

...

<!-- The CSS for the cloud -->
<style>
.cloud_wrapper { text-align: center; }
.cloud { display: inline; list-style-type: none; width: 80%; margin: auto; }
.cloud li { list-style: none; display: inline; margin: 2px; }
.cloud li:nth-of-type(3n+1) { font-size: 1.25em; }
.cloud li:nth-of-type(4n+3) { font-size: 1.5em; }
.cloud li:nth-of-type(5n-3) { font-size: 1em; }
</style>
```

Another thing that I want to add is [devicons](http://konpa.github.io/devicon/) to show , so that I can list the tech stack everywhere!

To do so, I've added to `./themes/academic/layout/partials/site_head.html` where all CSS are imported and add:

To do so, I've added to the end of `./content/resume/skills.md` the ref style:

```html
<link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
```

So that I can use the icon this way:

```markdown
[[feature]]
  icon = "apache-plain"
  icon_pack = "devicon"
  name = "Apache"
  description = ""
```

There should be a way to add this style to the root page and reuse it everywhere in the website, but I didn't look into it for now because for now I just want to use it inside `./content/resume/skills.md` (so, no need to download this css elsewhere).

Awesome, right?! Now we can play around with the current page list on the `.content/resume/` folder and change everything that may be useful (and remove pages that don't match with your needs).

## 6. Home Page: Review {#homepage-review}

So with the [resume page](/resume/) settled, we can finish off the home page:

+ Activate `./content/home/hero.md` to use as a first welcome;
+ Disable the following pages (not removing because I may use some of then soon):
    + `./content/home/featured.md`;
    + `./content/home/projects.md`;
    + `./content/home/publications.md`;
    + `./content/home/tags.md`;
    + `./content/home/talks.md`;

I've renamed the base folder `./content/post` to `./content/blog` previously, because of that the homepage widget `./content/home/posts.md` stops to work! No, actually the type of items to list on the default page is marked to be `post`, so I just changed it to `blog` instead (my new folder name) and that's it.

```markdown
[content]
  # Page type to display. E.g. post, talk, or publication.
  page_type = "blog"
```

Another small change that I've done was about the favicon (that small icon set for your page). To change that first I needed to find where it is set: `./themes/academic/layout/partials/site_head.html` at line `125`:

```html
<link rel="icon" type="image/png" href="{{ "img/icon-32.png" | relURL }}">
```

Academics theme has it's own Icon set at `./themes/academic/static/img/icon-32.png`, so everything that I need to do is overwrite this with my own file on my root static folder `.static/img`, adding a PNG with the same name 🥇

But which icon should I use? 🤔

I've decided to not go too much into it for now, so I went to [this cool website](http://fa2png.io/icons/) and generate an icon based on [Devicons](https://konpa.github.io/devicon/)! Just placing the PNG at `.static/img/icon-32.png` is enough!

Ok, completely clean home page and also a nice Resume page is settled!

## 7. Blogging {#blogging}

To create a post we just need to write a lot of cool stuff and post it, right?

**The answer is: no, not really.**

I'm kind of methodic, I don't like to read blogs or sites that looks too flooded with information and mainly: I hate to look at a content and fill confused to follow up. Well I'm sure that I'm not a good writer myself, and English is not my mother language too, so it's kinda complicated to get things done whitout too much mess.

For that I did some research about `how to organize my posts in a way that somebody else can understands it` and... No lucky 😅

So as a first try out, I've decided to post as mini-publications, like one of my favorite Java-related blogs ([Baeldung](https://www.baeldung.com/)) does:

1. Create a base structure for a post: 
    - Overview
    - Items
    - Conclusion
2. Use all possible tools to show examples
3. Give a repository [link](https://github.com/jjbeto/jjbeto.github.io/tree/source/) in the end to show a [running demo](https://jjbeto.com)

As an extra tool, I'm going to create a `Table of Contents` as a fist item in each post to make it easier going around it.

It's possible to check [in the source code of this page](https://github.com/jjbeto/jjbeto.github.io/tree/source/content/blog/2019/11/30/developing_this_blog_with_hugo_part_1/index.md), but I'll list some points that took me a fill extra time to figure it out how to do:

### 7.1. Anchors and Table of Content

I didn't find an easy way to create a Table of Contents for Hugo or Academic Theme, but I've found [in this post](https://discourse.gohugo.io/t/creating-anchors-in-hugo-pages-solved/9552) a [helpful link](https://raw.githubusercontent.com/kaushalmodi/ox-hugo/master/test/site/content/posts/link-to-headings-by-name.md) to make it to work.

Now every post will start with:

```html
<aside>
    <div class="ox-hugo-toc toc">
        <header>
            <h2>Table of Contents</h2>
        </header>
        - [1. Overview](#overview)
        - [2. Item](#item)
        - [3. Conclusion](#conclusion)
    </div>
</aside>
<!--endtoc-->
```

This way is very simple to follow the actual `Table of Contents` in the post and also in the code. If somebody see this post and have other ideas to make it better, **please let me know!**

If you don't know what a `HTML Anchor` is, you should [search more](https://lmgtfy.com/?q=html+anchor) about it :smile:

### 7.2. Handling Images

As a folder-centric framework, I'm going to store related files all together in the same folder. You can check this on this post [source code](https://github.com/jjbeto/jjbeto.github.io/tree/source/content/blog/2019/11/30/developing_this_blog_with_hugo_part_1/)), and by the end it was incredibly easy to show the image:

```markdown
![This is an image](featured.jpg)
```

The only problem is that this way you will have a static image directly on the post body, also depending on the image size you can have problems to see it properly. Then I found interesting [sample folder](https://github.com/gcushen/hugo-academic/tree/6d92b0e8ab5512a4489173a560b27adf91c0b260/exampleSite) with nice image handling, for more about this go to the [documentation](https://gohugo.io/content-management/shortcodes/#example-figure-input).

You can also point to the real url, it's also fine :smile:

## 8. Publish {#publish}

{{% alert note %}}
**TL;TR**

Execute the following command to generate your final website:

```
hugo --gc --minify
```

This way, a folder `public` will be generated with the static site in it, what you need to do is commit/push all the files in a GitHub Repository called `<your github user>.github.io`.
 
That's all, you can already access `<your github user>.github.io` and be happy ⭐️
{{% /alert %}}

There are plenty of content about how to setup Hugo Websites on GitHub Pages, for example on Hugo's [docs](https://gohugo.io/hosting-and-deployment/hosting-on-github/).

But to be honest, I think that it should be done automatically by some [CI/CD](https://medium.com/@nirespire/what-is-cicd-concepts-in-continuous-integration-and-deployment-4fe3f6625007) tool. It's a bit more complex and I'm going to talk more about it in a **next post**!

## 9. Conclusion {#conclusion}

It was a looooong first post, wow! Next time I'll try to be more concise (maybe).

Hugo is very helpful, has a big community, really good themes/plugins and extensive documentation. It's obviously a great tool to use, very intuitive and easy to get used to.

I'm looking forward to use other features, like Google Analytics and Comments integration with social media! Stay tuned for next posts where I'm going to talk about web performance at Hugo, CI/CD (with **GitHub Actions**), Google Analytics, Comments and more.
