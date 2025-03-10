#import "@preview/hydra:0.6.0": hydra
#import "./utils/to-string.typ": *

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
      right: 2.5cm,
      y: 2.5cm,
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
  show heading: set par(leading: 1.5em)

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

    #rect(radius: 20%, inset: 10pt)[_"#título"_]

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
    heading([Agradecimientos], numbering: none)
    agradecimientos
  } else {
    pagebreak(to: "odd", weak: true)
  }

  counter(page).update(1)

  set page(numbering: "i")

  if (plan == [] or plan == none) {
    heading([Abstracto], numbering: none)
    table(
      align: (left + horizon, left),
      columns: 2,
      [*Título*], título,
      [*Autor*], autor,
    )

    if (problemática != []) {
      heading([Problemática], numbering: none)
      problemática
    }

    if (objetivo-general != []) {
      heading([Objetivo General], numbering: none)
      objetivo-general
    }

    if (contenido != []) {
      heading([Contenido], numbering: none)
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

  show heading.where(level: 1): it => {
    pagebreak()
    it
  }

  if ((type(resumen) == content and resumen != []) or (type(resumen) == str and resumen != "")) {
    heading([Resumen], numbering: none)
    resumen
  }

  if (
    (type(resumen-ejecutivo) == content and resumen-ejecutivo != [])
      or (
        type(resumen-ejecutivo) == str and resumen-ejecutivo != ""
      )
  ) {
    heading([Resumen Ejecutivo], numbering: none)
    resumen-ejecutivo
  }

  {
    show outline.entry.where(level: 1): it => strong(it)
    show outline.entry.where(level: 2): it => strong(emph(it))
    show outline.entry.where(level: 3): it => emph(it)

    outline(
      title: [Índice General],
      target: heading.where(outlined: true).or(figure.where(kind: "part")),
      indent: 0em,
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

  show heading.where(level: 1): set heading(supplement: [Capítulo])

  set page(header: context hydra(1, display: (_, it) => upper(it.body)))

  set bibliography(style: "american-psychological-association")

  body
}

#let parte(título) = figure(
  kind: "part",
  supplement: [Parte],
  caption: título,
)[]

#let contenido-principal(
  body,
) = (
  context {
    show heading.where(level: 1): it => {
      {
        set page(
          numbering: none,
          header: none,
        )

        set par(spacing: 1.5em)

        align(center + horizon)[
          #text(size: 2.25em)[#it.supplement #context counter(heading).display("I").trim(".")]

          #text(size: 2.75em)[#it.body]
        ]
      }

      it
    }
    body
  }
)

#let anexos(
  body,
) = (
  context {
    counter(heading).update(0)
    show heading: set heading(supplement: [Anexo])
    show heading: set heading(numbering: "A.")

    show heading.where(level: 1): it => {
      {
        set page(
          numbering: none,
          header: none,
        )

        set par(spacing: 1.5em)

        align(center + horizon)[
          #text(size: 2.25em)[#it.supplement #counter(heading).display().trim(".")]

          #text(size: 2.75em)[#it.body]
        ]
      }

      it
    }

    body
  }
)
