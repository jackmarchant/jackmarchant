---
title: You might not need a GenServer
published: true
blurb: It can be confusing sometimes, to know when to use a GenServer. There are a couple of modules, including Task and Agent that may fit your purpose better.
slug: you-might-not-need-a-genserver
published_date: 2018-11-20 18:00:00
---

When you're browsing your way through Elixir documentation or reading blog posts (like this one), there's no doubt you'll come across a GenServer. It is perhaps one of the most overused modules in the Elixir standard library, simply because it's a good teaching tool for abstractions around processes. It can be confusing though, to know when to reach for your friendly, neighbourhood GenServer.

A GenServer is a generic implementation of typical client <-> server interactions, where the client is a process and the server is your GenServer. This abstraction exists because without it we would have to write a lot more boilerplate code around receiving messages from other processes.

I have grown fond of GenServer's, along with the Elixir community, however there are some circumstances in which you might not need a GenServer.

Let's take a quick look at the differences between a [Task](https://hexdocs.pm/elixir/Task.html) and a [GenServer](https://hexdocs.pm/elixir/GenServer.html) and figure out which module fits best.

### Task
Tasks are a simple, yet powerful tool to change the way your code is executed and introduce somme light concurrency.

You can run a function asynchronously, isolating any failures:
```elixir
Task.async(fn -> raise "the roof" end)
```
This line has a couple of advantages:
- The Task will run in a new process, leaving you free to do all of those other things you wanted to get done.
- Any failure or error raised in the course of running the function, will be isolated to the task's process, so your main process will not stop executing any code after the task.

In contrast to this, we can wait for the result, at some point in the future:
```elixir
task = Task.async(&my_function/1)
# .. some other code
result = Task.await(task)
``` 
By using a Task in this way, we can defer the retrieval of the result and execute some other code in the mean time. Once you've extracted the result, the process will exit.

A Task will only execute one function in it's lifetime and isn't meant to be a long-running process, or be involved in any inter-process communication. The benefit of this is that it's much easier to write for one-off tasks and simpler to test. In most scenarios where you only want to run a function asynchronously, a task will suffice.

### Agent
An [Agent](https://hexdocs.pm/elixir/Agent.html) is a process that abstracts state. If all you need is something to hold a value for a relatively short period of time (in memory), an agent is a perfect option. An Agent is actually a GenServer that has been abstracted into it's own module. So, while you get all the benefits of using a GenServer

If we want to hold a value in an agent, you can store it using `Agent.get/3` and store values using `Agent.update/3`. These functions are already defined for you in the Agent API - functions you would have to define yourself, had you chosen to implement the same functionality with a GenServer.

```elixir
{:ok, pid} = Agent.start(fn -> "hello" end)
Agent.get(pid, fn state -> state end)
"hello"

Agent.update(pid, fn state -> state <> " world" end)
Agent.get(pid, fn state -> state end)
"hello world"
```

A timeout is included as the third argument to each of these functions, because they are synchronous and so the caller must wait for the function passed as the second argument to finish executing. If we want to run a function using the state in an Agent, we need to use `Agent.cast/2`, which works in a similar way to `GenServer.cast/3`.

```elixir
{:ok, pid} = Agent.start(fn -> "hello" end)
Agent.cast(pid, fn _ -> "world" end)
:ok
Agent.get(pid, fn state -> state end)
"world"
```

### Final thoughts
As you can see it has almost all of the typical functions you'd see in a GenServer, however you don't need to worry about the process to process communication. You can simply focus on building the functionality of your application.
The rise in Elixir's popularity is partly due to the fact that you can use abstractions around common problems while building your application, and only when you need the fine grained control, the underlying module is there for you to use, and this is especially the case for a GenServer.

There are of course much more complicated problems a GenServer is quite adept at solving than anything I've written here, but the point was not to illustrate how complicated you can make an application, but rather how quickly you can get started with some simpler alternatives, and only use a GenServer when you absolutely need it.

