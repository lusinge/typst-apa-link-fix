#let chapter-counter = counter("chapter")
#show heading.where(level: 1): it => {
  it

  context {
    let chapter-numbers = chapter-counter.get()
    counter(heading).update((one, ..n) => (one, ..chapter-numbers))
  }
}

#show heading: it => {
  if it.level == 2 {
    chapter-counter.step(level: 1) // Step for chapters
  }

  it
}

#set heading(numbering: "1.")

#outline()

= Part 1
== Chapter 1
=== Section 1
==== Subsection 1
==== Subsection 2
=== Section 2
== Chapter 2
=== Section 1
=== Section 2
= Part 2
== Chapter 3 // Will now be Chapter 3 instead of resetting to Chapter 1
=== Section 1
=== Section 2
== Chapter 4 // Will now be Chapter 4 instead of Chapter 2
=== Section 1
=== Section 2
=== Section 3
==== Subsection 1
==== Subsection 2
== Chapter 5 // Will now be Chapter 5 instead of Chapter 3

