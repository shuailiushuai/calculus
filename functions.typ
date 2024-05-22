#let prob(bgcolor: luma(252), border: luma(88), text) = block(
  fill: bgcolor,
  width: 100%,
  inset: 1em,
  radius: 3pt,
  stroke: border + 0.5pt,
  text
)

#let def(x) = { text("【" + x + "】", weight: "bold") }
#let deft(x) = { text("【" + x + "】", weight: "bold", fill: rgb("#FFFFFF")) }
#let bb(x) = { text(x, weight: "bold") }


#let badge(content, fill: rgb("#000000")) = box(
	fill: fill,
	radius: 4pt,
	inset: 1pt,
	outset: 3pt,
	text(
		content,
		weight: "bold",
		size: 10pt,
		fill: rgb("#ffffff")
	)
)

#let ac = badge("Correct", fill: rgb("#25ad40"))
#let pc = badge("Partially Correct", fill: rgb("#01bab2"))
#let wa = badge("Wrong Answer", fill: rgb("#ff4f4f"))
#let un = badge("Unknown", fill: rgb("#5c5c5c"))



#let dp = math.display
#let sp = math.space
#let eps = math.epsilon
#let sim = "~ "
#let st = "s.t. "
#let pm = math.plus.minus
#let mp = math.minus.plus

#let dx = math.upright("d") + math.italic("x")
#let dy = math.upright("d") + math.italic("y")
#let dz = math.upright("d") + math.italic("z")
#let dt = math.upright("d") + math.italic("t")
#let du = math.upright("d") + math.italic("u")
#let dv = math.upright("d") + math.italic("v")
#let px = $partial x$
#let py = $partial y$
#let pz = $partial z$
#let pu = $partial u$
#let pv = $partial v$
#let ps = $partial s$
#let pt = $partial t$
#let pf = $partial f$
#let Dx = math.Delta + math.italic("x")
#let Dy = math.Delta + math.italic("y")
#let Dt = math.Delta + math.italic("t")
#let Du = math.Delta + math.italic("u")
#let Dv = math.Delta + math.italic("v")
#let ddy = math.attach(math.upright("d"), tr: "2") + math.italic("y")
#let dddy = math.attach(math.upright("d"), tr: "3") + math.italic("y")
#let dny = math.attach(math.upright("d"), tr: "n") + math.italic("y")
#let dsg = math.dif + math.sigma

#let arccot = math.op("arccot")

#let defeq = math.attach("=", t: math.Delta)

#let atpos(f, b, t) = $lr(#v(1.5em)display(#f) |)_(#b\ "")^(\ #t)$

#let grad = math.bold(math.upright("grad"))

#let deri(x, y) = $display((dif #x)/(dif #y))$
#let pderi(x, y) = $display((diff #x)/(diff #y))$

#let int = math.integral
#let iint = math.integral.double
#let iiint = math.integral.triple
#let iiiint = math.integral.quad

#let intb(x) = [
	$display(attach(integral, b: #x, br: ""))$
	#set text(size: 0.25em, fill: red.transparentize(100%))
	#x
]
#let iintb(x) = [
	$display(attach(integral.double, b: #x, br: ""))$
	#set text(size: 0.25em, fill: red.transparentize(100%))
	#x
]
#let iiintb(x) = [
	$display(attach(integral.triple, b: #x, br: ""))$
	#set text(size: 0.25em, fill: red.transparentize(100%))
	#x
]
#let iintd = iintb(math.italic("D"))
#let iints = iintb(math.italic("S"))
#let iintsg = iintb(math.sigma)
#let iiintv = iiintb(math.italic("V"))
#let iiintog = iiintb(math.Omega)