#import "../template.typ": *

#show: project.with(
  course: "Calculus II",
  course_fullname: "Calculus (A) II",
  course_code: "821T0160",
  title: "Homework #12: 第一类曲线积分 & 第二类曲线积分",
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

= 习题9-4
== P178 3(1)
#prob[
  计算第一类曲线积分：
  $
    iints (x+y+z) dif S
  $
  其中 $S$ 为曲面 $x^2 + y^2 + z^2 = a^2$，$z>=0$。
]

== P178 3(3)
#prob[
  计算第一类曲线积分：
  $
    iints abs(x y z) dif S
  $
  其中 $S$ 为曲面 $z=x^2 + y^2$ 被平面 $z=1$ 所割下的部分。
]

== P178 4
#prob[
  求抛物面壳 $display(z = 1/2 (x^2 + y^2) space (0<=z<=1))$ 的质量此壳的密度按规律 $rho = z$ 而变化。
]

= 习题10-1
== P212 1(1)
#prob[
  计算第二类曲线积分：
  $
    intb(c) (x^2 + y^2) dx + (x^2 - y^2) dy
  $
  其中 $c$ 为曲线 $y=1-abs(1-x) space (0<=x<=2)$ 沿参数增加的方向。
]

== P212 1(3)
#prob[
  计算第二类曲线积分：
  $
    intcb(C) ((x+y) dx - (x-y) dy) / (x^2 + y^2)
  $
  其中 $C$ 沿逆时针方向通过圆周 $x^2 + y^2 = a^2$。
]

== P212 1(5)
#prob[
  计算第二类曲线积分：
  $
    intcb(overline(O A B C O)) arctan y / x dy - dx
  $
  其中 $overline(O A B)$ 为抛物线段 $y=x^2$，$overline(B C O)$ 为直线段 $y=x$，$B$ 点坐标为 $(1,1)$。
]

== P212 2(1)
#prob[
  计算第二类曲线积分：
  $
    intb(C) (y^2 - z^2) dx + 2y z dy - x^2 dz
  $
  其中 $C$ 为曲线 $x=t,space y=t^2,space z=t^3 space(0<=t<=1)$ 依参数增加的方向。
]

== P212 2(3)
#prob[
  计算第二类曲线积分：
  $
    intb(C) (y^2 - z^2) dx + (z^2 - x^2) dy + (x^2 - y^2) dz
  $
  其中 $C$ 为维维安尼曲线 $x^2+y^2+z^2=a^2, space x^2+y^2=a x space (z>=0, space a>0)$，从 $O x$ 轴的方向看去，此曲线是沿逆时针方向进行的。
]