#import "../lib.typ": *

#show: apa7-student.with(
  title: [American Psychological Association (APA) Style Template for Student Papers],
  
  authors: [Author Name],
  affiliation: [Affiliation Department, Name],
  course-code: [Course Code],
  course-name: [Course Name],
  instructor: [Instructor Name],
  due-date: datetime.today().display("[month repr:long] [day padding:none], [year]"),

  font-family: "Times New Roman",
  font-size: 12pt,
  region: "us",
  language: "en",
  paper-size: "us-letter",

  toc: false,
  keywords: ("APA", "Style", "Template"),
  abstract: [
    #lorem(100)
  ],
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