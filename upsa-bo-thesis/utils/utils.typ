#let max-15-words(title: str) = {
  if (title.split(" ").len() > 15) {
    panic("El título no puede tener más de 15 palabras.")
  }
}

#let validar-registro(registro: str) = {
  if (registro.contains(regex("^\d{10}$")) == false) {
    panic("El número de registro debe tener 10 dígitos.")
  }
}
