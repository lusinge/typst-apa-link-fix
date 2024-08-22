#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content == [ ] {
    " "
  } 
}

#let article(
  title: [Title],
  authors: [Author Name],
  font-size: 10pt,
  make-title: true,
) = {
  set document(
    author: to-string(authors),
    title: title,
  )

  align(center)[

  ]
}