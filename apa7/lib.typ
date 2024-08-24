#import "../utils/to-string.typ": *
#import "utils/languages.typ": *
#import "utils/authoring.typ": *
#import "utils/orcid.typ": *

#let apa-size = state("font-size", 11pt)

#let apa7(
  title: [Paper Title],
  
  authors: (:),
  affiliations: (:),

  custom-authors: [],
  custom-affiliations: [],

  // Student-specific fields
  course: [],
  instructor: [],
  due-date: [],

  // Professional-specific fields
  running-head: [],
  author-notes: [],
  keywords: (),
  abstract: [],

  // Common fields
  font-family: "New Computer Modern",
  font-size: 11pt,
  region: "us",
  language: "en",
  paper-size: "us-letter",
  implicit-introduction-heading: true,
  toc: false,

  body
) = {
  let double-spacing = 1.5em

  authors = final-authors(authors, custom-authors)
  affiliations = final-affiliations(affiliations, custom-affiliations)

  set document(
    title: title,
    author: if type(authors) == array {
      authors.map(it => to-string(it.name))
    } else {
      to-string(authors).trim(" ", at: start).trim(" ", at: end)
    },
    keywords: keywords,
  )

  set text(
    size: font-size,
    font: font-family,
    region: region,
    lang: language,
  )

  state("font-size").update(font-size)

  set page(
    margin: 1in,
    paper: paper-size,
    numbering: "1",
    number-align: top + right,
    header: locate(loc => {
      upper(running-head)
      
      h(1fr)
      
      str(counter(page).at(loc).first())
    })
  )

  set par(
    leading: double-spacing,
  )

  show par: set block(
    spacing: double-spacing,
  )


  if running-head != none and running-head != [] and running-head != "" {
    if to-string(running-head).len() > 50 {
      panic("Running head must be no more than 50 characters, including spaces and punctuation.")
    }
  }

  align(center)[
    #for i in range(4) {
      [~] + parbreak()
    }

    #strong(title)

    ~
    
    #parbreak()

    #print-authors(authors, affiliations, language)

    #print-affiliations(authors, affiliations)

    #if type(course) == content and course != [] {
      course
    } else if type(course) != content {
      panic("Course must be of type content: ", type(course))
    }

    #if type(instructor) == content and instructor != [] {
      instructor
    } else if type(instructor) != content {
      panic("Instructor must be of type content: ", type(instructor))
    }

    #if ((type(due-date) == content and due-date != []) or (type(due-date) == str and due-date != "")) {
      due-date
    } else if type(due-date) != content {
      panic("Due date must be of type content or string: ", type(due-date))
    }

    #if author-notes != [] and author-notes != none {
      v(1fr)

      strong(get-terms(language).at("Author Note"))

      align(left)[
        #set par(first-line-indent: 0.5in)
        #author-notes
      ]
    }

    #pagebreak()
  ]

  show heading: it => locate(loc => {
    set block(spacing: double-spacing)
    set text(size: font-size)
    if it.level == 1 {
      align(center, strong(it.body))
    } else if it.level == 2 {
      par(first-line-indent: 0in, strong(it.body))
    } else if it.level == 3 {
      par(first-line-indent: 0in, emph(strong(it.body)))
    } else if it.level == 4 {
      strong(it.body) + "."
    } else if it.level == 5 {
      emph(strong(it.body)) + "."
    } else {
      panic("Invalid heading: ", it, it.level)
    }
  })

  set par(
    first-line-indent: 0.5in,
    leading: double-spacing,
  )

  show figure: set figure.caption(
    position: top
  )

  set figure(
    gap: 1.5em,
    placement: none
  )

  show figure.caption: it => {
    set par(first-line-indent: 0in)
    align(left)[
      *#it.supplement #it.counter.display(it.numbering)*

      #emph(it.body)
    ]
  }

  set table(
    stroke: none,
  )

  set list(
    marker: (text(size: 1.25em)[•], [‣], [–]),
    indent: 0.5in - 1.75em,
    body-indent: 1.3em,
  )

  set enum(
    indent: 0.5in - 1.5em,
    body-indent: 0.75em,
  )

  set raw(
    tab-size: 4,
    block: true,
  )

  show raw.where(block: true): block.with(
    fill: luma(230),
    inset: 5pt,
    radius: 10pt,
  )

  show raw: text.with(
    font: "DejaVu Sans Mono",
    size: 10pt
  )

  show figure.where(kind: raw): it => {
    set align(left)
    it.caption
    it.body
  }

  show quote: set pad(left: 0.5in)
  show quote: set block(spacing: 1.5em)

  show quote: it => {
    let quote-text = to-string(it.body)
    let quote-text-words = to-string(it.body).split(" ").len()
    let quote-attribution = to-string(it.attribution)
    if quote-attribution.first() != "(" and quote-attribution.last() != ")" {
      quote-attribution = "(" + quote-attribution + ")"
    }

    if quote-text-words <= 40 {
      set quote(block: false)
      [
        "#quote-text.trim(" ", at: start).trim(" ", at: end)"
        #quote-attribution.
      ]
    } else {
      set quote(block: true)
      set par(hanging-indent: 0.5in)
      [
        #quote-text.trim(" ", at: start).trim(" ", at: end)
        #quote-attribution
      ]
    }
  }

  set bibliography(
    style: "apa",
  )

  if (toc) {
    show outline.entry.where(level: 1): it => {
      strong(it)
    }

    show outline.entry.where(level: 2): it => {
      strong(emph(it))
    }

    show outline.entry.where(level: 3): it => {
      emph(it)
    }

    show outline.entry.where(level: 4): it => {
      it
    }
    
    outline(indent: 2em, depth: 4)
    pagebreak()
  }

  if (type(abstract) == content and abstract != []) {
    heading(level: 1, get-terms(language).Abstract)

    par(first-line-indent: 0in)[
      #abstract
    ]

    emph(get-terms(language).Keywords)
    [: ]
    keywords.map(it => it).join(", ")
    
    pagebreak()
  } else if (type(abstract) != content) {
    panic("Invalid abstract type, must of type content: ", type(abstract))
  }

  if implicit-introduction-heading {
    heading(level: 1, title)
  }

  body
}

#let appendix(body) = {
  counter(heading).update(0)

  show heading.where(level: 1): it => align(center)[
    #set text(size: state("font-size").final())
    #pagebreak()
    #it.supplement #numbering(it.numbering, ..counter(heading).at(it.location())) #it.body
  ]

  show heading.where(level: 2): it => [
    #set par(first-line-indent: 0in)
    #set text(size: state("font-size").final())
    #it.supplement
    #numbering(it.numbering, ..counter(heading).at(it.location()))
    #it.body
    #parbreak()
  ]

  show heading.where(level: 3): it => [
    #set par(first-line-indent: 0in)
    #set text(size: state("font-size").final())
    #it.supplement
    #numbering(it.numbering, ..counter(heading).at(it.location()))
    #it.body
    #parbreak()
  ]

  body
}