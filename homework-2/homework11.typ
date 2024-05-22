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
  = int_0^(2 pi) dif theta int_0^(pi/4) dif psi int_0^1 r cos psi dot r^2 sin psi dif r = pi/8
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
I =  int_0^(2 pi) dif theta int_0^(pi) dif psi int_0^R r^4 sin psi dif r
= 4/5 pi R^5
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

== P178 1(3)
#prob[
  计算第一类曲线积分
  $
    intb(C) abs(y) dif s
  $
  其中 $C$ 为双纽线 $(x^2 + y^2)^2 = a^2 (x^2 - y^2)$ 的弧。
]

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

= 习题9-5
== P189 5
#prob[
  设球在动点 $P(x,y,z)$ 的密度与该点至球心的距离成正比，求质量为 $M$ 的非均质球体 $x^2 + y^2 + z^2 <= R^2$ 对其直径的转动惯量。
]

== P189 6
#prob[
  求由曲面 $z=sqrt(x^2 + y^2),space z=1,space z=2$ 所围成的均质立体对质量为 $m$ 的质点 $A(0,0,0)$ 的引力，其中体密度为 $mu$。
]