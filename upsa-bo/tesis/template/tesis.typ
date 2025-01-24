#import "../lib.typ": *

#show: tesis.with(
  título: [Tesis],
  materia: [Modalidad de Graduación:\ Proyecto de Grado],
  fecha: [Segundo Semestre, 2024],
  guía: [Ing. Docente Nombre],
  // Proyecto de Grado para optar por el título de {Carrera}
  autor: [Nombre Apellido\ Reg.: 2021117600],
  facultad: [FAI: Facultad de Ingeniería, Ingeniería de Sistemas],
  abstracto: lorem(50),
  resumen-ejecutivo: lorem(50),
)

#contenido-principal[
  = Introducción
  #lorem(50)
]