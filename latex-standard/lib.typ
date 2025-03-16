#import "@preview/drafting:0.2.0": *
#import "utils/font-sizes.typ": *
#import "./utils/to-string.typ": *

#set rect(outset: 0cm, inset: 0cm, width: 100%, height: 100%)

#set page(
  // header: rect(),
  // footer: rect(),
)

#let latex-standard(
  title: [Title],
  author: [Author Name],
  date: datetime.today().display("[month repr:long] [day], [year]"),
  class: "article",
  font-size: 10pt,
  paper-size: "us-letter",
  flush-left-equations: false,
  left-equation-numbering: false,
  two-column: false,
  sides: "one",
  landscape: false,
  open: "any",
  draft: false,
  make-title: false,
  body,
) = {
  set document(
    author: to-string(author),
    title: title,
  )

  if (font-size == 10pt) {
    font-size = font-10pt
  } else if (font-size == 11pt) {
    font-size = font-11pt
  } else if (font-size == 12pt) {
    font-size = font-12pt
  } else {
    font-size = font-10pt
  }

  set page(
    header-ascent: 20%,
    paper: paper-size,
    margin: font-size.margin,
    numbering: "1",
  )

  // set-page-properties()
  set-margin-note-defaults(
    stroke: none,
    side: right,
    margin-right: 2.8cm,
    margin-left: 4.8cm,
  )

  set text(
    size: font-size.normalsize,
    font: "New Computer Modern",
  )

  if (make-title) {
    align(center)[
      #v(1fr)

      #text(size: font-size.LARGE, title)
      #parbreak()
      ~
      #parbreak()
      #text(size: font-size.large, author)
      #parbreak()
      #text(size: font-size.large, date)

      #v(1fr)
    ]

    if (class != "article") {
      pagebreak()
    }
  }

  //TODO: Chapters shouldn't be available if the class is article.
  // So the level 1 heading should be a chapter if the class isn't article.

  // typst doesn't have ex unit, so ex = ~0.5em

  // Lower level headings
  // TODO: Numbering width is too narrow

  // Section
  show heading.where(level: 1): set text(size: font-size.Large, weight: "bold") if class == "article"
  show heading.where(level: 1): set block(above: 3.5 * 0.5em, below: 2.3 * 0.5em) if class == "article"
  set heading(numbering: "1.1") if class == "article"

  // Subsection
  show heading.where(level: 2): set text(size: font-size.large, weight: "bold") if class == "article"
  show heading.where(level: 2): set block(above: 3.25 * 0.6em, below: 1.5 * 0.6em) if class == "article"
  show heading.where(level: 2): set heading(numbering: "1.1") if class == "article"

  // Subsubsection
  show heading.where(level: 3): set text(size: font-size.normalsize, weight: "bold") if class == "article"
  show heading.where(level: 3): set block(above: 3.25 * 0.6em, below: 1.5 * 0.6em) if class == "article"
  show heading.where(level: 3): set heading(numbering: "1.1") if class == "article"

  // Paragraph
  show heading.where(level: 4): set text(size: font-size.normalsize, weight: "bold") if class == "article"
  // show heading.where(level: 4): set block(above: 3.25 * 0.5em, below: 1em) if class == "article"
  show heading.where(level: 4): set heading(numbering: none) if class == "article"
  show heading.where(level: 4): set text(top-edge: 3.25 * 0.5em, bottom-edge: 1em) if class == "article"
  // show heading.where(level: 4): set box()

  // show heading.where(level: 4): it => strong(it.body)

  // Subparagraph
  show heading.where(level: 5): set text(size: font-size.normalsize, weight: "bold") if class == "article"
  show heading.where(level: 5): set block(above: 3.25 * 0.5em, below: 1em) if class == "article"
  show heading.where(level: 5): set heading(numbering: none) if class == "article"
  show heading.where(level: 5): set text(top-edge: 3.25 * 0.5em, bottom-edge: 1em) if class == "article"

  // show heading.where(level: 5): it => strong(it.body)

  show heading.where(level: 4).or(heading.where(level: 5)): it => {
    if it.level == 4 {
      box(
        pad(
          left: -1.5em,
          it.body,
        ),
      )
    } else if (it.level == 5) {
      it.body
    }
  }

  // set heading(
  //   numbering: (..n) => {
  //     let pos = n.pos()
  //     if pos.len() == 1 {
  //       numbering("I", ..n)
  //     } else if pos.len() == 2 {
  //       numbering("1.", pos.last())
  //     } else if pos.len() == 3 or pos.len() == 4 {
  //       numbering("1.1", ..pos.slice(1))
  //     } else {
  //       // numbering("1.1  ", ..n.pos().slice(1))
  //     }
  //   },
  // )

  // show heading.where(level: 1): it => [
  //   #pagebreak(weak: true)
  //   #rect()[
  //     #align(center)[
  //       #v(175pt)
  //       Part #counter(heading.where(level: 1)).display()
  //       #v(20pt)
  //       #it.body
  //       #v(1fr)
  //     ]]
  //   #colbreak()
  // ]

  // show heading.where(level: 2): it => [
  //   #colbreak(weak: true)
  //   #set par(first-line-indent: 0in)

  //   #v(70pt)
  //   Chapter #counter(heading.where(level: 2)).display().trim(".", at: end)
  //   #v(20pt)
  //   #text(size: font-size.Huge)[#it.body]
  //   #v(29pt)
  // ]


  set par(
    first-line-indent: 1.5em,
    spacing: 1.2 * 0.5em,
    leading: 1.15 * 0.5em,
    justify: true,
  )

  body
}

// show heading.where(level: 1) makes the outline() be numbered
#let table-of-contents(title: [Contents], depth: 3) = {
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry: set block(spacing: 0.55em)
  show outline.entry.where(level: 1): set block(above: 2.5 * 0.55em, below: 0.5 * 0.55em)
  show outline.entry.where(level: 1): set text(weight: "bold")
  set outline.entry(fill: repeat([.], gap: 0.5em))
  heading(numbering: none, outlined: false, title)
  outline(title: none, depth: depth)
}
