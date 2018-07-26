---
title: Working with Tasks
published: true
blurb: Working with Tasks means understanding how to send and receive messages in Elixir. To familiarise myself with this concept, I create a simple (naive) Job module.
slug: working-with-tasks-in-elixir
published_date: 2018-07-26 09:00:00
---

While writing [Understanding Concurrency in Elixir](https://www.jackmarchant.com/articles/understanding-concurrency-in-elixir) I started to grasp processes more than I have before. Working with them more closely has strengthened the concepts in my own mind. 
In Elixir's standard library, there's a few modules that abstract common code that without these modules you'd find youself repeating often.
When you want to write asynchronous code, you may care about the result of the code, and sometimes you might not.
The [Task](https://hexdocs.pm/elixir/Task.html) module makes it easy, either way. 
To better understand how tasks work, I thought I would create a simple (naive) module that would implement a similar API to that of the Task.

## Re-implementing the Task module

Consider the following module, which I'm going to call `Job`.

<script src="https://gist.github.com/jackmarchant/092b5a4f3bdff97d6229b5ddd5e9259b.js"></script>

`Job.async/1` accepts a single function as a parameter, and this is the work that will be carried out asynchronously. You can either run the function, without caring about the result:

```elixir
iex> Job.async(fn -> "Hi" end)
<#PID>
```
It returns a Process Identifier (PID), which is the result of calling `spawn_link/1`, passing in a function which in turn sends a message to the parent process. We've split up the implementation of `async` and `await` so that you can optionalally pass the PID to `await` if you care to wait for a result.

Let's see what that would look like:

```elixir
iex> Job.async(fn -> "Hi" end) |> Job.await()
"Hi"
```

When we pattern match on the job PID to identify the message being received, and the result of the `job`, the value of the result is the result of invoking the function passed to `Job.async/1`.

In this case the result was seen instantly, but if it the initial function was actually performing asynchronous work, then it would wait for a timeout period to elapse before giving up. This is the `after` section of the `await` function.

```elxiir
iex> Job.async(fn -> :timer.sleep(6000); "Hi" end) |> Job.await(5000)
{:error, "no result"}
```

We got an error because the timeout had elapsed, given the timer in the function paused processing until 6 seconds had gone, whereas the `Job.await/2` function gave up waiting after 5 seconds.

## Conclusion
Hopefully the `Job` module helps your understanding of what the `Task` module is doing under the hood, to some degree, it is not the full implementation and there's a whole lot more that come with using tasks, such as process supervision, streaming, and more. That being said, it can be useful to become familiar with passing messages between processes, in any case.