#import "../lib.typ": *

#show: tesis.with(
  facultad: "Facultad de Ingeniería",
  carrera: "Ingeniería de Sistemas",
  modalidad: "Proyecto de Grado",
  titulo: "Título del trabajo\n(máximo 15 palabras)",
  nombres: "Nombres",
  apellidos: "Apellidos",
  registro: str(datetime.today().year()) + "123456",
  year: datetime.today().year()
)

= Introducción
#lorem(500)
