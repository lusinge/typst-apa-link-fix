#import "languages.typ": *

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

#let final-authors(authors, custom-authors) = {
  if authors != (:) and custom-authors != [] {
    panic("Authors and custom-authors cannot both be defined.")
  }

  if authors == (:) and (custom-authors == [] or custom-authors == none) {
    panic("At least one author must be defined.")
  }

  if authors != (:) {
    authors
  } else {
    custom-authors
  }
}

#let is-multiple-authors-with-different-affiliations(authors, affiliations) = {
  // check if the authors have a different length of affiliations
  let author-affiliations-length = authors.map(it => it.affiliations.len())
  for i in author-affiliations-length {
    if i != author-affiliations-length.first() {
      return true
    }
  }

  // if the authors have the same length of affiliations, check if the affiliations are the same
  let seen-affiliations = ()
  for author in authors.map(it => it.affiliations) {
    for id in author {
      if id not in seen-affiliations {
        seen-affiliations.push(id)

        if seen-affiliations.len() > author.len() {
          return true
        }
      }
    }
  }

  return false
}

#let print-authors-with-different-affiliations(authors, affiliations, language) = {
  affiliations = enumerate-affiliations(affiliations)
  
  let aff-positions = (:)
  for aff in affiliations {
    aff-positions.insert(aff.id, str(aff.n))
  }

  let upd-auth = ()
  for auth in authors {
    let upd-aff = ()
    for aff in auth.affiliations {
      upd-aff.push((
        id: aff,
        n: aff-positions.at(aff)
      ))
    }

    upd-auth.push((
      name: auth.name,
      affiliations: upd-aff
    ))
  }

  if upd-auth.len() == 2 [
    #upd-auth.at(0).name
    #get-terms(language).and
    #upd-auth.at(1).name
  ] else {
    for upd in upd-auth {
      upd.name

      for aff in upd.affiliations {
        if aff != upd.affiliations.last() {
          super[#aff.n, ]
        } else {
          super[#aff.n]
        }
      }

      if upd.name == upd-auth.at(-2).name {
        [ #get-terms(language).and ]
      } else if upd.name == upd-auth.last().name {
      } else {
        [, ]
      }
    }
  }
}

#let print-authors(authors, affiliations, language) = {
  if type(authors) != content and type(authors) != str {
    if authors.len() == 1 { // single author
      authors.at(0).name
    } else if is-multiple-authors-with-different-affiliations(authors, affiliations) { // multiple authors with different affiliations
      print-authors-with-different-affiliations(authors, affiliations, language)
    } else { // multiple authors with shared affiliations
      if authors.len() == 2 [
        #authors.at(0).name
        #get-terms(language).and
        #authors.at(1).name
      ] else {
        let author-names = authors.map(it => it.name)
        for i in author-names {
          if i == author-names.last() [
            #get-terms(language).and #i
          ] else [
            #i,
          ]
        }
      }
    }
  } else {
    authors
  }
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

