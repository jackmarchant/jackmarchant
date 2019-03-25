---
title: First Impressions of Elixir
published: true
blurb: I share my thoughts and initial experiences with Elixir, a functional programming language.
slug: first-impressions-of-elixir
published_date: 2017-01-06 10:00:00
reading_time: 5
---

Elixir is a functional programming language based on Erlang. I’m told it’s very similar to Ruby, with a few tweaks and improvements to the developer experience and language syntax.

[Detour – buckle your seatbelts]

I’m drawn to Elixir because of my interest in Functional Programming, generally and specially in JavaScript. I started by learning techniques to make pure functions so that I could more easily test my code. Then, I progressed into learning about composition, currying and partial application in JavaScript, particularly as it was useful to know when using Redux.

[take a breather, that’s a lot of buzz]

…

[enough breathing]

So, then (without mastering any of the above) I decided to try my luck with learning functional programming theory (which is basically just math). That was fun too.

I have twisted and turned through it all, trying to figure out what FP means, and to be honest I’m enjoying it – so why not try to pick up a language that is purely (get it?) functional.

[back to Elixir…/Detour]

Now you know why I’m interested in learning a functional programming language such as Elixir, let’s go on a mythical journey together to see what I’ve learned.

## Learning new things is hard

One of the best things I’ve noticed about Elixir – given at this point in time I’ve used it for about a week – is that it’s incredibly focussed on developer experience.

I think the creator of Elixir (José Valim) must have looked at Erlang and thought we could do better than this. The best people take great ideas and make them easier for other people to learn.

Here’s a few things Elixir does or helps you do as a developer (in list format because who doesn’t like a good list?)

- Built in unit testing (run _‘mix test’_)
- Encourages documentation through making it part of the module distribution
- Interactive Elixir – iex> to allow running code in a terminal
- More approachable syntax than Erlang
- Pattern Matching (what’s that? – keep reading)

That’s plenty of things. What more do you want?

All of this makes it easier for a willing developer to pick up Elixir and give it a go. Nobody wants to be fiddling around with their development environment in a shameful attempt to start learning a new language.

## FP is FP

Functional programming is fucking powerful. It shouldn’t be underestimated. I don’t want to spend any more than 3 seconds walking through my code (and dissecting my brain that day) because I wasn’t bothered to create a function with a clear interface and signature. I am starting to think a function with more than say, 10 lines, is too long and doing too much.

It’s easy to say Elixir is better because it enforces strict rules about what and how you should write your code but I think it would still be possible to write shitty code in any language, just easier in others.

Given that Elixir is an FP language it makes sense that all of the Elixir modules follow its general principles. Taking my early experiences with Elixir into account, I can say I appreciate the strict-ness of the language coming from JavaScript, but there’s also something to be said about the creativity and expressiveness you can have writing functional JavaScript – and there’s plenty of people talking about that now.

It’s interesting that I haven’t seen more people checking out Functional languages after discovering the power of it in JavaScript. Maybe they just haven’t written a kickass article about it?

## WTF? (What the feature?!)

In keeping with Elixir’s functional ties, there’s a feature called Pattern Matching, which I’m very excited to learn more about. I don’t think this is an Elixir-only feature but it’s certainly the first time I have come across it.

The idea (from what I can gather) is that you can define a function as a copy of another function with values in place of parameters and when the value is equal to what is passed in, it will run that function, instead of another further down.

As an example, I had a recursive function that takes a list, but I only want it to run when there are items in the list (otherwise it would get stuck in a recursive loop).

My instinct would have been to use an if statement to check whether there are items and return early – but with Pattern Matching you can say when the first parameter is an empty list, just return early. You have to make sure the pattern matching function is defined before any function you want to override.

This concept separates the two cases into two functions, rather than having one function that handles all cases. As a beginner that is a difficult thing to realise but I’m interested to see whether it improves code readability.

## Where do we go ? (Where do we go now)

Functional programming has been around for ages, but as software engineering on the web matures, developers begin to question how we’ve done things and look for something better.

Elixir sounds like a new challenge to me and has some good things going for it. Now seems like the perfect time for me to pick it up so my goal will be to become more comfortable with it and be able to start a project from scratch and build something myself without a tutorial helping me along.

**TLDR**

- Elixir looks like a fun way to learn more functional programming concepts
- Elixir’s focus on documentation, tests and readable code is what motivates me to learn more about it – and from other reading it seems highly scalable.
- The developer experience seems to have been thought out – making it appealing and easy to get started.
- The package management system, including package distribution seems similar to NPM.

## So far

If you’ve read this far, I congratulate you on your job well done. Take the rest of the day off.

Here are some links to Elixir work I’ve done so far:

- [jackmarchant/misc](https://github.com/jackmarchant/misc)
- [jackmarchant/todo-elixir](https://github.com/jackmarchant/todo-elixir)
- [misc](https://hex.pm/packages/misc)
