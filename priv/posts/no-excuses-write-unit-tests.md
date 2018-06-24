---
title: No excuses, write unit tests
published: true
published_date: 2016-11-29 12:22:00
slug: no-excuses-write-unit-tests
blurb: Unit testing can sometimes be a tricky subject no matter what language you’re writing in. In this article, I explain how to get started with testing and stop making excuses for your team.
---

Unit testing can sometimes be a tricky subject no matter what language you’re writing in. There’s a few reasons for this:

- There’s fear unit testing will take time your team doesn’t have
- Your team can’t agree on an acceptable level of test coverage or get stuck bike-shedding*
- People are frustrated by breaking tests when changing code

First let’s invest a bit of time understanding what I mean by unit testing. A unit can be any block of code that can be isolated and executed on its own. This can be a function or even a group of functions, although the latter makes it more difficult to test due to many moving parts.

A function is easily testable, if it always produces the same output, that is, it returns the same thing from inside the function, when given the same inputs (parameters).

It’s great for testing because we can make assumptions and set expectations based on those return values. The idea being, that when the test passes, the function still satisfies the requirements in the assertions, regardless of how it gets to that result.

__An example of simple testing:__

```
import { it } from 'mocha';
import { expect } from 'chai';

/**
 * Add numbers together
 *
 * @param {int} numbers One or many numbers to add
 */
const add = (...numbers) => {
  return numbers.reduce((acc, val) => {
    return acc + val;
  }, 0);
};

it('should add numbers', () => {
  const expected = 15;
  const actual = add(1, 2, 3, 4, 5);

  expect(actual).to.equal(expected); // true
});

/**
 * Subtract numbers from an initial number
 *
 * @param {int} initialNumber The number we start from when subtracting
 * @param {int} numbers       One or many numbers to subtract
 */
const minus = (initialNumber, ...numbers) => {
  return numbers.reduce((acc, val) => {
    return acc - val;
  }, initialNumber);
};

it('should minus numbers', () => {
  const expected = 5;
  const actual = minus(15, 5, 3, 2);

  expect(actual).to.equal(expected); // true
});
```

You can go as far with these tests as you like. If we wanted to we could add tests for what happens when the add and minus functions are passed values that are not numbers, does it need to deal with negative numbers?

Adding tests for even the simplest functions can provide you with more information about:

- How hard the function is to use (number of parameters, understanding of output by function name)
- Potential risks for the function living in the wild and being used by other developers
- Whether the function is doing too much, either because you have to mock the world for it to even run, or if you are asserting too many things per function

There’s so much to gain from writing tests, and so much to lose if you don’t.

## You’ve got time for unit testing
Unit testing your code takes some extra time upfront, because of course, you need to write extra code – the tests.
Then, weeks or months go by after you’ve written those tests and you make a change to a function that was tested, and the test breaks. Bugger. Now you’ve got to go in and fix the test.

I’ve heard people complain that fixing broken tests is hard, time consuming and/or a waste of time. My response is where would you rather be fixing that bug? Would you rather it be in production while people are angry features are broken, or in a unit test, prolonging the time it takes to complete a task?

If you change an API, things should break. If tests did not break, and that code went out to production, now everywhere else the code was used is now broken, you’ve got 99 problems but lucky you, testing ain’t one.
I’ll tell you what, most teams don’t have time to fix bugs in production, yet time is always made for it. Everyone knows fixing bugs that occur in production is important, from managers to developers, but we’re always waiting until they’re in production to fix them.

To me, it seems as if we could move the bug fixing earlier in the process and spend more time focussing in code clarity which promotes understanding of the code. Half of the time spent fixing a bug is figuring out how the hell it happened. If you had a unit test it would tell you as soon as you change something and run the test.

Writing tests gets easier the more you do it. You will find that after a while you start writing code that’s easily testable because you were thinking about how you would test that code, while you were writing it! Imagine that!

## Just write the damn test
Engineers are renowned for over-engineering. We think in abstractions and it’s normal to think too much about what should be a simple solution. The hardest part of that is just realising you might be going too far.

Often, when new things pop up, we think of the best solution without addressing the core problems in an efficient manner.

Deciding on team coding best practices is great. Including test coverage, what and how to test among other things is good. Preventing your team from trying things and learning from mistakes is bad.

Don’t let it stand in your way of writing the damn test. A good rule of thumb for any new software is:
> First, make it work. Then make it right.

This rule can be applied to unit testing in a number of ways, but the most useful I’ve found is to first write the code to make the thing work, preferably small functions and then write a test for it.

Now that you’ve got a tested function, change the internal code of that function and see if the test still passes.
**Simply – Write. Test. Refactor.**

## Dealing with broken tests
After you’ve been going writing tests for a while, you should start to notice more things you change will break existing tests. This is a good thing. Don’t underestimate the power of a broken test.

Firstly, it forces the developer that broke the test to understand a bit more about how a piece of code will run in. As in what inputs and outputs are expected, depending on how well it was tested.

Secondly, it forces any API changes to be well thought-out and potentially discussed as a team depending on the size of the change.

Third, **and most importantly**, is that you found out in your terminal, as opposed to when a customer tried to do something.

Just like anything, you can go too far with testing. And it depends on the application as to how deep you go into unit testing.

In my experience, I see no reason good enough not to at least have some unit testing. Run the code in some expected scenarios and see what happens.

It’s just like when you deploy your application and start clicking around on buttons, interacting with the app.

You’re not going to just deploy your application and forget it even exists!

Or would you? Start unit testing today. Start small and work your way up.

*Bike-shedding refers to the time spent solving relatively unimportant issues when the larger problem should be solved before addressing minor details.