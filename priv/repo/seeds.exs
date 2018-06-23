JackMarchant.Repo.delete_all(JackMarchant.Post)

date = NaiveDateTime.from_iso8601!("2018-06-22 10:00:00")

JackMarchant.Repo.insert!(%JackMarchant.Post{
  title: "A Queue is just a Q with 4 silent letters",
  content: "<p>A Queue is just a Q with 4 silent letters.</p>",
  blurb: "I talk about Queues",
  slug: "elixir-queues",
  published_date: date,
  published: true
})

JackMarchant.Repo.insert!(%JackMarchant.Post{
  title: "Another blog post",
  content: "<pThis is another blog post</p><pre>Some code goes here</pre>",
  blurb: "I talk about Queues",
  slug: "another-blog-post",
  published_date: date,
  published: true
})
