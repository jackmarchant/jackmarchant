---
title: A Queue is just a Q with 4 silent letters
published: true
blurb: How to implement a Queue in Elixir
slug: implement-a-queue-in-elixir
published_date: 2018-06-09 20:08:00
---

A Queue is a collection data structure, which uses the FIFO (First In, First Out) method. This means that when you add items to a queue, often called enqueuing, the item takes its place at the end of the queue. When you dequeue an item, we remove the item from the front of the queue. 

Both of these methods will change the length of the queue. A peek method can be implemented to look at what the first item is in the queue, without removing the item, leaving the queue unchanged.

Queues are often implemented with list data structures, such as a Linked List. In Elixir, lists are singly-linked lists under the hood. We’re able to access the head and tail of a list, which refer to the first item in the list and the rest of the list, respectively.

```elixir
[head | tail] = [1, 2, 3]
> head
1
> tail
[2, 3]
```
If you think about implementing a queue in Elixir, we would need to implement the following methods:

- Enqueue
- Dequeue
- Peek
- Count
Let’s look at each of these individually.

## Enqueue
When adding an item to a list in Elixir, it’s common to prepend to the list, then reverse it when accessing it to preserve order. As lists are singly-linked in Elixir, it is much faster to add to the front of the list, rather than adding to the end and having to re-create all of the links in the list.

For this reason, you could implement an enqueue function in this way:
```elixir
@spec enqueue(list(), any()) :: list()
def enqueue(queue, item) do
  [item | queue]
end
```

## Dequeue
Now that we have items in a list, we need a way to remove one when we call dequeue. I started having a look at how Elixir deletes items from a list and found [List.delete/2](https://github.com/elixir-lang/elixir/blob/v1.6.5/lib/elixir/lib/list.ex#L123) — we can see a few function heads there, but here are the two lines you need to appreciate:

```elixir
def delete([item | list], item), do: list  
def delete([other | list], item), do: [other | delete(list, item)]
```

The first argument is the list, and the second argument is the item to be removed. Elixir binds the second argument name as the same value as the head of the list, and if this function is called, it returns the tail (thus removing the item from the list). Otherwise, if the two item variables are not a match, the head is prepended and `delete/2` is recursively called on the tail.

That might be a bit to take in, but I recommend trying it out in an interactive Elixir shell `iex`.

Although we don't need `List.delete/2` in this case, we can implement a dequeue function like so:

```elixir
@spec dequeue(list()) :: {any(), list()}
def dequeue([]), do: nil
def dequeue(queue) when length(queue) <= 2 do
 [item | tail] = Enum.reverse(queue)
 {item, tail}
end
def dequeue(queue) do 
 {Enum.at(queue, -1), Enum.drop(queue, -1)}
end
```
We return a tuple in this function, because we want to know both the item that was dequeued, and the remaining items in the queue (so we can enqueue more items later). It’s worth noting as well that this is not the most efficient solution, as it is using an `O(n)` algorithm because the `Enum` methods we’re using are always going to enumerate of the list to get the last item.

## Peek
A peek function is simply a utility to allow looking at the front of the queue, without changing the queue itself. Although, you might want to add some extra function heads to cater for empty lists.

```elixir
@spec peek(list()) :: any() | nil
def peek([]), do: nil
def peek(queue) do
  [h | _ ] = queue
  h
end
```

## Count
Similarly, count is the number of items still in the queue, and can be implemented as such:

```elixir
@spec count(list()) :: integer()
def count([]), do: 0
def count(queue), do: length(queue)
```

These functions are all fine in theory, but when we start to think about implementing a queue in Elixir, we can’t wrap this up in a class that knows about it’s own state. Instead, we could implement these functions as part of a GenServer, which will hold it’s own state and can be updated over time.

## Priority Queue
When simple FIFO doesn’t cut it and you need to be able to process items in a queue before others we can implement a Priority Queue. This means that when an item is enqueued, it doesn’t necessarily go to the back of the queue (or front of the list in Elixir), each new item needs to be compared with other items until we find a suitable place for it based on its priority.

Priority could mean integer values, for example the number 10 would have a higher priority than 5, because it is the higher value. Imagine the following queue:

```
head -> 7 - 3 - 1 <- tail
```

If we base priority on the higher integer values, and we add 10 to this queue, we would expect it to take priority over all other values because it is highest. So we’re left with the following queue:

```
head -> 10 - 7 - 3 - 1 <- tail
```

If the priority of the new item was not higher than any of the existing items, it would simply be added to the end of the queue.

Queue’s have a variety of real-world applications, such as scheduling asynchronous work or handling large amounts of requests. High priority requests can be processed first, and lower priority processed later.

I decided to implement a simple [Queue library](https://hex.pm/packages/pex_queue) using a `GenServer`, and optional priority, you can take a look at the [documentation](https://hex.pm/packages/pex_queue) or go straight to [the code](https://github.com/jackmarchant/pex_queue/blob/master/lib/pexqueue.ex)

