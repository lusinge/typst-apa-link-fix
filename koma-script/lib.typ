#let koma-script(title: [], class: "scrartcl", body) = {
  if class not in ("scrartcl", "scrreprt", "scrbook") {
    panic("koma-script: class must be one of 'scrartcl', 'scrreprt', 'scrbook'")
  }

  body
}

#show: koma-script.with(title: [KOMA-script])

= Intro
== Forearm
