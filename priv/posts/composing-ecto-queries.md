---
title: Composing Ecto Queries
published: true
blurb: Ecto makes composing queries possible through query bindings. Let's take a look at how to compose queries through functions.
slug: composing-ecto-queries
published_date: 2018-07-06 18:00:00
reading_time: 3
---

[Ecto](https://github.com/elixir-ecto/ecto) is an Elixir library, which allows you to define schemas that map to database tables. It's a super light weight [ORM](https://en.wikipedia.org/wiki/Object-relational_mapping), (Object-Relational Mapper) that allows you to define structs to represent data. 

When I was first learning how to use Ecto and Elixir itself, I was amazed by the fact that you can compose queries in the same way you can compose functions. Given Elixir is a functional language in which pipelines play a big part, it's easy to see why it's such a nice way to express queries. 

To start composing Ecto queries, you can import the Ecto.Query module. 
This query will get all albums that have been released: 

```
query = where(MyApp.Album, released: true)
```

This will return an Ecto.Queryable type, which you could pass straight to a Repo (a module that handles connections to the database) using Repo.all(query), or you can add to it: 

```
# using our previously defined query
released_with_length = where(query, [q], q.length > 20)
```

We are able to create a whole new query based on the existing one above. If we now pass this to Repo.all we would get all released albums longer than 20 minutes.
You may have noticed in the first query we started off using the Ecto.Schema we had defined, and in the second example we used the first query. That's because both of these structs implement the queryable protocol, essentially letting Ecto know we can use it to query for data. 

## Queries with joins

With great queries comes great responsibility, fortunately Ecto makes it easy to do joins without breaking a sweat. 
Let's say we also have a songs table, and each record has an album_id to relate it to an album. 
If we wanted to get a list of albums, where the songs in that album are longer than a certain number of seconds, we could do that with the following query:

<script src="https://gist.github.com/jackmarchant/3bb7622f6d4ebfca90364bc589e98b63.js"></script>

There's a few things going on here, but the main part is using a function to join on the songs table and scope the query for albums to return only the ones with songs where they are longer than a certain integer.
This pattern is useful for abstracting lower levels of a query into smaller parts, so you can join them up in a function that has a bit more context. Typically, you might have done this before with functions, but each function call would itself have gone to the database and you'd use an enumerable to filter results.

This type of composition is made possible through Ecto query bindings. These are the references to schemas that have been added to a query, in a list ordered in the same way in which they were added. 
The order matters in query bindings, which can make it difficult to do multiple joins across different functions in the same way we split our query out into functions before.

## Sample application - try it out for yourself
I built a small application to show how this all works together in an application. I would encourage you to clone it and check it out. There's not a lot of resources out there to get started working in Elixir but this application might show you how to get something simple working, while also showing some deeper examples of how powerful composition is in Ecto and Elixir in general.

It has tests as well, so that you can make changes to the queries and run `mix test`, to see if you broke anything.

So here it is: [Composing Ecto Queries on Github](https://github.com/jackmarchant/composing-ecto-queries)
