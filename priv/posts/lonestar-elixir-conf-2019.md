---
title: Lonestar ElixirConf 2019 Highlights 
published: true
blurb: Last weekend was Lonestar ElixirConf 2019. In this article I recap some of my personal highlights and favourite presentations from the conference.
slug: lonestar-elixir-conf-2019-highlights
published_date: 2019-03-04 22:00:00
reading_time: 6
---

Last week was Lonestar ElixirConf 2019 held in Austin, Texas. The conference ran over 2 days and was the first Elixir conference I had been to.

In this article, I will recap some of my personal highlights from the conference, including my thoughts about some of the talks. Before I get into that however, I’d just like to say upfront how great it was to be in a room full of Elixir enthusiasts of all levels of experience. Some people were there to find a way to help sell their organisations on Elixir, and others had helpful insights into running Elixir in production. The conference was really well organised and the schedule allowed for plenty of breaks between all of the awesome talks.

### Nerves
Opening the conference was a keynote delivered by Justin Schneck, author of [Nerves Project](https://nerves-project.org/). [Embedded systems](https://embedded-elixir.com) are really taking off in the Elixir community and Justin made it clear to see why, as he showed how easy it was to get started with Nerves, and how to use [NervesHub](https://www.nerves-hub.org), which is a tool that allows you to manage firmware updates to physical devices, making deployments easy and secure.

While I haven’t done any work with Nerves yet it did make me interested to find a side project I could work on to give it a try.

Most of my work at [Vamp](https://vamp.me) is on the web so it’s unlikely there will be a need for embedded systems, but it speaks to the flexibility and uniqueness of Elixir that something like Nerves can allow anyone to get started working with real devices.

### Distributed State Management
A hot topic in the Elixir community revolves around [distributed state management](https://dockyard.com/blog/2018/11/07/the-distributed-state-of-things-new-elixir-library-enhances-development) and common pitfalls, paired with potential solution.

We all know Elixir is great at concurrency and provides a programming model that makes it much simpler to think about but what makes Elixir really shine is when you add extra nodes as the application scales.

This was the subject of the talks from the first morning of the conference with both describing the complexities involved in great detail.

The talks didn’t really offer a specific solution (although they mentioned the likes of [Swarm](https://github.com/bitwalker/swarm) - a distributed process registry) but instead referred to trade offs that anyone facing these problems will have to make, most notably [CAP theorem](https://en.wikipedia.org/wiki/CAP_theorem) and the balancing scale of Consistency and Availability, given that there will always be a Network Partition in a distributed system.

I really enjoyed this section, so it was a great start to the conference.

### Ecto
With the recent [split of the Ecto library into two parts](http://blog.plataformatec.com.br/2018/10/a-sneak-peek-at-ecto-3-0-breaking-changes): `ecto`, and `ecto_sql` in an effort to make it more visible to developers that Ecto can be used without a database, it was only fitting that there would be a few talks about Ecto. I particularly enjoyed Greg Vaughn's "Ecto without a DB", in which Greg presented  practical examples of using [Ecto Changesets](https://hexdocs.pm/ecto/Ecto.Changeset.html) to validate external data, mapping to structs and applying certain actions to achieve the same validation you would expect with [Repo](https://hexdocs.pm/ecto/Ecto.Repo.html) callbacks such as `insert/1` and `update/1`.

Generally, this approach seemed to highlight the fact that having data structures in your application instead of ad-hoc maps in domain logic makes handling errors easier and prevents messy code.

### The Business Case for Elixir
Brian Cardarella (CEO of Dockyard) presented his views on the business case for Elixir, specifically referring to 4 main points (paraphrasing):

- **Stability:** The stable releases in Elixir coupled with the plans not to release a 2.0 version of the language any time soon, means that developers can have confidence that code they write today will be able to stand the test of time.
- **Efficiency:** Developer productivity with a language is very important, especially for start ups who need to get to market with new features quickly. Elixir’s low cognitive load when working with modules (groups of functions) means parts of the system can be changed more easily than in other languages where you might need a more wholistic understanding of the application’s code base.
- **Scalability:** Elixir is known for its ability to scale with minimal effort, at minimum cost. This makes it a very attractive solution for smaller teams.
- **Tractability:** Elixir’s popularity is on the rise and Brian expects that by 2020 we’ll be seeing many more companies using Elixir in production.
Overall, Brian equipped those who want to bring Elixir into their own organisations with the right talking points to get the job done.

### Phoenix LiveView
Although it had [already been announced](https://dockyard.com/blog/2018/12/12/phoenix-liveview-interactive-real-time-apps-no-need-to-write-javascript) (but not released yet), Phoenix LiveView was presented to the audience at Lonestar ElixirConf with a promise from Chris McCord to be released as early as the end of the month but at least in the coming months.

Chris spoke about the motivations for building LiveView and stressed the goal of delaying the inevitable single page application path for as long as possible. How long that is will be determined after release when people have had time to use it.

I am personally quite optimistic about it and although I'm happy to keep writing JavaScript on the frontend whenever I need to, it will make building prototype apps to showcase Elixir's real-time capabilities much easier.

The conceptual programming model for LiveView is very similar to that of [React](https://reactjs.org) and other JavaScript libraries, in that each component has a parent-child relationship, with the default behaviour that if a child component fails, it can be restarted back to its last known state. It is in this way they behave like children in a supervision tree. The similarities between frontend view libraries like React and Elixir/Erlang supervision Trees is a [topic I have written about before](https://www.jackmarchant.com/articles/a-comparison-of-elixir-supervision-trees-and-react-component-trees).

### Erlang Ecosystem Foundation
In Jose Valim’s keynote, which capped off the presentations for the conference, he introduced the [EEF](https://erlef.org) (Erlang Ecosystem Foundation) as a new organisation run for the community of Elixir and Erlang (and any other languages running on the BEAM (the virtual machine on which Erlang runs). It’s goal is to procure funding for projects within the community to help improve the tooling that surrounds Erlang.

### Broadway
Jose also presented [Broadway](http://blog.plataformatec.com.br/2019/02/announcing-broadway), a new library that was released only a week ago. Broadway is an extension of GenStage, which models producers and consumers as stages in a pipeline that ingests and processes data.

The new library is meant to allow for distributed pipelines to operate in parallel.

Rather than adding these features into the Elixir language, the core team prefers to keep the standard API small and closely matching with Erlang.

### Wrapping up

It’s an exciting time to be an Elixir developer as the language has definitely matured over the years without making any drastic changes. In the years to come I hope there will be more success stories from companies using Elixir along with promoting the success coming from developer productivity and happiness building Elixir applications and scaling them.

Lonestar ElixirConf 2019 seemed to be very successful and I certainly enjoyed being there.

I would like to thank [Vamp](https://vamp.me) for sponsoring me to make the journey from Australia and hope to see more Australian companies take part in the global Elixir community.
