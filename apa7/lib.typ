#import "../utils/to-string.typ": to-string
#import "languages.typ": get-terms

#let include-orcid(author, orcid) = {
  if orcid != none [
    #author
    #box(height: 1em, image("assets/img/ORCID_iD.svg.png", width: 2.5%),)
    #link("https://orcid.org/" + orcid)
  ] else {
    author
  }
}

#let final-authors(authors, custom-authors) = {
  if authors != (:) and custom-authors != [] {
    panic("Authors and custom-authors cannot both be defined.")
  }

  if authors == (:) and (custom-authors == [] or custom-authors == none) {
    panic("At least one author must be defined.")
  }

  if authors != (:) {
    authors
  } else {
    custom-authors
  }
}

#let final-affiliations(affiliations, custom-affiliations) = {
  if affiliations != (:) and custom-affiliations != [] {
    panic("Affiliations and custom-affiliations cannot both be defined.")
  }

  if affiliations == (:) and (custom-affiliations == [] or custom-affiliations == none) {
    panic("At least one affiliation must be defined.")
  }

  if affiliations != (:) {
    affiliations
  } else {
    custom-affiliations
  }
}


#let enumerate-affiliations(affiliations) = {
  let count = 1
  for affiliation in affiliations {
    affiliations.at(count - 1).insert("n", count)
    count += 1
  }

  return affiliations
}

#let is-multiple-authors-with-different-affiliations(authors, affiliations) = {
  // check if the authors have a different length of affiliations
  let author-affiliations-length = authors.map(it => it.affiliations.len())
  for i in author-affiliations-length {
    if i != author-affiliations-length.first() {
      return true
    }
  }

  // if the authors have the same length of affiliations, check if the affiliations are the same
  let seen-affiliations = ()
  for author in authors.map(it => it.affiliations) {
    for id in author {
      if id not in seen-affiliations {
        seen-affiliations.push(id)

        if seen-affiliations.len() > author.len() {
          return true
        }
      }
    }
  }

  return false
}

#let print-authors-with-different-affiliations(authors, affiliations, language) = {
  affiliations = enumerate-affiliations(affiliations)
  
  let aff-positions = (:)
  for aff in affiliations {
    aff-positions.insert(aff.id, str(aff.n))
  }

  let upd-auth = ()
  for auth in authors {
    let upd-aff = ()
    for aff in auth.affiliations {
      upd-aff.push((
        id: aff,
        n: aff-positions.at(aff)
      ))
    }

    upd-auth.push((
      name: auth.name,
      affiliations: upd-aff
    ))
  }

  if upd-auth.len() == 2 [
    #upd-auth.at(0).name
    #get-terms(language).and
    #upd-auth.at(1).name
  ] else {
    for upd in upd-auth {
      upd.name

      for aff in upd.affiliations {
        if aff != upd.affiliations.last() {
          super[#aff.n, ]
        } else {
          super[#aff.n]
        }
      }

      if upd.name == upd-auth.at(-2).name {
        [ #get-terms(language).and ]
      } else if upd.name == upd-auth.last().name {
      } else {
        [, ]
      }
    }
  }
}

#let print-authors(authors, affiliations, language) = {
  if type(authors) != content and type(authors) != str {
    if authors.len() == 1 { // single author
      authors.at(0).name
    } else if is-multiple-authors-with-different-affiliations(authors, affiliations) { // multiple authors with different affiliations
      print-authors-with-different-affiliations(authors, affiliations, language)
    } else { // multiple authors with shared affiliations
      if authors.len() == 2 [
        #authors.at(0).name
        #get-terms(language).and
        #authors.at(1).name
      ] else {
        let author-names = authors.map(it => it.name)
        for i in author-names {
          if i == author-names.last() [
            #get-terms(language).and #i
          ] else [
            #i,
          ]
        }
      }
    }
  } else {
    authors
  }
}

#let print-affiliations(authors, affiliations) = {
  if type(affiliations) != content and type(affiliations) != str {
    if affiliations.len() == 1 {
      affiliations.at(0).name
    } else if is-multiple-authors-with-different-affiliations(authors, affiliations) {
      for affiliation in enumerate-affiliations(affiliations) [
        #super[#affiliation.n] #affiliation.name
        #parbreak()
      ]
    } else {
      for aff in affiliations {
        aff.name
        parbreak()
      }
    }
  } else {
    affiliations
  }
}

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

  show heading: it => {
    if it.level == 1 {
      set align(center)
      set par(first-line-indent: 0in)
      text(size: font-size, weight: "bold", it.body)
    } else if it.level ==  2 {
      set par(first-line-indent: 0in)
      text(size: font-size, weight: "bold", it.body)
    } else if it.level ==  3 {
      set par(first-line-indent: 0in)
      text(size: font-size, style: "italic", weight: "bold", it.body)
    } else if it.level ==  4 {
      text(size: font-size, weight: "bold")[#it.body] + "."
    } else if it.level ==  5 {
      text(size: font-size, style: "italic", weight: "bold")[#it.body] + "."
    } else {
      panic("Invalid heading level: ", it.level)
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

  heading(level: 1, title)

  body
}