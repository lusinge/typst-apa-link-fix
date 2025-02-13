#import "../lib.typ": *

#let carrera = "Ingeniería de Sistemas"
#let modalidad = "Proyecto de Grado"

#show: tesis.with(
  título: [Tesis],
  materia: [Modalidad de Graduación:\ Proyecto de Grado],
  fecha: [Segundo Semestre, 2024],
  guía: [Ing. Docente Nombre],
  grado: [#modalidad para optar al Título de\ Licenciado en #carrera],
  autor: [Nombre Apellido\ Reg.: 2021117600],
  facultad: [FAI: Facultad de Ingeniería\ Carrera: Ingeniería de Sistemas],
  portada-externa: false,
  abstracto: lorem(50),
  resumen-ejecutivo: lorem(50),
  agradecimientos: lorem(10),
)

#contenido-principal[
  = Introducción
  #lorem(50)
]
