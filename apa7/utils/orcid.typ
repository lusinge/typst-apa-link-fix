#let include-orcid(author, orcid) = {
  if orcid != none [
    #author
    #box(height: 1em, image("../assets/img/ORCID_iD.svg.png", width: 2.5%),)
    #link("https://orcid.org/" + orcid)
  ] else {
    author
  }
}
