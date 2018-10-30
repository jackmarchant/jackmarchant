---
title: Offset and Cursor Pagination explained
published: true
published_date: 2018-10-30 08:22:00
slug: offset-and-cursor-pagination-explained
blurb: Pagination is a common concept in software development. Understanding the difference between offset and cursor pagination is critical to building or working with APIs.
---

Typically in an application with a database, you might have more records than you can fit on a page or in a single result set from a query. When you or your users want to retrieve the next page of results, two common options for paginating data include:
1. Offset Pagination
2. Cursor Pagination

### Offset Pagination
When retrieving data with offset pagination, you would typically allow clients to supply two additional parameters in their query: an *offset*, and a *limit*.
__An offset is simply the number of records you wish to skip before selecting records__. This gets slower as the number of records increases because the database still has to read up to the offset number of rows to know where it should start selecting data. This is often described as `O(n)` complexity, meaning it's generally the worst-case scenario. Additionally, in datasets that change frequently as is typical of large databses with frequent writes, the window of results will often be inaccurate across different pages in that you will either miss results entirely or see duplicates because results have now been added to the previous page.

If we want to get the first page of the newest posts from a database, the query might look like this:

```elixir
Post
|> order_by(inserted_at: :desc)
|> limit(20)
```

Then, when we want the second page of results, we can include an offset:

```elixir
Post
|> order_by(inserted_at: :desc)
|> limit(20)
|> offset(20)
```

While you could get away with this method initially, and it's definitely worth doing first - as the number of records increases you can consider alternatives to make reading much faster and more accurate.

### Cursor Pagination
This is where cursor based pagination comes in. __A cursor is a unique identifier for a specific record__, which acts as a pointer to the next record we want to start querying from to get the next page of results. With using a cursor, we remove the need to read rows that we have already seen by using a `WHERE` clause in our query (making it faster to read data as it's constant i.e. `O(1)` time complexity) and we address the issue of inaccurate results by always reading after a specific row rather than relying on the position of records to remain the same.

Using our previous example, but this time implementing pagination with a cursor:
```elixir
Post
|> order_by(inserted_at: :desc)
|> limit(20)
|> where([p], p.id < ^cursor)
```

In order for us to use a cursor, we need to return the results from the first page, in addition to the cursor for the last item in our result set. Using a cursor in this way is fine for moving forward in the result set, but by changing the fetching direction, you add complexity to how you retrieve records.

### Conclusion 
Cursor pagination is most often used for real-time data due to the frequency new records are added and because when reading data you often see the latest results first. There different scenarios in which offset and cursor pagination make the most sense so it will depend on the data itself and how often new records are added. When querying static data, the performance cost alone may not be enough for you to use a cursor, as the added complexity that comes with it may be more than you need.
