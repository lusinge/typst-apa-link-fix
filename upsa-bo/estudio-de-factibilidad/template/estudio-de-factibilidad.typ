#import "../lib.typ": *

#show: estudio-de-factibilidad.with(
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
  bibliografía: "referencias.yml",
)

#[
  #show: contenido-principal.with()
  
  #include "capítulos/1.introducción.typ"
  #include "capítulos/2.marco teórico.typ"
  #include "capítulos/3.diagnóstico interno de la empresa.typ"
  #include "capítulos/4.estudio de la materia prima e insumos.typ"
  #include "capítulos/5.estudio de mercado.typ"
  #include "capítulos/6.localización y tamaño.typ"
  #include "capítulos/7.estudio de ingeniería.typ"
  #include "capítulos/8.inversiones.typ"
  #include "capítulos/9.presupuesto de ingresos y costos.typ"
  #include "capítulos/10.financiamiento.typ"
  #include "capítulos/11.evaluación social y ambiental.typ"
  #include "capítulos/12.diseño de la organización.typ"
  #include "capítulos/13.evaluación económica y financiera.typ"
  #include "capítulos/14.conclusiones y recomendaciones.typ"
]

#bibliography(
  "referencias.yml",
  full: true,
  title: [Bibliografía],
  style: "apa",
)

#show: anexos.with()

= Instrumentos para la Recolección de Información
== Guías de Entrevistas
== Cuestionarios
== Etc.
= Propios de la Investigación
= Cálculos, Tablas, Cotizaciones, Etc.
= Curriculum Vitae
