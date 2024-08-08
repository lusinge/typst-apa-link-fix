#let author-xor-authors(author, authors) = {
  if author != "" and authors != () {
    panic("author and authors are mutually exclusive")
  } else if author == "" and authors == () {
    panic("author or authors is required")
  }
}

#let affiliation-xor-affiliations(affiliation, affiliations) = {
  if affiliation != [] and affiliations != () {
    panic("affiliation and affiliations are mutually exclusive")
  } else if affiliation == [] and affiliations == () {
    panic("affiliation or affiliations is required")
  }
}

#let keyword-xor-keywords(keyword, keywords) = {
  if keyword != "" and keywords != () {
    panic("keyword and keywords are mutually exclusive")
  }
}

#let apa7-student(
  title: [Paper Title],
  author: "Author Name",
  authors: (),
  affiliation: [Affiliation Department, Name],
  affiliations: (),
  course: [Course Number: Course Name],
  instructor: [Instructor Name],
  due-date: datetime.today().display(
    "[month repr:long] [day padding:none], [year]"
  ),
  keyword: "",
  keywords: (),
  region: "us",
  language: "en",
  paper-size: "us-letter",
  font-size: 12pt,
  font-family: "Times New Roman",
  toc: false,
  body,
) = {
  author-xor-authors(author, authors)
  affiliation-xor-affiliations(affiliation, affiliations)
  keyword-xor-keywords(keyword, keywords)

  let double-spacing = 1.5em

  set document(
    title: title,
    author: author,
    keywords: keywords,
  )

  set text(
    size: font-size,
    font: font-family,
    region: region,
    lang: language,
  )

  set page(
    margin: 1in,
    paper: paper-size,
    numbering: "1",
    number-align: top + right,
  )

  set par(leading: double-spacing)

  show par: set block(
    spacing: double-spacing
  )

  align(center)[
    #for i in range(4) { [~] + parbreak() }
    *#title*

    ~

    #author
    
    #affiliation
    
    #course
    
    #instructor
    
    #due-date
    #pagebreak()
  ]

  show heading: it => {
    if it.level == 1 {
      set align(center)
      set par(first-line-indent: 0in)
      text(size: font-size, weight: "bold", it.body)
    }
    else if it.level ==  2 {
      set par(first-line-indent: 0in)
      text(size: font-size, weight: "bold", it.body)
    }
    else if it.level ==  3 {
      set par(first-line-indent: 0in)
      text(size: font-size, style: "italic", weight: "bold", it.body)
    }
    else if it.level ==  4 {
      text(size: font-size, weight: "bold")[#it.body] + "."
    }
    else if it.level ==  5 {
      text(size: font-size, style: "italic", weight: "bold")[#it.body] + "."
    } else {
      panic("invalid heading level")
    }
  }

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

  show figure.caption: it => [
    #set par(first-line-indent: 0in)
    #set align(left)
    #strong[
      #it.supplement
      #it.counter.display(it.numbering)
    ]

    #emph[#it.body]
  ]

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

  set quote(block: true)
  show quote: set pad(left: 0.5in)
  show quote: set block(spacing: 1.5em)

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
    
    outline(indent: 2em, depth: 3)
    pagebreak()
  }

  heading(level: 1, title)

  body
}
