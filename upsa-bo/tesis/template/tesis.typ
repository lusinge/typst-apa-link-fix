#import "../lib.typ": *

#show: tesis.with(
  título: [Estudio de Factibilidad],
  materia: [SIGLA: Proyectos],
  fecha: [Segundo Semestre, 2024],
  docente: [Ing. Docente Nombre],
  estudiantes: [
    Estudiante 1 Nombre#super[4] \
    Estudiante 2 Nombre#super[5] \
  ],
  facultades-carreras: [
    #super[4] FAI: Facultad de Ingeniería, Ingeniería de Sistemas \
    #super[5] FAI: Facultad de Ingeniería, Ingeniería Industrial y de Sistemas \
  ],
  abstracto: lorem(50),
  resumen-ejecutivo: lorem(50),
)
