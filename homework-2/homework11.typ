#import "../template.typ": *

#show: project.with(
  course: "Calculus II",
  course_fullname: "Calculus (A) II",
  course_code: "821T0160",
  title: "Homework #11: 重积分",
  authors: (
    (
      name: "Yulun WU",
      email: "memset0@outlook.com",
      id: "#198",
    ),
  ),
  semester: "Spring-Summer 2024",
  date: "May 7th, 2024",
)

#let iintd = iintb($D$)
#let iints = iintb($S$)
#let iintsg = iintb($sigma$)
#let iiintv = iiintb($V$)
#let iiintog = iiintb($Omega$)

= 习题9-3
== P171 2(2)
#prob[
  利用适当方法计算三重积分：
  $
    iiintv (x^2 + y^2 + z^2) dif V
  $
  其中 $V$：$a^2 <= x^2 + y^2 + z^2 <= b^2,space z >= 0$。
]

令
$
  cases(
		x = r sin theta cos psi,
		y = r sin theta sin psi,
		z = r cos theta,
	)
$
则
$
  iiintv (x^2 + y^2 + z^2) dif V
  &= int_0^(2 pi) dif theta int_0^(pi / 2) dif psi int_a^b r^2 dot r^2 sin psi dif r\
  &= int_0^(2 pi) dif theta int_0^(pi / 2) sin psi dif psi int_a^b r^4 dif r\
  &= (2 pi) / 5 (b^2 - a^2)
$

== P172 2(4)
#prob[
  利用适当方法计算三重积分：
  $
    iiintb(Omega) (x+z) dif V
  $
  其中 $Omega$ 是由曲面 $z=sqrt(x^2 + y^2)$ 与 $z=sqrt(1-x^2-y^2)$ 所围成的区域。
]

由对称性得
$
  iiintb(Omega) x dif V = 0
$
用球面坐标公式代换，可解得 $0<=psi<=display(pi/4)$，故
$
  iiintb(Omega) (x+z) dif V
  = iiintb(Omega) z dif V
  = int_0^(2 pi) dif theta int_0^(pi / 4) dif psi int_0^1 r cos psi dot r^2 sin psi dif r = pi / 8
$

== P172 3
#prob[
  求函数 $f(x,y,z) = x^2 + y^2 + z^2$ 在区域 $x^2 + y^2 + z^2 <= x+y+z$ 内的平均值。
]
令
$
  Omega
  &= {(x,y,z) : x^2+y^2+z^2 <= x+y+z}\
  &= {(x,y,z) : (x-1 / 2)^2 + (y-1 / 2)^2 + (z-1 / 2)^2 <= 3 / 4}
$
故
$
  iiintog dif Omega = 4 / 3 pi (sqrt(3/4))^3 = sqrt(3) / 2 pi
$
令
$
  cases(
		display(x = 1/2 + r sin theta cos psi),
		display(y = 1/2 + r sin theta sin psi),
		display(z = 1/2 + r cos theta),
	)
$
得
$
  iiintog f(x,y,z) dif Omega
  &= iiintog (r^2 + x+y+z- 3 / 4) dif Omega\
  &= iiintog (r^2 + 3 / 4 + r sin theta cos psi + r sin theta sin psi + r cos theta) dif Omega\
  &= int_(0)^(2 pi) dif theta int_0^(pi) dif psi int_0^(sqrt(3) / 2) (r^2 + 3 / 4) r^2 sin psi dif r\
  &= 4pi (1 / 5 (sqrt(3) / 2)^5 + 1 / 4 (sqrt(3) / 2)^3)
  = (3sqrt(3)) / 5 pi
$
故
$
  overline(f)
  = display(iiintog f(x,y,z) dif Omega) / display(iiintog dif Omega)
  = display((3sqrt(3))/5 pi) / display(sqrt(3)/2 pi)
  = 6 / 5
$

== P172 7
#prob[
  计算积分 $iiintb(Omega) (x+y+z)^2 dif V$，其中 $Omega:space x^2 + y^2 + z^2 <= R$。
]
由对称性可知
$
  iiintog x y dif Omega = iiintog x z dif Omega = iiintog y z dif Omega = 0
$
故
$
  I = iiintog (x+y+z)^2 dif Omega
  = iiintog (x^2 + y^2 + z^2) dif Omega
$
用球面坐标公式代换得
$
  I = int_0^(2 pi) dif theta int_0^(pi) dif psi int_0^R r^4 sin psi dif r
  = 4 / 5 pi R^5
$

= 习题9-4
== P178 1(1)
#prob[
  计算第一类曲线积分
  $
    intb(C) y^2 dif s
  $
  其中 $C$ 为摆线 $x=a (t - sin t),space y = a (1 - cos t) space (0<=t<=2 pi)$ 的一拱。
]

$
  & x'(t) = a (1-cos t); quad quad y'(t) = a sin t \
  ==> & dif s = sqrt(a^2 (1-cos t)^2 + a^2 sin^2 t) dif t = 2 a sin t / 2 dif t
$
故
$
  intb(C) y^2 dif S
  &= 2 a^3 int_0^(2pi) sin t / 2 (1-cos t)^2 dif t
  = 32 a^3 int_0^(pi / 2) sin^5 t dif t
  = 32 a^3 dot 4 / 5 dot 2 / 3 dot 1 = 256 / 15 a^3
$

== P178 1(3)
#prob[
  计算第一类曲线积分
  $
    intb(C) abs(y) dif s
  $
  其中 $C$ 为双纽线 $(x^2 + y^2)^2 = a^2 (x^2 - y^2)$ 的弧。
]

作极坐标代换
$
  x = r cos theta; quad quad y = r sin theta
$
得：
$
  (r^2 cos^2 theta + r^2 sin^2 theta)^2 &= a^2 (r^2 cos^2 theta - r^2 sin^2 theta) \
  ==> r^4 &= a^2 r^2 (cos^2 theta - sin^2 theta)\
  ==> r &= pm a sqrt(cos^2 theta - sin^2 theta)
$
故：
$
  (dif r) / (dif theta) = mp (2 a cos theta sin theta) / sqrt(cos^2 theta - sin^2 theta)
$
代入弧微分公式得：
$
  dif s
  &= sqrt(r^2 + r'^2 )dif theta
  = sqrt(a^2 (cos^2 theta - sin^2 theta) + 4 a^2 (cos^2 theta sin^2 theta)/(cos^2 theta - sin^2 theta)) dif theta\
  &= a sqrt((cos^2 theta + sin^2 theta)^2/(cos^2 theta - sin^2 theta)) dif theta
  = a / sqrt(cos 2 theta) dif theta
$
故
$
  intb(C) abs(y) dif s
  &= 4 int_0^(pi / 4) abs(r sin theta) (a dif theta) / (cos 2 theta)
  = 4 int_0^(pi / 4) a sqrt(cos 2 theta) sin theta dot a / sqrt(cos 2 theta) dif theta\
  &= 4 a^2 int_0^(pi / 4) sin theta dif theta
  = 2a^2 (2-sqrt(2))
$

#align(center, image("images/2024-05-29-19-39-08.png", width: 60%))

== P178 1(5)
#prob[
  计算第一类曲线积分
  $
    intb(C) (x^2 + y^2 + 1) dif s
  $
  其中 $C$ 为曲线 $display(cases(
		x^2 + y^2 + z^2 = 5,
		z = x^2 + y^2 + 1
	))$
]

化简得
$
  & x^2 + y^2 = 5 - z^2 = z-1\
  ==>quad &z^2 + z - 6 = (z-2)(z+3) = 0\
  ==>quad &z = 2 quad (z>1)
$
故曲线即 $x^2 + y^2 = 1$。
$
  intb(C) (x^2+y^2+1) dif s = intb(C) 2 dif s = 2 dot 2 pi = 4pi
$

= 习题9-5
== P189 5
#prob[
  设球在动点 $P(x,y,z)$ 的密度与该点至球心的距离成正比，求质量为 $M$ 的非均质球体 $x^2 + y^2 + z^2 <= R^2$ 对其直径的转动惯量。
]
设密度函数 $rho(r) = k r$，则
$
  M
  &= iiintv dif m
  = k iiintv r dif V
  = int_0^(2 pi) dif phi int_0^pi dif theta int_0^R r^3 sin theta dif r
  = k dot R^4 / 4 dot 2pi dot 2 = k pi R^4
$
另根据转动惯量公式得
$
  J
  &= iiintv r^2 dif m
  = k iiintv r^3 dif V
  = int_0^(2 pi) dif phi int_0^pi dif theta int_0^R r^5 sin theta dif r
  = k dot R^6 / 6 dot 2 pi dot 2 = 2 / 3 k pi R^6
$
代入得
$
  J = 2 / 3 M R^2
$
// #correction[
//   答案应该是 $display(4/9 M R^2)$（还没看出来哪错了）。
// ]

== P189 6
#prob[
  求由曲面 $z=sqrt(x^2 + y^2),space z=1,space z=2$ 所围成的均质立体对质量为 $m$ 的质点 $A(0,0,0)$ 的引力，其中体密度为 $mu$。
]

作柱面坐标代换
$
  x = r cos theta; quad y = r sin theta; quad z = z quad (0<=theta<=2pi,space 0<=r<=z)
$
则万有引力为
$
  F
  &= iiintv (G m) / (x^2 + y^2 + z^2) dif M
  = int_1^2 dif z int_0^(2 pi) dif theta int_0^(z) (G m) / (r^2 + z^2) r dif r \
  &= 2 pi int_1^2 pi / (4 z) dif z
  = (pi^2) / 2 ln(2)
$

// #correction[
//   好像算的也不对啊
// ]