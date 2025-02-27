#import "../lib.typ": *

#show: tesis.with(
  autor: [Nombre del Autor],
  carrera: [Nombre de la Carrera],
  facultad: [Nombre de la Facultad],
  título: [Título del Proyecto de Grado],
  registro-autor: [Registro del Autor],
  guía: [Nombre del Guía],
  email: [Correo Electrónico],
  palabras-clave: ("Palabra Clave 1", "Palabra Clave 2", "Palabra Clave 3"),
)

#contenido-principal[
  = Introducción
  #lorem(50)
]
