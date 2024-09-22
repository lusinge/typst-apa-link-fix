#import "../utils/to-string.typ": *

#let latex-standard(
  title: [Title],
  authors: [Author Name],
  
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
    author: to-string(authors),
    title: title,
  )

  set page(
    paper: paper-size,
  )

  set text(
    size: font-size,
    font: "New Computer Modern",
  )

  

  body
}

#show: latex-standard.with(
  title: [LaTeX Article Template],
  authors: [Jassiel Ovando Franco],
  make-title: true,
)

= Section 1
== Subsection 1.1
=== Subsubsection 1.1.1
==== Paragraph 1.1.1.1
===== Subparagraph 1.1.1.1.1

= Section 2
== Subsection 2.1
=== Subsubsection 2.1.1
==== Paragraph 2.1.1.1
===== Subparagraph 2.1.1.1.1

= Section 3
== Subsection 3.1
=== Subsubsection 3.1.1
==== Paragraph 3.1.1.1
===== Subparagraph 3.1.1.1.1