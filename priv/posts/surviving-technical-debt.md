---
title: Surviving technical debt in the real world
published: true
published_date: 2017-12-21 12:18:00
blurb: I describe my experiences with technical debt, and why it may not always be a good idea to "move quickly".
slug: surviving-technical-debt
---

Technical debt is a potentially crippling disease that can take over your codebase without much warning. One day, you’re building features, the next, you struggle to untangle the mess you (or maybe your team) has created.

The good news is you’re not alone. Engineers everywhere accrue technical debt, the trouble is when you never do anything to get yourself out of debt, you just keep smashing features out into the dark abyss of GitHub.

You can train yourself not to take a shortcut all the time, and start to learn the benefits of technical debt when used properly. All it takes is a bit of willpower. Yes, the same thing you use if you want to shed a few kilos. When you take short cuts all the time, it’s hard to bust out of that groove and future proof things.

## Does it even work?
Always be testing your code. Even when you write code that you can see is bad, write a test so that when you refactor it you can have a level of confidence it’s still going to work.


## You’re not in control of all situations
There might come a time when you’re pressed to get things done now. When that happens, get it done and take a cheat day. There’s nothing wrong with this, after all you are not your code and businesses want things done yesterday.

Just try to record you took the shortcut perhaps with a Fixme comment and plan to refactor.

## Bugs are bad, mmkay
Be okay with pushing bugs to production. Bugs are not created equally, so of course don’t be okay with breaking the application, but small bugs are going to happen. It is not a measure of your expertise as a developer that you missed it. Rather, I would measure a person’s commitment to fixing said bug rather than producing it in the first place.

## Catch it in code review
Code review is an effective exercise for both reviewer and author. If something is a short cut, make sure the author knows. On the flip side, as an author, make sure you let reviewers know the code could be improved but you will fix it later. Ownership of tech debt is important, because in a team it can often get lost as nobody’s problem until you all have to deal with it.


## Don’t overuse technical debt as an excuse to write bad code
Use technical debt sparingly. If you are spending more time justifying why the code you’re writing is technical debt than writing code. I have bad news for you.

It ain’t technical debt.

It takes a lot of self control and willpower not to take the easy road, especially when you discover someone else’s technical debt, which they have not bothered to refactor.

It’s a skill, which once mastered, means your coworkers will thank you.

I am by no means an expert at not writing or fixing technical debt, but it has become a satisfying effort for me to fix what was once broken or difficult to understand.

If you’ve read this far, you probably have enough willpower to fix tech debt already…