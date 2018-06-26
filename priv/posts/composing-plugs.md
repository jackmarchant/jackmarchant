---
title: Composing Elixir Plugs in a Phoenix application
published: true
blurb: A practical example demonstrating how to use Plugs in Elixir.
slug: composing-elixir-plugs-in-a-phoenix-application
published_date: 2018-03-23 20:08:00
---

Elixir is a functional language, so it’s no surprise that one of the main building blocks of the request-response cycle is the humble Plug. A Plug will take connection struct (see [Plug.Conn](https://hexdocs.pm/plug/Plug.Conn.html)) and return a new struct of the same type. It is this concept that allows you to join multiple plugs together, each with their own transformation on a Conn struct.
A plug can be either a function or a module that implements the Plug behaviour.

## What is a Plug?
Before we get to know Plug, add it as a dependency to your project’s mix.exs file: `{:plug, "~> 1.5"}` and run `mix deps.get` to install it.
A Plug has the following structure:

<script src="https://gist.github.com/jackmarchant/62b91342412191443fc58598748b32f5.js"></script>

In this example, we’re adding a :user map to the current session data. The two main functions are `init/1` and `call/2` both of which are part of the Plug behaviour, defined in `plug.ex`.
`init/1` is used to initialise the plug with options that can be used in the `call/2` function. `call/2` is the meat of the plug, where you take a `%Plug.Conn{}` struct and return a new one.

## How to use a Plug
You can use a Plug in a your application’s router. It might look something like this:

<script src="https://gist.github.com/jackmarchant/504a2f5537dea3d930f2648c62eb7e65.js"></script>

Now, when you visit `/` in your application, it will run `AuthenticateUserSession.call/2` and as we defined earlier, it will add a user map into the session data.

## How to combine multiple Plugs
When building an application, you might need to do more than just adding a user to a session. Rather than extending upon the AuthenticateUserSession plug, you can create a new plug that will do the specific job you need it to. This allows us to compose plugs that are discrete and makes sure we’re following the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle).

With Elixir plugs, we can combine multiple plugs in a `:pipeline` that can group functionality together.

<script src="https://gist.github.com/jackmarchant/18c9dc77b516756d1abfb4bddaf8a9d9.js"></script>

Order is important when using a pipeline, as plugs will be called in the order that they are defined. Now, in MyApp when `/page` is requested, `AuthenticateUserSession.call/2` will be called, which can either return a `%Plug.Conn{}` and let the request continue to the next plug, or it can halt the request and return a different response. When the former happens, the `AuthoriseUserSession.call/2` function will run. Finally, if this plug returns successfully, `MyApp.PageController` will be called and the user can receive a response.

The Plug concept has many applications beyond just the request-reponse cycle. It stands as a metaphor to explain how Elixir applications can be built up with many parts, all performing their job and handing off to the next module.
You can read more about plugs on the [docs of the Plug package](https://hexdocs.pm/plug).