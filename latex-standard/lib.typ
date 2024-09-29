#import "@preview/drafting:0.2.0": *
#import "font-sizes.typ": *
#import "../utils/to-string.typ": *

#set rect(outset: 0cm, inset: 0cm, width: 100%, height: 100%)

#set page(header: rect())
#show footnote.entry: rect()


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
  table-of-contents: false,
  
  
  body
) = {
  set document(
    author: to-string(author),
    title: title,
  )

  set page(
    header: rect[],
    header-ascent: 20%,
    footer: rect[]
  )

  let doc-font-size

  if (font-size == 10pt) {
    doc-font-size = font-10pt
  } else if (font-size == 11pt) {
    doc-font-size = font-11pt
  } else if (font-size == 12pt) {
    doc-font-size = font-12pt
  } else {
    doc-font-size = font-10pt
  }

  set page(
    paper: paper-size,
    margin: (
      top: 1.725in,
      bottom: 1.65in,
      left: 1.85in,
      right: 1.865in,
    ),
    numbering: "1",

  )

  set-page-properties()
    set-margin-note-defaults(
    stroke: none,
    side: right,
    margin-right: 2.8cm, // 1cm is absurd.. just to show that it is being ignored!!!
    margin-left: 4.8cm,
    // page-width: 21cm-8.25cm
  )

  set text(
    size: font-size,
    font: "New Computer Modern",
  )

  if (make-title) {
    rect()[

    #set align(center)
   
   #v(1fr)

    #text(size: doc-font-size.LARGE, title)
    #parbreak()
    ~
    #parbreak()
    #text(size: doc-font-size.large, author)
    #parbreak()
    #text(size: doc-font-size.large, date)
    
    #v(1fr)
    
    ]
    if (class != "article") {
      pagebreak()
    }
  }

  show heading.where(level: 1): set block(above: 2em)
  show heading.where(level: 1): set text(size: doc-font-size.Huge)
  show heading.where(level: 2): set text(size: doc-font-size.huge)
  show heading.where(level: 2): set block(spacing: 2em)
  show heading.where(level: 3): set text(size: doc-font-size.Large)

  show outline: set heading(level: 2)

  show outline: it => {
    it.title
  }

  if (table-of-contents){
    rect(outset: 0cm, inset: 0cm, width: 100%, height: 100%)[
    #outline(depth: 4, title: [Contents])
    ]
    pagebreak()
  }

  set heading(numbering: (..n) => {
    if n.pos().len() == 1 {
      numbering("I", ..n)
    } else if n.pos().len() == 2 {
      numbering("1.", n.pos().last())
    } else if n.pos().len() == 3 or n.pos().len() == 4 {
      numbering("1.1  ", ..n.pos().slice(1))
    } else {
      // numbering("1.1  ", ..n.pos().slice(1))
    }
  })

  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #rect()[
    #align(center)[
      #v(175pt)
      Part #counter(heading.where(level: 1)).display()
      #v(20pt)
      #it.body
      #v(1fr)
    ]]
    #colbreak()
  ]

  show heading.where(level: 2): it => [
    #colbreak(weak: true)
    #set par(first-line-indent: 0in)
    
    #v(70pt)
    Chapter #counter(heading.where(level: 2)).display().trim(".", at: end)
    #v(20pt)
    #text(size: doc-font-size.Huge)[#it.body]
    #v(29pt)
  ]


  show par: set block(
    spacing: 0.5em,
  )

  set par(
    first-line-indent: 1.5em,
    justify: true,
  )

  body
}

#show: latex-standard.with(
  class: "report",
  title: [LaTeX Standard/Base Class/Template],
  author: [Jassiel Ovando Franco],
  make-title: true,
  table-of-contents: true,
)

= Part Introduction

#rect(outset: 0cm, inset: 0cm, width: 100%, height: 100%, )[
== Chapter Getting Started
=== Section Overview
#lorem(20)

#margin-note[A margin note is a note that appears in the margin of a page.]

#lorem(20)

==== Subsection Basics
#lorem(20)

#lorem(20)

===== Subsubsection Introduction to Basics
#lorem(20)

#lorem(20)

====== Paragraph Basic Concepts
#lorem(20)

#lorem(20)

======= Subparagraph Detailed Explanation
#lorem(20)

#lorem(20)

=== Section Installation
#lorem(20)

#lorem(20)
]

==== Subsection Requirements
#lorem(20)

#lorem(20)

===== Subsubsection Software Requirements
#lorem(20)

#lorem(20)

====== Paragraph Installation Steps
#lorem(20)

#lorem(20)

======= Subparagraph Step-by-Step Guide
#lorem(20)

#lorem(20)

=== Section First Steps
#lorem(20)

#lorem(20)

==== Subsection Initial Setup
#lorem(20)

#lorem(20)

===== Subsubsection Configuration
#lorem(20)

#lorem(20)

====== Paragraph Setting Up
#lorem(20)

#lorem(20)

======= Subparagraph Configuration Details
#lorem(20)

#lorem(20)

= Part Advanced Topics
== Chapter Deep Dive
=== Section Advanced Concepts
#lorem(20)

#lorem(20)

==== Subsection In-Depth Analysis
#lorem(20)

#lorem(20)

===== Subsubsection Detailed Study
#lorem(20)

#lorem(20)

====== Paragraph Advanced Techniques
#lorem(20)

#lorem(20)

======= Subparagraph Techniques Explained
#lorem(20)

#lorem(20)

=== Section Optimization
#lorem(20)

#lorem(20)

==== Subsection Performance Tuning
#lorem(20)

#lorem(20)

===== Subsubsection Best Practices
#lorem(20)

#lorem(20)

====== Paragraph Tuning Methods
#lorem(20)

#lorem(20)

======= Subparagraph Methods Explained
#lorem(20)

#lorem(20)

=== Section Security
#lorem(20)

#lorem(20)

==== Subsection Best Practices
#lorem(20)

#lorem(20)

===== Subsubsection Security Measures
#lorem(20)

#lorem(20)

====== Paragraph Implementing Security
#lorem(20)

#lorem(20)

======= Subparagraph Security Details
#lorem(20)

#lorem(20)

= Part Practical Applications
== Chapter Real-World Examples
=== Section Case Studies
#lorem(20)

#lorem(20)

==== Subsection Example 1
#lorem(20)

#lorem(20)

===== Subsubsection Study 1
#lorem(20)

#lorem(20)

====== Paragraph Analysis
#lorem(20)

#lorem(20)

======= Subparagraph Detailed Analysis
#lorem(20)

#lorem(20)

=== Section Projects
#lorem(20)

#lorem(20)

==== Subsection Project 1
#lorem(20)

#lorem(20)

===== Subsubsection Implementation
#lorem(20)

#lorem(20)

====== Paragraph Project Steps
#lorem(20)

#lorem(20)

======= Subparagraph Steps Explained
#lorem(20)

#lorem(20)

=== Section Tutorials
#lorem(20)

#lorem(20)

==== Subsection Tutorial 1
#lorem(20)

#lorem(20)

===== Subsubsection Step-by-Step Guide
#lorem(20)

#lorem(20)

====== Paragraph Tutorial Steps
#lorem(20)

#lorem(20)

======= Subparagraph Detailed Steps
#lorem(20)

#lorem(20)
