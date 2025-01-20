#import "languages.typ": *

// For supplement: either "Appendix", "Annex" or "Addendum"
#let appendix(
  heading-numbering: "A.",
  supplement: "Appendix",
  // Applies numbering also for headings of level 2 and 3
  numbering-for-all: false,
  body,
) = context {
  show heading: set heading(supplement: get-terms(text.lang).at(supplement))
  let multiple-level-1 = query(heading.where(level: 1, supplement: [#get-terms(text.lang).at(supplement)])).len() > 1
  show heading.where(level: 1): set heading(numbering: heading-numbering) if multiple-level-1
  show heading.where(level: 2): set heading(numbering: heading-numbering) if numbering-for-all
  show heading.where(level: 3): set heading(numbering: heading-numbering) if numbering-for-all

  counter(heading).update(0)

  show heading.where(level: 1): it => align(center)[
    #pagebreak()
    #it.supplement
    #if (multiple-level-1) {
      numbering(it.numbering, ..counter(heading).at(it.location()))
    }
    #it
  ]

  show heading.where(level: 2): it => par(first-line-indent: 0in)[
    #if (numbering-for-all) [
      #numbering(it.numbering, ..counter(heading).at(it.location()))
    ]
    #it.body
  ]

  show heading.where(level: 3): it => par(
    first-line-indent: 0in,
    emph[
      #if numbering-for-all [
        #numbering(it.numbering, ..counter(heading).at(it.location()))
      ]
      #it.body
    ],
  )

  body
}

#let appendix-outline(
  depth: none,
  fill: repeat[.],
  indent: none,
  heading-supplement: "Appendix",
  title: auto,
) = context [
  #outline(
    title: title,
    depth: depth,
    fill: fill,
    indent: indent,
    target: heading.where(supplement: [#get-terms(text.lang).at(heading-supplement)]),
  )
]
