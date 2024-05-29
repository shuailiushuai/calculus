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
  计算第一类曲面积分：
  $
    iints (x+y+z) dif S
  $
  其中 $S$ 为曲面 $x^2 + y^2 + z^2 = a^2$，$z>=0$。
]
由题意得
$
  z = sqrt(a^2 - x^2 - y^2),space (x,y) in sigma: x^2 + y^2 <= a^2
$
则
$
  dz / dx = -x / sqrt(a^2 - x^2 - y^2); quad quad
  dz / dy = -y / sqrt(a^2 - x^2 - y^2)
$
代入第一类曲面积分的公式得
$
  iints (x+y+z) dif S
  &= iintsg (x+y+sqrt(a^2 - x^2 - y^2)) sqrt(1+x^2/(a^2 - x^2 - y^2) + y^2/(a^2 - x^2 - y^2)) dif sigma\
  &= iintsg (x+y+sqrt(a^2 - x^2 - y^2)) a / sqrt(a^2 - x^2 - y^2) dx dy\
  &= int_(-a)^a dx int_(-sqrt(a^2 - x^2))^sqrt(a^2 - x^2) (x+y+sqrt(a^2 - x^2 - y^2)) a / sqrt(a^2 - x^2 - y^2) dy\
  &= int_(-a)^a (pi a x + 2 a sqrt(a^2 - x^2)) dif x\
  &= 4a int_0^a sqrt(a^2 - x^2) dx = pi a^3
$

== P178 3(3)
#prob[
  计算第一类曲面积分：
  $
    iints abs(x y z) dif S
  $
  其中 $S$ 为曲面 $z=x^2 + y^2$ 被平面 $z=1$ 所割下的部分。
]
设 $sigma: x^2+y^2<=1, x>=0, y>=0$，由对称性可知
$
  iints abs(x y z) dif S
  = 4 iintsg abs(x y z) sqrt(1+4x^2 + 4y^2) dif sigma
$
作极坐标代换：
$
  x = sqrt(z) cos theta; quad y = sqrt(z) sin theta quad (0<=theta<=pi / 2)
$
则
$
  iints abs(x y z) dif S
  &= 4 int_0^(pi / 2) dif theta int_0^1 abs(sqrt(z) sin theta dot sqrt(z) cos theta dot z) sqrt(1+4z) sqrt(z) dif sqrt(z)\
  &= 2 int_0^(pi / 2) sin theta cos theta dif theta int_0^1 z^2 sqrt(1+4 z) dif z\
  &= int_0^1 z^2 sqrt(1+4z) dif z
  = (125sqrt(5) - 1) / 420
$

== P178 4
#prob[
  求抛物面壳 $display(z = 1/2 (x^2 + y^2) space (0<=z<=1))$ 的质量此壳的密度按规律 $rho = z$ 而变化。
]

= 习题10-1
== P212 1(1)
#prob[
  计算第二类曲线积分：
  $
    intb(C) (x^2 + y^2) dx + (x^2 - y^2) dy
  $
  其中 $C$ 为曲线 $y=1-abs(1-x) space (0<=x<=2)$ 沿参数增加的方向。
]
- 当 $0<=x<=1$ 时，$y = 1 - (1 - x) = x$，$dy = dx$；
- 当 $1<x<=2$ 时，$y = 1 - (x - 1) = -x + 2$，$dy = -dx$。

故：
$
  intb(C) (x^2 + y^2) dx + (x^2 - y^2) dy
  &= int_0^1 2x^2 dx + int_1^2 (x^2 + (2-x)^2) dx - (x^2 - (2-x)^2) dx = 4 / 3
$

== P212 1(3)
#prob[
  计算第二类曲线积分：
  $
    intcb(C) ((x+y) dx - (x-y) dy) / (x^2 + y^2)
  $
  其中 $C$ 沿逆时针方向通过圆周 $x^2 + y^2 = a^2$。
]
作极坐标代换：
$
  x = a cos theta; quad y = a sin theta quad (0<=theta<=2pi)
$
故
$
  intcb(C) ((x+y) dx - (x-y) dy) / (x^2 + y^2)
  &= int_0^(2 pi) ((a cos theta + a sin theta) dif (a cos theta) -
  (a cos theta - a sin theta) dif (a sin theta)) / (a^2)\
  &= int_0^(2 pi) ((cos theta + sin theta) dot (-sin theta) - (cos theta - sin theta) dot cos theta) dif theta\
  &= int_0^(2 pi) -(cos^2 theta + sin^2 theta) dif theta\
  &= - int_0^(2 pi) dif theta
  = - 2pi
$

== P212 1(5)
#prob[
  计算第二类曲线积分：
  $
    intcb(accent(O A B C O, paren.t)) arctan y / x dy - dx
  $
  其中 $accent(O A B, paren.t)$ 为抛物线段 $y=x^2$，$overline(B C O)$ 为直线段 $y=x$，$B$ 点坐标为 $(1,1)$。
]
$
  intcb(accent(O A B C O, paren.t)) (arctan y / x dy - dx)
  &= intb(accent(O A B, paren.t)) (arctan y / x dy - dx)
  + intb(overline(O B C)) (arctan y / x dy - dx)\
  &=int_0^1 (arctan x^2 / x dif (x^2) - dx)
  - int_0^1 (arctan x / x dif x - dx) \
  &= int_0^1 2x arctan x dx - int_0^1 dx - int_0^1 (arctan 1 - 1) dx\
  &= atpos(x^2 arctan x, 0, 1) - int_0^1 (x^2) / (1+x^2) dx - 1 - (pi / 4 - 1) \
  &= pi / 4 - atpos((x - arctan x), 0, 1) - pi / 4\
  &= arctan 1 - 1 = pi / 4 - 1
$

== P212 2(1)
#prob[
  计算第二类曲线积分：
  $
    intb(C) (y^2 - z^2) dx + 2y z dy - x^2 dz
  $
  其中 $C$ 为曲线 $x=t,space y=t^2,space z=t^3 space(0<=t<=1)$ 依参数
  增加的方向。
]
$
  intb(C) (y^2 - z^2) dx + 2y z dy - x^2 dz
  &= int_0^1 (t^4 - t^6) dt + 2 t^5 dot 2 t dt - t^2 dot 3 t^2 dt\
  &= int_0^1 (3 t^6 - 2 t^4) dt = 1 / 35
$

== P212 2(3)
#prob[
  计算第二类曲线积分：
  $
    intb(C) (y^2 - z^2) dx + (z^2 - x^2) dy + (x^2 - y^2) dz
  $
  其中 $C$ 为维维安尼曲线 $x^2+y^2+z^2=a^2, space x^2+y^2=a x space (z>=0, space a>0)$，从 $O x$ 轴的方向看去，此曲线是沿逆时针方向进行的。
]

根据
$
  x^2 + y^2 = a x
  ==> (x-a / 2)^2 + y^2 = (a / 2)^2
$
作极坐标代换
$
  x = a / 2 + a / 2 cos t; quad y = a / 2 sin t;
$
$
  z
  &= sqrt(a^2 - x^2 - y^2)l
  = a / 2 sqrt(4 - (1 + cos t)^2 - sin^2 t)
  = a / 2 sqrt(2 - 2 cos t) \
  &= a / 2 sqrt(2 (1 - 1 + 2 sin^2 t/2 ))
  = a sin t / 2
$