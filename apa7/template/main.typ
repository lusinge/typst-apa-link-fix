#import "../lib.typ": *

#show: apa7.with(
  title: [American Psychological Association (APA) Style Template for Typst],
  
  // authors: (
  //   (
  //     name: [Author Name 1],
  //     affiliations: ("AF-1", "AF-2"),
  //   ),
  //   (
  //     name: [Author Name 2],
  //     affiliations: ("AF-3",),
  //   ),
  //   (
  //     name: [Author Name 3],
  //     affiliations: ("AF-4", "AF-5", "AF-6"),
  //   ),
  // ),
  // affiliations: (
  //   (
  //     id: "AF-1",
  //     name: [Affiliation Department 1],
  //   ),
  //   (
  //     id: "AF-2",
  //     name: [Affiliation Department 2],
  //   ),
  //   (
  //     id: "AF-3",
  //     name: [Affiliation Department 3],
  //   ),
  //   (
  //     id: "AF-4",
  //     name: [Affiliation Department 4],
  //   ),
  //   (
  //     id: "AF-5",
  //     name: [Affiliation Department 5],
  //   ),
  //   (
  //     id: "AF-6",
  //     name: [Affiliation Department 6],
  //   )
  // ),
  
  custom-authors: [Author Name],
  custom-affiliations: [Affiliation Department, Affiliation Name],
  
  // Student-specific fields
  course: [Course Code: Course Name],
  instructor: [Instructor Name],
  due-date: datetime.today().display(),

  // Professional-specific fields
  running-head: [running head],
  author-notes: [
    #include-orcid([Author Name], "0000-0000-0000-0000")
    
    #lorem(50)
  ],
  keywords: ("APA", "template", "Typst"),
  abstract: [
    #lorem(100)
  ],

  // Common fields
  font-family: "Linux Libertine",
  font-size: 12pt,
  region: "us",
  language: "es",
  paper-size: "us-letter",
  implicit-introduction-heading: true, // wether to repeat the paper title as the introduction heading
  toc: true,
)

#include "sections/introduction.typ"

#pagebreak()
#include "sections/lists.typ"

#pagebreak()
#include "sections/quotes.typ"

#pagebreak()
#include "sections/computer-code.typ"

#pagebreak()
#bibliography(
  "bibliography/bibliography.bib",
  full: true,
  title: auto,
)

#pagebreak()
#include "sections/footnote.typ"

#pagebreak()
#include "sections/tables.typ"

#pagebreak()
#include "sections/figures.typ"

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