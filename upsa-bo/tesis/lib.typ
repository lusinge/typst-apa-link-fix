#import "@preview/hydra:0.6.0": hydra
#import "./utils/to-string.typ": *

#let chapter-counter = counter("chapter")

#let tesis(
  título: [],
  facultad: [],
  carrera: [],
  autor: [],
  registro-autor: [],
  adición: [],
  modalidad: [],
  materia: [],
  guía: [],
  resumen: [],
  abstracto: [],
  problemática: [],
  objetivo-general: [],
  contenido: [],
  grado: [Licenciatura],
  email: "",
  agradecimientos: [],
  resumen-ejecutivo: [],
  palabras-clave: (),
  plan: [],
  portada-externa: true,
  ubicación: "Santa Cruz de la Sierra, Bolivia",
  fecha: datetime.today().year(),
  body,
) = {
  if (autor == []) {
    panic("El autor es obligatorio: ", autor)
  } else if (título == []) {
    panic("El título es obligatorio: ", título)
  }

  set document(
    title: to-string(título),
    description: resumen,
    author: to-string(autor).trim(),
    keywords: ("Tesis", "UPSA", "Proyecto de grado") + palabras-clave,
  )

  set page(
    margin: (
      left: 4cm,
      rest: 2.5cm,
    ),
    paper: "us-letter",
    number-align: bottom + right,
  )

  set text(
    size: 12pt,
    font: "Libertinus Serif",
    lang: "es",
    region: "bo",
  )

  set par(leading: 1.5em)

  set math.equation(numbering: "(1)", supplement: [Expresión Matemática])

  show figure: set figure.caption(position: top)

  show figure: it => {
    block(
      breakable: false,
      sticky: true,
      width: 100%,
      inset: 0in,
    )[
      #it.caption
      #align(center, it.body)
    ]
  }

  set figure(
    gap: 1.5em,
    placement: none,
  )

  show figure.caption: it => {
    set par(first-line-indent: 0in)
    align(left)[
      *#it.supplement #context it.counter.display(it.numbering)*

      #emph(it.body)
    ]
  }

  show table.cell: set par(
    leading: 1em,
    spacing: 2em,
  )

  show figure: set block(breakable: true)

  set par(spacing: 2em)

  show quote: set par(
    leading: 1.5em,
    spacing: 2em,
  )

  show quote: set pad(left: 0.5in)

  set heading(numbering: "1.")

  show heading: set text(size: 12pt)
  show heading: set block(spacing: 2em)
  show heading: set par(leading: 1.5em, spacing: 2em)

  let portada = context align(center)[
    #set text(weight: "bold")
    #image("./assets/images/logo-upsa.png")

    #v(1fr)

    #facultad

    #carrera

    #v(1fr)

    #if (plan != []) [
      #plan
    ]

    #if (modalidad != []) [
      Modalidad de Graduación

      #modalidad

      #v(1fr)
    ]

    #rect(radius: 20%, inset: 10pt)[_«#título»_]

    #if (here().page() == 3 and portada-externa) [
      #v(1fr)

      #modalidad para Optar por el Grado de #grado en #carrera
    ]

    #v(1fr)

    #autor

    #if (registro-autor != [] and here().page() == 3) [
      Reg.: #registro-autor
    ]

    #v(1fr)

    #if (guía != []) [
      #guía
    ]

    #ubicación

    #fecha
  ]

  if portada-externa {
    portada

    pagebreak(to: "odd")
  }

  portada

  if (agradecimientos != []) {
    heading([Agradecimientos], numbering: none, level: 2)
    agradecimientos
  } else {
    pagebreak(to: "odd", weak: true)
  }

  counter(page).update(1)

  set page(numbering: "i")

  if (plan == [] or plan == none) {
    heading(numbering: none, level: 2)[Abstracto]
    table(
      align: (left + horizon, left),
      columns: 2,
      [*Título*], título,
      [*Autor*], autor,
    )

    if (problemática != []) {
      heading([Problemática], numbering: none, level: 2)
      problemática
    }

    if (objetivo-general != []) {
      heading([Objetivo General], numbering: none, level: 2)
      objetivo-general
    }

    if (contenido != []) {
      heading([Contenido], numbering: none, level: 2)
      contenido
    }

    table(
      columns: 2,
      align: (left + horizon, left),
      [*Carrera*], carrera,
      [*Guía*], guía,
      [*Palabras Clave*], palabras-clave.join(", "),
      [*Correo Electrónico*], email,
      [*Fecha*], to-string[#fecha],
    )
  }

  show heading.where(level: 1).or(heading.where(level: 2)): it => {
    pagebreak(weak: true)
    it
  }

  if ((type(resumen) == content and resumen != []) or (type(resumen) == str and resumen != "")) {
    heading([Resumen], numbering: none, level: 2)
    resumen
  }

  if (
    (type(resumen-ejecutivo) == content and resumen-ejecutivo != [])
      or (
        type(resumen-ejecutivo) == str and resumen-ejecutivo != ""
      )
  ) {
    heading([Resumen Ejecutivo], numbering: none, level: 2)
    resumen-ejecutivo
  }

  show heading.where(level: 1): set heading(supplement: [Parte])

  {
    show outline.entry.where(level: 1): it => link(
      it.element.location(),
      upper(
        strong(
          it.indented(
            if it.element.numbering != none [ #it.element.supplement #it.prefix()] else { it.prefix() },
            [#it.body() #h(1fr) #it.page()],
          ),
        ),
      ),
    )
    show outline.entry.where(level: 2): it => link(
      it.element.location(),
      smallcaps(
        strong(
          it.indented(
            if it.element.numbering != none [ #it.element.supplement #it.prefix()] else { it.prefix() },
            [#it.body() #h(1fr) #it.page()],
          ),
        ),
      ),
    )
    show outline.entry.where(level: 3): it => strong(it)
    show outline.entry.where(level: 4): it => strong(emph(it))

    outline(
      title: [Índice General],
      depth: 4,
      indent: 0.75em,
    )
  }

  set math.equation(numbering: "1.")

  context {
    if (counter(figure.where(kind: table)).final().at(0) != 0) {
      outline(
        title: [Índice de Tablas],
        target: figure.where(kind: table),
      )
    }

    if (counter(figure.where(kind: image)).final().at(0) != 0) {
      outline(
        title: [Índice de Figuras],
        target: figure.where(kind: image),
      )
    }

    if (counter(figure.where(kind: math.equation)).final().at(0) != 0) {
      outline(
        title: [Índice de Expresiones Matemáticas],
        target: figure.where(kind: math.equation),
      )
    }

    if (counter(heading.where(supplement: [Anexo])).final().at(0) != 0) {
      outline(
        title: [Índice de Anexos],
        target: selector(heading.where(supplement: [Anexo])),
      )
    }
  }


  set page(numbering: "1")

  set page(header: context hydra(2, display: (_, it) => upper(it.body)))

  set bibliography(style: "american-psychological-association")
  show bibliography: set heading(level: 2)

  // Part section settings
  show heading.where(level: 1): set heading(numbering: "I.")

  body
}

#let contenido-principal(
  body,
) = (
  context {
    show heading.where(level: 2): set heading(supplement: [Capítulo])
    set heading(numbering: (first, ..n) => (numbering("I.1.", ..n)))
    show heading.where(level: 1): it => {
      {
        set page(
          numbering: none,
          header: none,
        )

        align(horizon + center)[
          #line(length: 75%, stroke: 0.5pt)

          #v(1fr)

          #text(
            font: "Libertinus Sans",
            size: 1.3em,
            weight: "regular",
            tracking: 0.1em,
            fill: gray.darken(40%),
          )[PARTE]

          #v(0.8cm)
          #align(center)[
            #polygon(
              fill: gray.darken(20%),
              (0pt, 3pt),
              (3pt, 0pt),
              (0pt, -3pt),
              (-3pt, 0pt),
            )
          ]
          #v(0.8cm)

          #text(
            font: "Libertinus Serif",
            size: 4.8em,
            weight: "bold",
            fill: black,
          )[#counter(heading).display("I")]

          #v(2cm)

          #block(width: 70%)[
            #align(center)[
              #text(
                font: "Libertinus Serif",
                size: 2.2em,
                weight: "regular",
                style: "italic",
                fill: black,
              )[#it.body]
            ]
          ]

          #v(1fr)

          #line(length: 75%, stroke: 0.5pt)

        ]
      }

      let chapters = chapter-counter.get()
      counter(heading).update((one, ..n) => (one, ..chapters))
    }
    show heading.where(level: 2): it => {
      {
        chapter-counter.step(level: 1)
        set page(
          numbering: none,
          header: none,
        )

        set par(spacing: 1.5em)

        align(center + horizon)[
          #line(length: 55%, stroke: 0.4pt)

          #v(2cm)

          #text(
            font: "Libertinus Sans",
            size: 1.2em,
            weight: "regular",
            tracking: 0.1em,
            fill: gray.darken(30%),
          )[#it.supplement]

          #v(0.5cm)

          #text(
            font: "Libertinus Serif",
            size: 3.5em,
            weight: "bold",
          )[#context chapter-counter.display("I").trim(".")]

          #v(1.2cm)

          #block(width: 75%)[
            #align(center)[
              #text(
                font: "Libertinus Serif",
                size: 2.5em,
                weight: "regular",
              )[#smallcaps(it.body)]
            ]
          ]

          #v(2cm)

          #polygon(
            fill: gray.darken(15%),
            (0pt, 3pt),
            (3pt, 0pt),
            (0pt, -3pt),
            (-3pt, 0pt),
          )
        ]
      }

      smallcaps(it)
    }

    body
  }
)

#let anexos(
  body,
) = (
  context {
    counter(heading.where(level: 1)).update(0)
    chapter-counter.update(0)
    set heading(supplement: [Anexo])
    set heading(numbering: (first, ..n) => (numbering("A.1.", ..n)))

    show heading.where(level: 1): it => {
      {
        set page(
          numbering: none,
          header: none,
        )

        align(horizon + center)[
          #line(length: 75%, stroke: 0.5pt)

          #v(1fr)

          #text(
            font: "Libertinus Sans",
            size: 1.3em,
            weight: "regular",
            tracking: 0.1em,
            fill: gray.darken(40%),
          )[PARTE]

          #v(0.8cm)
          #align(center)[
            #polygon(
              fill: gray.darken(20%),
              (0pt, 3pt),
              (3pt, 0pt),
              (0pt, -3pt),
              (-3pt, 0pt),
            )
          ]
          #v(0.8cm)

          #text(
            font: "Libertinus Serif",
            size: 4.8em,
            weight: "bold",
            fill: black,
          )[#counter(heading).display("I")]

          #v(2cm)

          #block(width: 70%)[
            #align(center)[
              #text(
                font: "Libertinus Serif",
                size: 2.2em,
                weight: "regular",
                style: "italic",
                fill: black,
              )[#it.body]
            ]
          ]

          #v(1fr)

          #line(length: 75%, stroke: 0.5pt)

        ]
      }

      let chapters = chapter-counter.get()
      counter(heading).update((one, ..n) => (one, ..chapters))
    }

    show heading.where(level: 2): it => {
      {
        chapter-counter.step(level: 1)
        set page(
          numbering: none,
          header: none,
        )

        set par(spacing: 1.5em)

        align(center + horizon)[
          #line(length: 55%, stroke: 0.4pt)

          #v(2cm)

          #text(
            font: "Libertinus Sans",
            size: 1.2em,
            weight: "regular",
            tracking: 0.1em,
            fill: gray.darken(30%),
          )[#it.supplement]

          #v(0.5cm)

          #text(
            font: "Libertinus Serif",
            size: 3.5em,
            weight: "bold",
          )[#context chapter-counter.display("A").trim(".")]

          #v(1.2cm)

          #block(width: 75%)[
            #align(center)[
              #text(
                font: "Libertinus Serif",
                size: 2.5em,
                weight: "regular",
              )[#smallcaps(it.body)]
            ]
          ]

          #v(2cm)

          #polygon(
            fill: gray.darken(15%),
            (0pt, 3pt),
            (3pt, 0pt),
            (0pt, -3pt),
            (-3pt, 0pt),
          )
        ]
      }

      smallcaps(it)
    }

    body
  }
)
