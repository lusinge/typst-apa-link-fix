#import "../lib.typ": *

#show: apa7-student.with(
  title: [American Psychological Association (APA) Style Template for Student Papers],
  author: [Author Name],
  affiliation: [Affiliation Department, Name],
  due-date: datetime.today().display("[month repr:long] [day padding:none], [year]"),
  course: [Course Number: Course Name],
  keywords: ("APA", "Style", "Template"),
  toc: false,
)

#include "introduction.typ"

#pagebreak()
#include "lists.typ"

#pagebreak()
#include "quotes.typ"

#pagebreak()
#bibliography(
  "./bibliography.bib",
  full: true,
  title: auto,
  style: "apa",
)

#pagebreak()
#include "footnote.typ"

#pagebreak()
#include "tables.typ"

#pagebreak()
#include "figures.typ"

#pagebreak()
= Appendices
#lorem(50)

#pagebreak()
#outline(
  title: [List of figures],
  target: figure.where(kind: image),
)

#pagebreak()
#outline(
  title: [List of tables],
  target: figure.where(kind: table),
)