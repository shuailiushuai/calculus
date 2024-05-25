#let intb(x) = []
#let iintb(x) = []
#let iiintb(x) = []

#let project(body, ..args) = {
  body
}

#let definition(x, name: "") = [#x]
#let theorem(x, name: "") = [#x]
#let lemma(x, name: "") = [#x]
#let corollary(x, name: "") = [#x]
#let property(x, name: "") = [#x]
#let conclusion(x, name: "") = [#x]
#let problem(x, name: "") = [#x]
#let solution(x, tag: "解") = [#x]