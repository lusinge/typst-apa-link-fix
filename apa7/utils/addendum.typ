#import "languages.typ": *

#let addendum(
  heading-numbering: "A.1.",
  supplement: "Appendix",
  body,
) = context {
  let font-size = text.size
  let doc-lang = text.lang
  
  set heading(
    numbering: heading-numbering,
  )

  show heading.where(level: 1): set heading(
    supplement: get-terms(doc-lang).at(supplement)
  )
  
  counter(heading).update(0)

  show heading.where(level: 1): it => align(center)[
    #set text(size: font-size)
    #pagebreak()
    #it.supplement
    #numbering(it.numbering, ..counter(heading).at(it.location()))
    #it.body
  ]

  show heading.where(level: 2): it => [
    #set text(size: font-size)
    #set par(first-line-indent: 0in)
    #numbering(it.numbering, ..counter(heading).at(it.location()))
    #it.body
  ]
  
  body
}