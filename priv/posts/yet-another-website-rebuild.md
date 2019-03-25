---
title: Yet another website rebuild
published: true
published_date: 2018-06-25 20:12:00
blurb: Once again, I decided to rebuild my own website. This time, I decided to write about why.
slug: yet-another-website-rebuild
reading_time: 4
---

Rather than getting stuck on an app idea itself, I’ve been in the habit of rebuilding my own personal website [jackmarchant.com](https://www.jackmarchant.com) in different languages, different technologies but for the most part it’s the same outcome. 

Sometimes it gets a bit boring to build the same thing again, but it allows me to focus on the technology I’m trying to learn or become more familiar with. It’s a pretty simple website, I’ve never strayed too far from having a blog, maybe some extra content here and there or fancy front end features. 

I’ve built [jackmarchant.com](https://www.jackmarchant.com) with:
- S3 Bucket serving a single HTML file via Cloudfront
- [Silverstripe CMS and framework](https://github.com/jackmarchant/jackmarchant_com)
- [Ruby on Rails](https://github.com/jackmarchant/website-rails)
- [Node (Express)](https://github.com/jackmarchant/website)
- MeteorJS and React
- [Elixir GraphQL API with React and Relay on the Front-end ](https://github.com/jackmarchant/jackmarchant-react-relay)
- And most recently, a [Phoenix application, the web framework for Elixir](https://github.com/jackmarchant/jackmarchant).

I won’t go into each individually, but looking back on all the different versions, I’ve had a chance to figure out what I liked and didn’t like as both the maintainer and user of these projects, so over the weekend, I decided to go all in with [Phoenix](http://phoenixframework.org) (no JavaScript - yet - is even loaded on the site). 

I put together a few goals this time, which is very rare for me because usually I'd be happy to put something together quickly and get it out there.

## Goals:
- Enable and encourage myself to write more
- Make it easy and blazing fast to publish
- Support markdown to make it easier to cross-post. 
- Enable further engagement between my articles and readers (using something like a subscribe form - spoiler: it IS a subscribe form)
- Build for mobile first. Mobile is where I do a lot of reading, so I appreciate other websites that make that experience great. 

Given the goals I set out, I’ll give you a breakdown of how I built this app:

## Hosting
The majority of these websites were deployed on Heroku, which is good for exactly deploying small apps quickly (and not a whole lot more).

Fortunately, I’ve had lots of practice rebuilding it so it was quite easy to repurpose an existing Heroku application with Elixir and Phoenix build packs, copy over [some config](https://github.com/jackmarchant/jackmarchant/blob/master/elixir_buildpack.config) and make some updates so that Phoenix can connect to a Postgres database. 

## Language/Framework
I created a new Phoenix application, and left a lot of the defaults in place, as I wanted to see what the developer experience is like with Phoenix. Turns out it’s really good, and encourages a lot of good practices, such as built in support for CSRF tokens in form post requests, organising application domain logic, interacting with a database and so on. 

The Phoenix documentation talk a lot about what they recommend in terms of structuring based on [Contexts](https://hexdocs.pm/phoenix/contexts.html), but ultimately it’s still flexible enough for you to do whatever you like. 

I created a simple [Task](https://hexdocs.pm/elixir/Task.html) which would run once when the application starts. This would translate my markdown posts into HTML so they can be presented on the page. 

## Writing markdown
I wanted to get out of my own way when writing, and a way to get my markdown files shown on the page in the simplest way. So this [Task](https://hexdocs.pm/elixir/Task.html) called [PostReader](https://github.com/jackmarchant/jackmarchant/blob/master/lib/jack_marchant/post_reader.ex) scans a folder for markdown files whenever the application starts, read their contents and metadata, before translating it to HTML through an Elixir library called [Earmark](https://github.com/pragdave/earmark/blob/master/README.md).
I then upsert (insert or update) to the database with the HTML and that’s what gets shown on the page. Upserting allows me to make changes to existing markdown files and have it update on the website.

## Front-end
This is perhaps the least amount of time I’ve spent on the front end, as I wanted to basically have enough there that it looked nice enough, but more importantly that the articles were readable and code examples were clearly displayed. 
There is only straight up CSS, organised ever so slightly, and again no JavaScript. 
With code reloading standard in Phoenix, quick changes and updates were a breeze. 
There’s nothing complicated about the front end, although it gave me a chance to use [EEx](https://hexdocs.pm/eex/EEx.html) (Elixir compiled templates) more thoroughly where typically I’d reach for React. 

## Subscribe form
The subscribe form takes an email address and creates a new subscriber record in the database. I will be using Heroku’s data clips to maintain a record of subscribers and as volume increases I may upgrade this to integrate with a third-party email provider. Oh, by the way enter your email address and hit the button and I will grant you three wishes.

## What did I learn this time?
- I should decide on a few high-level goals before starting on a project, otherwise it can feel like you're never really "done". I learn best when I have to try to explain things to someone else, so I find writing is a way for me to do that. So, hopefully I will learn that it's better to spend more time writing and less time rebuilding my website over and over again!
- I learned to appreciate not overcomplicating things and to keep is simple, sultan.
- I learned to focus on what matters most on the web, the user experience.
- I realised I need to find another hobby on the weekend.
