#import "languages.typ": *
#import "to-string.typ": *

#let apa-figure(body, caption: none, gap: 1.5em, kind: auto, numbering: "1", outlined: true, placement: none, scope: "column", supplement: auto, note: none, label: none) = context [
  #figure(
    [
      #body
      #set align(left)
      #emph(get-terms(text.lang).Note).
      #note
    ],
    caption: caption,
    gap: gap,
    kind: kind,
    numbering: numbering,
    outlined: outlined,
    placement: placement,
    scope: scope,
    supplement: supplement,
  ) #std.label(label)
]
