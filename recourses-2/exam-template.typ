

#let prob_counter = state("prob_counter", 0)
#let prob(x) = {
  prob_counter.update(x => x + 1)
  strong({
    text("Problem ")
    prob_counter.display()
    text(". ")
  })
  x
  v(1fr)
}
#let options(columns: 1, ..content) = {
  let buffer = ()
  for i in range(0, content.pos().len()) {
    buffer.push({
      text("(")
      str.from-unicode(65 + i)
      text(") ")
      content.pos().at(i)
    })
  }
  if columns != 1 {
    columns = range(columns).map(x => 1fr)
  }
  table(
    columns: columns,
    stroke: 0pt,
    row-gutter: 1em,
    inset: 0pt,
    ..buffer,
  )
}