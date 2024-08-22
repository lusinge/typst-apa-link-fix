#let final-affiliations(affiliations, custom-affiliations) = {
  if affiliations != (:) and custom-affiliations != [] {
    panic("Affiliations and custom-affiliations cannot both be defined.")
  }

  if affiliations == (:) and (custom-affiliations == [] or custom-affiliations == none) {
    panic("At least one affiliation must be defined.")
  }

  if affiliations != (:) {
    affiliations
  } else {
    custom-affiliations
  }
}

#let enumerate-affiliations(affiliations) = {
  let count = 1
  for affiliation in affiliations {
    affiliations.at(count - 1).insert("n", count)
    count += 1
  }

  return affiliations
}

#let print-affiliations(authors, affiliations) = {
  if type(affiliations) != content and type(affiliations) != str {
    if affiliations.len() == 1 {
      affiliations.at(0).name
    } else if is-multiple-authors-with-different-affiliations(authors, affiliations) {
      for affiliation in enumerate-affiliations(affiliations) [
        #super[#affiliation.n] #affiliation.name
        #parbreak()
      ]
    } else {
      for aff in affiliations {
        aff.name
        parbreak()
      }
    }
  } else {
    affiliations
  }
}
