---
title: Understanding concurrency in Elixir
published: true
blurb: Concurrency is one of the major drawcards for pulling people to the Elixir language. In this article I explain how to use concurrency at it's lowest level - with Processes.
slug: understanding-concurrency-in-elixir
published_date: 2018-07-14 09:00:00
reading_time: 4
---

Concurrency in Elixir is a big selling point for the language, but what does it really mean for the code that we write in Elixir? It all comes down to [Processes](https://hexdocs.pm/elixir/Process.html). Thanks to the Erlang Virtual Machine, upon which Elixir is built, we can create process threads that aren't actual processes on your machine, but in the Erlang VM. This means that in an Elixir application we can create thousands of Erlang processes without the application skipping a beat.

One function that enables Elixir developers to create processes is `spawn/1`. [Spawn](https://hexdocs.pm/elixir/Kernel.html#spawn/1) takes a single argument, which can either be an anonymous or named function and will create an isolated context inside a new process for the function to be run. Typically, when we invoke a function it is run in the main process thread with all of the rest of your code. There are two things to be aware of when doing this:
1. When running application code within a single (main) process, if your code fails due to a bug or otherwise, it will stop the rest of the application from responding, and will be in a crashed state.
2. The process thread which is currently running your code, will be blocked until the execution of the function completes. This means that it's blocking other code from running, and is synchronous.

Let's break down each of these points to understand their meaning.

## Let it crash
In Elixir, a common turn of phrase is to "let it crash" - it being the current process - and if you're just coming to Elixir from another language, as most people are, it can be confusing to understand exactly what this means. When we follow the "Let it crash" principle, `it` should always be a separate process so that other parts of the application are unaffected. When we use the [Phoenix Framework](http://phoenixframework.org), each HTTP request is handled in a separate process, created for a single purpose. If your application needed to serve thousands of requests simultaneously, then Phoenix (and by extension [Cowboy](https://github.com/ninenines/cowboy) - an Erlang-based HTTP server) would create thousands of requests, each in complete isolation.
Doing this means you can crash the current process, i.e. a single HTTP request and it would not affect the rest of the application. 

Similarly, if we have an application that is not in a web context, we can create a [supervision tree](https://elixir-lang.org/getting-started/mix-otp/supervisor-and-application.html) to handle any failures. The added benefit of using a supervision tree is that you can also determine a strategy for restarting any child processes based on the purpose of said processes. Structuring an application in this way, means that you can isolate failures, which is the purpose of letting things crash - because if they're not affecting the main process thread, then it can be handled appropriately.

## Asynchronous Elixir
To demonstrate asynchronous elixir, it's important to understand what typically happens with your code when it is executed synchronously. Think about enumerating over a list:

```
Enum.each(1..10, fn n -> IO.puts n end)
```

When this code runs, the process in which it is running is blocked until it is finished enumerating over the list. You can see this more clearly by changing the range `1..10` to `1..10_000_000` and running it inside an `iex` shell. You'll notice that you can't do anything else in that process until it's done enumerating. This is code executing synchronously.

Asynchronous code can be particularly useful if you have large amounts of work that can be done concurrently. To do this in Elixir we can use the `spawn/1` function to create a new process in which to do the work. When application code executes inside of a process, it can run without blocking any code in other processes.
Similar to the previous example, we can enumerate over a list but this time we'll execute the output asynchronously:

<script src="https://gist.github.com/jackmarchant/e44d49c25a5c34c35c463b8a9d515e9b.js"></script>

You'll notice when you run this code the numbers aren't output in order like they were in the synchronous example. This is because each process is started and executes in an independent order to any others. 

This is great when all of your code works perfectly, but in the real world, you will have to expect there to be some failures, so to replicate this real-world scenario, we can raise an exception to illustrate something not executing correctly.

<script src="https://gist.github.com/jackmarchant/5c0ae78ba78a8e411cd6912d0a765988.js"></script>

When this code runs it will raise an exception for all of the even numbers within the `1..10` range. We can see however, for all the odd numbers, the code executes correctly and outputs the number. In a larger context this would mean that failures are not affecting the main process where the application is running, and that any failures within any child processes are also not stopping anything in the main process, so any other code can continue to execute.

In a real world application, you might want to handle any cases where a process does crash, and thankfully there are a few constructs built in to Elixir that abstract away some of the necessary code to send and receive messages that you would need to handle success and failures in processes with `spawn/1`. One such construct is the [Task](https://hexdocs.pm/elixir/Task.html) module, which is perfect for once-off asynchronous tasks, as we were doing earlier. In particular, the `async/1` and `await/2` link the calling process with the new one created in `Task.async/1`. 
There are many other possibilities using Tasks, and I think they're great for getting started working with processes in Elixir.
