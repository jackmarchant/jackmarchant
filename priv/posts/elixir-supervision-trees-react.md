---
title: A Comparison of Elixir Supervision Trees and React Component Trees 
published: true
blurb: Elixir Supervision Trees and React Component Trees - both trees, but do the similarities end there? In this article I compare the pair.
slug: a-comparison-of-elixir-supervision-trees-and-react-component-trees
published_date: 2019-02-06 12:00:00
reading_time: 3
---
A Supervision Tree in [Elixir](https://elixir-lang.org/) has quite a number of parallels to how developers using React think about a component tree. In this article I will attempt to describe parallel concepts between the two - and if you've used React and are interested in functional programming, it might prompt you to take a look at Elixir.

Before we get started you'll need to know that [Supervision Trees](https://elixir-lang.org/getting-started/mix-otp/supervisor-and-application.html#our-first-supervisor) are not necessarily a concept that was born out of the development of the Elixir language, but form part of a concept known as [OTP](https://learnyousomeerlang.com/what-is-otp) (Open Telecom Platform), coined by the creators of the [Erlang](https://www.erlang.org/) language.

Hopefully I haven't lost you yet...take a look at this [picture of an actual tree to refresh](https://americanheritagetrees.org/wp-content/uploads/2016/10/Forest.png), and then come back.

### Isolating Failure
One of the main building blocks in OTP is isolating processes so that they act (and fail) independently. When a new process is spawned in Elixir, it is common to monitor it with a [Supervisor](https://hexdocs.pm/elixir/Supervisor.html), so that if an error happens, the reason can be logged or sent to an error reporting service. The parallel in React, which we can find in the conceptual model of the React component tree is where a (Parent) Component renders one of its children, it can catch the error with `componentDidCatch` and similarly log or send an error report.

### Message/Data Flow
In React Component Trees, the flow of data is one-way, from parent to child(ren). The parent component can also pass functions as props, which would enable the child component to respond back to the parent. The parent can then handle this callback by setting a new state, and consequently, it may re-render its children.
In an Elixir Supervision Tree, a child process can be linked to the parent process, allowing the parent to be sent a message when something happens, for example, when the process finishes what it was doing. A common scenario might be that a process could spawn a [Task](https://hexdocs.pm/elixir/Task.html), which on completion could (depending on how it is spawned) send a message back to the parent process for it to be handled appropriately.

### Guaruntees with a Tree structure
A tree structure makes sense when we think about UI, so that we can predictably control the way in which data flows through an application, allowing us to make certain guaruntees about our components. You might have heard of this being described as React being "easy to reason about".

Elixir Supervision Trees also utilise the tree structure to make guaruntees around availability and isolation - key concepts as part of OTP. A supervision tree isolates each node and set of nodes so that it can both easily recover when things go wrong (restarting processes - isolation of failure) and to keep the rest of the nodes in the tree unaffected by the system failure. You can think about this like branches in an actual tree - when a branch on a tree dies, it can be cut off and the rest of the tree will attempt to regrow the branch.

Similarly, in a React Component Tree, as I mentioned earlier, errors can be caught with `componentDidCatch` lifecycle method - and one day a [hook](https://reactjs.org/blog/2019/02/06/react-v16.8.0.html#whats-next) - at various points in the tree to stop the whole page from crashing, making the entire page unusable. Instead, only one branch or set of components in the tree won't be able to render correctly, or shows an error state, but it keeps the rest of the application working as if nothing happened.

If you still have no idea why you would use a Supervision Tree in ELixir or how it could possibly relate to a UI library - I'm sorry, that's all I've got.
