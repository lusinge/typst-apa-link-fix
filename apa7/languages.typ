#let get-terms(language) = {
  if language == "en" {
    (
      "and": "and",
      "Author Note": "Author Note",
      "Abstract": "Abstract",
      "Keywords": "Keywords",
      "Appendix": "Appendix",
    )
  } else if language == "es" {
    (
      "and": "y",
      "Author Note": "Nota del autor",
      "Abstract": "Resumen",
      "Keywords": "Palabras clave",
      "Appendix": "Apéndice",
    )
  } else if language == "de" {
    (
      "and": "und",
      "Author Note": "Autorennotiz",
      "Abstract": "Zusammenfassung",
      "Keywords": "Schlüsselwörter",
      "Appendix": "Anhang",
    )
  } else if language == "pt" {
    (
      "and": "e",
      "Author Note": "Nota do autor",
      "Abstract": "Resumo",
      "Keywords": "Palavras-chave",
      "Appendix": "Apêndice",
    )
  } else {
    panic("Unsupported language:", language)
  }
}