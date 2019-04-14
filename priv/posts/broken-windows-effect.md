---
title: Building Software with Broken Windows 
published: true
blurb: Building software is hard, there's no doubt about it. There are ways we can make it easier to write code in teams with large codebases.
slug: building-software-with-broken-windows
published_date: 2019-04-14 22:00:00
reading_time: 9 
---

Ever get the feeling that adding this "one little hack", a couple of lines of code, won't have much of an impact on the rest of the codebase? You think nothing of it and add it, convincing your team members it was the correct decision to get this new feature over the line. In theory, and generally speaking, I would kind of agree with doing it, but every hack is different so it's hard to paint them all with the same brush. If you've been doing software development for long enough you can see this kind of code coming from a mile away. It's the kind of code that can haunt your dreams if you're not careful.

Back to the point, the code you added that was a little sub-par has introduced the possibility for a second hack to be added without the same reservations or questioning from team-members that you might have had before. A similar decision was made last time so we can let this one slide. You may even go so far as to add a comment detailing the hack, and the reasoning, patting yourself on the back before merging it in.

This kind of attitude can really add up quickly, and without you even realising. I would classify this as the go-to technical debt example - the debt being the block of code you anticipate will need re-writing for one reason or another. Over time, you introduce code like this that isn't performant as it should be or wasn't written in a way that is extensible. Tech debt should be used like a bandage, a temporary fix to stop the bleeding, but left for too long, and it starts to bleed-through.

At some point you will have to repay this debt, and figure out a way to remove the code you or your team has added to get a "quick win". Some are easier and more straight-forward than others. When you're adding code, a good rule-of-thumb could be: "how easily can this be removed?". It is the removal of code that is taken forgranted. We assume code we write will live on for a long time, but in reality things change often, so we need to be able to move code around, delete it, or completely re-write it. Easy deletion of code should be the mark that something was created well, and isn't tangled in between many other files or functions.

To the detriment of the codebase, should hacks add up over time and you find yourself piled on with tech debt, it can make the attitude towards the codebase change. This effect is known in software development as Broken Windows, where seeing something that's already broken or poorly formed devalues your own opinion of it, so you either leave it broken or make matters worse by breaking more windows.

In this metaphor your codebase is a house, and you and your team live in this house. When you add a hack, it's like breaking a window. The first one you might patch up to stop the cold air getting in. Not patching it, however, will open the floodgates for more broken windows. Soon, you'll have three or four in your house. When a door handle inevitably breaks under the pressure of heavy usage, after seeing all of the broken windows, you'll probably just leave the door open and not close it anymore, rather than fixing it or buying a new handle. 

### How did we get here?
When your codebase is an unmaintainable mess, it's bad for business, it's bad for you (you have to keep fixing it) and it can make others in your team quit if it doesn't get better.

It might seem a bit dramatic, to go from a simple hack to all those bad side effects, but it wasn't the hack itself, it was the attitude that ensued as a result.
Unchecked, these decisions can pile up over time without realising.

### How do we fix it?
The first step is knowing you have a problem, just like any other. Identifying problem areas in your codebase, places where nobody dares go until they are forced to add a new feature. Sounds familiar, right?
Instead of taking time out to refactor parts of the codebase for the sake of it, which I might add is much harder to convince anyone it's worth doing now, versus later, I would recommend waiting until you have a feature that needs to be implemented in that area, or could benefit from its refactoring. This ammunition can help you prioritise the refactoring ahead of the feature work itself, if building the feature will be easier. Think of it like an investment.

Planning the redesign of the software with the feature itself, means when it comes time to add the feature, it should be a piece of cake - assuming the planning and execution has gone well.

Whether it's a random hack or a poorly architected part of the software, you can treat the problems in the same way. 
If you're thinking it's too late to refactor and you need to completely rewire, I would urge you to think again, since in my experience it's almost always harder to compeletely re-write, unless there are other factors in play than simply it's bad code.
It can be tempting to want to start again and commit to a new set of guidelines for how you build your software, but in the long run you will eventually need to be disciplined enough in your team to see a problem and fix it rather than needing to start again because it got so bad.

In Elixir, I would argue refactoring is at its easiest when you think about modules and functions, as opposed to hierarchical structures that you might find in Object-Oriented Programming languages. Of course, you can still get yourself into a mess in Elixir with the over-use of OTP features and apparent indirection that can come from Meta-programming with Macros.
In general I have found it easier than most other languages that I have used.

A simple mindset change might be all you need to progress from an unmaintainable codebase to one that is easy to add new features. A popular one in programming is the Boy Scout's rule: "Always leave the camp ground cleaner than you found it", which in relation to programming means you fix something that's broken when you see it - while you're touching that code.

It can also be helpful to take the codebase in the state that it's in now and discuss improvements with your team (or yourself if you're riding solo), and plan for the state you'd like it to be in. When you can agree on how the codebase should look, it's easier to make steps towards that goal each time you write code. Over time, this will pay off with the correct attitude.

Tech debt is a mystical beast that can break companies, teams and software alike. Through understanding of how problems like this arise in software development, it's possible to limit the effect it has.

*Note for the reader: Planned tech debt is not an excuse for writing bad code, nor should it happen consecutively across features - you may be in more trouble than you think!*
