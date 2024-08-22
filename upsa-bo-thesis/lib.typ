#import "utils/utils.typ": *

#let tesis(
  facultad: str,
  carrera: str,
  modalidad: str,
  titulo: str,
  nombres: str,
  apellidos: str,
  registro: str,
  year: str,
  body
) = {
  set document(
    title: titulo,
    author: nombres + apellidos,
  )

  set page(
    paper: "us-letter",
    margin: (
      top: 0.98in,
      bottom: 0.98in,
      right: 0.98in,
      left: 1.58in,
    )
  )

  max-15-words(title: titulo)
  validar-registro(registro: registro)

  set text(
    size: 12pt,
    font: "Arial",
    lang: "es",
    region: "bo",
  )

  align(center)[
    #set text(
      size: 14pt,
      weight: "bold",
      font: "Arial",
    )
    
    #figure(
      image("assets/images/logo-upsa.png")
    )
    
    #v(1fr)
    
    #upper(facultad) \
    CARRERA: #upper(carrera)
    
    #v(1fr)
    
    MODALIDAD DE GRADUACIÓN \
    #upper(modalidad) \
    
    #v(1fr)
    
    #upper(titulo)

    #v(1fr)

    Proyecto de Grado para optar al título de \
    Licenciado(a) en #carrera

    #v(1fr)

    #nombres #apellidos \

    #text(size: 12pt)[
      Reg.: #registro
      
      #v(1fr)
      
      Santa Cruz de la Sierra - Bolivia \
      #year
    ]
  ]

  pagebreak()
  body
}
