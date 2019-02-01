---
title: Using a GenServer to handle asynchronous and concurrent tasks 
published: true
blurb: Inter-process communication can be tricky to get your head around. This article discusses an example of how it can be used to solve a real problem. 
slug: using-a-genserver-to-handle-asynchronous-concurrent-tasks
published_date: 2019-02-01 18:00:00
---

In most cases I have found inter-process communication to be an unnecessary overhead for the work I have been doing. Although Elixir is known for this (along with Erlang), it really depends on what you’re trying to achieve and processes shouldn’t be spawned just for the fun of it. I have recently come across a scenario where I thought having a separate process be responsible for performing concurrent and asynchronous jobs would be the best way to approach the problem. In this article I will explain the problem and the solution. 

### Requirements

The goal of this work was to asynchronously handle requests to move static assets from one provider to another. This means downloading the original to a temporary file on the server, then uploading it to the new provider and saving results in a database. 

- A GraphQL mutation needs to trigger this asynchronous job and not block the response. 
- When the job completes, either successfully or with a failure, we should report it or handle it in some way. 
- Multiple requests will come through concurrently, meaning the process shouldn’t be blocked from handling another request because one is still running. 
- A request may trigger one or many jobs

### The process of finding a solution

There are many different options for structuring your Elixir applications in terms of the supervision tree - when and where to spawn processes and which type of process suits your use case is often a guessing game until you’ve used them all before extensively. 

My first thought was to use a [DynamicSupervisor](https://hexdocs.pm/elixir/DynamicSupervisor.html) (i.e [Task.Supervisor](https://hexdocs.pm/elixir/Task.Supervisor.html)) and specifically create new supervised processes when the work needed to be done, and on demand.

This didn’t really work how I thought it would because the main process would still block until all the tasks were finished before responding to the initial request. 

The next solution I tried was to send messages to a [GenServer](https://hexdocs.pm/elixir/GenServer.html), and have it do the work so that the main process could return a response almost immediately. While this got most of the way to solving the problem, a common problem found with using GenServers is that they can only handle one message at a time, so while this solution provides the asynchronous behaviour, it loses the benefit of concurrency. 

The solution that (seems to work so far) I ended up going with wasn’t too far away from the Genserver solution. The only difference being when we schedule a job to be done, it only spawns a [Task](https://hexdocs.pm/elixir/Task.html) with [Task.async/1](https://hexdocs.pm/elixir/Task.html#async/1), the benefit of which is that it will always send a message back to the caller when it’s finished even if you don’t use [Task.await/2](https://hexdocs.pm/elixir/Task.html#await/2). 

As it is a GenServer that is spawning these tasks, it can handle generic messages sent to it quite easily with the [handle_info/2](https://hexdocs.pm/elixir/GenServer.html#c:handle_info/2) callback. This is where the GenServer handles success or failure states of each task, and processing each result synchronously is not a problem in this case. 

Here's a snippet of the GenServer that spawns these Task processes.
<script src="https://gist.github.com/jackmarchant/e28cb2ed3767c8b5041fa5d37fe1d1fa.js"></script>

What's interesting about this code is that it may actually be reimplementing something that already exists in Elixir, that I haven't quite got my head around yet - either way I haven't got a problem with doing it this way as long as it works! Wrapping the spawning of a Task in a GenServer simply provides the ability to "schedule" tasks (as each message is processed sequentially), while responding to the response from each task invidiually.

In theory if we were to send a bunch of messages that get "queued" for processing in the GenServer's mailbox, a problem may arise where if the application terminates, the GenServer will lose all of it's messages and those tasks will be lost. At this point, however, I would prefer to see how much of a problem this turns out to be as there would be various factors to consider.

I’m still not sure if this is going to be the best way to architect this asynchronous, concurrent behaviour, but in the few cases where I’ve thought an OTP approach makes sense I have often found many different ways to solve this kind of problem - which is both a good and bad part of Elixir.
