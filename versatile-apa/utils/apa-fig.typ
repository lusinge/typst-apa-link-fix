#let apa-img(caption: [], image: "", note: [], label: "") = [
  #figure(
    caption: caption,
    [
      #image
      #set align(left)
      _Note_. #note
    ],
  ) #std.label(label)
]

#let apa-tab(caption: [], table: table(), note: [], label: "") = [
  #figure(
    caption: caption,
    [
      #table
      #set align(left)
      _Note_. #note
    ],
  ) #std.label(label)
]