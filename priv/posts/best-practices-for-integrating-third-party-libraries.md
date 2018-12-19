---
title: Best practices for integrating with third-party libraries in Elixir 
published: true
blurb:  In this article, I will discuss a typical scenario of integrating with a third-party API and detail a potential approach you could use in your Elixir application.
slug: integrating-third-party-libraries-in-elixir
published_date: 2018-12-19 18:00:00
---
When we think about what an application does, it's typical to think of how it behaves in context of its dependencies. For example, we could say a ficticious application sync's data with a third-party CRM.
The way we think about our application impacts how we make abstractions in our code. If we think about a typical web application, we might have a database, router, controllers and some business logic around how we use our data and show it on the page. In many cases, we need to integrate our app with external API's, third-party libraries and more. 
It's critical for most web applications to abstract concepts to make the code both easier to read and change in the future.
In many other languages, we often see [interfaces](https://en.wikipedia.org/wiki/Interface_(computing)) coupled with [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) in use to achieve these goals. In Elixir, the "best practice" approach isn't always as clear.

In this article, I will discuss a typical scenario of integrating with a third-party API and detail a potential approach you could use on your next project.

When we start writing an integration with a third-party, we should think about how the rest of the application will use it and how it should behave in certain circumstances. Our goal should be that we can have a single internal module whose responsibility is to interface with the external dependency.

In most cases, you shouldn't need to write any more code when requirements change - you might have to add extra functionality, but your business logic (the code using the internal module) shouldn't have to change too dramatically just because you moved from "Pretty Good CRM" to "Greatest CRM Ever".
That being said, I don't really subscribe to the idea that your code is ever going to be perfect and that you'll have a perfect abstraction around your CRM of choice, such that you could even swap modules at runtime and be able to use both simultaneously. However, I would expect that it's not going to be a particularly painful piece of work that involves rewriting any of your own business logic.

To help achieve a loose-coupling in our system, we can use a [Hexagonal Architecture](https://fideloper.com/hexagonal-architecture), a fancy way of saying our goal is to push all external dependencies to the edges of our application, separating our core business logic from some of the side effects that might be performed. Typically, this is implemented by wrapping external libraries (dependencies) and only using those wrapper modules throughout the rest of your code base. A good rule of thumb would be to only have one module that represents an external dependency in your code, whether that's an API or a Database.

In Elixir we use this approach already with the Repo module, which maps to an Ecto data store. When we create a module in our app adopting a certain behaviour, we create a wrapper around Ecto's Repo module.
```elixir
defmodule MyApp.Repo do
  use Ecto.Repo,
    otp_app: :my_app,
    adapter: Ecto.Adapters.Postgres
end
``` 
Now, everywhere in our code we use MyApp.Repo rather than using Ecto directly to run SQL commands. There are other reasons we use a Repo in this way, but I find it's a good conceptual model to represent a wrapper module.

### How to go full-hexagonal

Imagine a world where the CRM you chose had a supported library written in Elixir, so you thought you'd use that in your application. It's called ExCRM (just go with it). For us to implement a hexagonal architecture, we would need to push this dependency to the boundary of our application, by creating a single module to wrap the behaviour of the library. Now, whenever we want to push something to our CRM, we need to call this wrapper module, rather than the library directly. In doing so, we only ever reference the library in one place and create a consistent interface with the rest of our application, through the wrapper module.

It might look something like this: 

<script src="https://gist.github.com/jackmarchant/6f2b3b5137caa70098ddcdcd0862b004.js"></script>

At first this looks like a little bit of indirection, and because it's a contrived example it's hard to see the benefits straight away. 

The effect of writing our code in this way is that it limits the blast radius should things change in the library or our own app's requirements. Through limiting the entry-points for the library in your application, we are able to minimize the impact of any such change. While it takes slightly more effort in the beginning to set up, however when business requirements change, you can change your implementation without refactoring lots of different files within your codebase.

Testing your code becomes easier through using this method as you will only need to mock your internal module, rather than the library itself, in all other parts of your codebase.
Isolating dependencies is not a new concept, and in most other programming languages there are clear examples of how to do this, particularly in Object-Oriented languages such as PHP or Ruby.

It's often thought that functional programming and object-oriented programming are at odds with each other and have very different approaches to solving these types of problems, but they actually have a lot of overlapping concepts. Both approaches have the goal of creating maintainable, bug-free applications, sharing concepts but differing in implementation. 

While in Elixir, we think about transforming data from one form to another as opposed to instances of objects that have state, we can still use similar patterns and adapt them for Elixir. There are more parallels than you might think. 
