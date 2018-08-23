---
title: Add Docker to Elixir/Phoenix projects in one command
published: true
blurb: A simple way to add basic docker files to your new or existing Docker projects.
slug: add-docker-to-elixir-phoenix-projects
published_date: 2018-08-23 20:08:00
---

Recently, I've been writing a tonne of Elixir code, some Phoenix websites and a few other small Elixir applications. One thing that was bugging me every time I would create a new project is that I would want to add Docker to it either straight away because I knew there would be a dependency on Redis or Postgres etc, or halfway through a project and it would really slow down the speed at which I could hack something together.

One of the things that I love about Elixir is how quickly you can get started writing an application, whether it's a web app or it's got supervision trees coming out of its ears.
In any case, I found myself going back to old projects where I had used Docker, copying over a few necessary files to get started, with the workflow that I was used to.

## exdocker
So I decided to try to fix this problem in an Elixir CLI application (Escript). It really doesn't do much, it writes some files and does some string replacements to make setting up docker easy.
I called it [exdocker](https://github.com/jackmarchant/ex_docker) because I'm not as creative as I used to be.

### Installation
Make sure `~/.mix/escripts` is in your machine's `$PATH`. You can do this by adding `export PATH=~/.mix/escripts:$PATH` to your `.bashrc` or similar file.
1. `mix escript.install hex ex_docker`
2. `source ~/.bashrc` - load the escript and `$PATH` update

### Usage
- Create a new Elixir project
  `mix phx.new my_project`
  `exdocker my_project`
- Add to an existing Elixir project
  `exdocker my_project` or `exdocker .` to run it in your current directory.

Three files get created in the root of your project:
- docker-compose.yml - configuration of your docker containers
- Dockerfile - Specify what needs to be installed for Elixir/Phoenix to run
- Makefile - Convenient targets for docker-compose commands

You can then run make init shell from the root to build and run Docker containers, and when this command finishes, you'll be inside a shell session with Elixir and Mix installed so you can continue development as usual.

Any other time you need to use it, it will be available to execute with `exdocker`.

Be sure to let me know if you found this useful!
