#import "../template.typ": *

#show: project.with(
  course: "Calculus II",
  course_fullname: "Calculus (A) II",
  course_code: "821T0160",
  title: "Homework #10: 多重积分",
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

#let probx(x) = [#prob(x);#v(2em)#v(1fr)]

= 习题9-1
== P136 4(1)
#prob[
  比较二重积分的大小：
  $
    iintd x y dx dy " 与 " iintd (x^2 + y^2) dx dy
  $
]

由均值不等式得
$
  x^2 + y^2 >= sqrt(x^2 y^2) = abs(x y) >= x y
$
故
$
  iintd x y dx dy < iintd (x^2 + y^2) dx dy
$

== P136 4(2)
#prob[
  比较二重积分的大小：
  $
    iintb(1<=x^2+y^2<=2) x^2 y^4 sin 1 / y^2 dx " 与 " iintb(1<=x^2+y^2<=2) 2 x^2 dx dy
  $
]

由于 $display(1/y^2)>=0$，故 $display(sin 1/y^2 <= 1/y^2)$，可得
$
  y^4 sin 1 / y^2 <= y^4 dot 1 / y^2 = y^2 <= 2
$
两边同乘 $x^2$，不变号，可得
$
  x^2 y^4 sin 1 / y^2 <= 2 x^2
$
故
$
  iintb(1<=x^2+y^2<=2) x^2 y^4 sin 1 / y^2 dx dy < iintb(1<=x^2+y^2<=2) 2 x^2 dx dy
$

= 习题9-2
== P151 2(1)
#prob[
  设 $f(x)$ 在闭区间 $[a,b]$ 上连续，试证明：

  $
    int_a^b dy int_y^b f(x) dx = int_a^b (x-a) f(x) dx
  $
]
$
  int_a^b dy int_y^b f(x) dx
  = int_a^b (int_a^x dy) f(x) dx
  = int_a^b (x-a) f(x) dx
$

== P151 2(5)
#prob[

  $
    int_a^b dy int_y^b f(x) f(y) dx = 1 / 2 (int_a^b f(x) dx)^2
  $
]
$
  int_a^b dy int_y^b f(x) f(y) dx
  = 1 / 2 (int_a^b dy int_a^b f(x) f(y) dx)
  = 1 / 2 (int_a^b f(x) dx)^2
$

== P151 3(1)
#prob[
  在下列积分中改变积分的顺序：
  $
    int_0^2 dx int_x^(2x) f(x,y) dy
  $
]
画图分析可得：
$
  I = int_0^2 dy int_(y / 2)^y f(x,y) dx + int_2^4 dy int_(y / 2)^2 f(x,y) dx
$

== P151 3(3)
#prob[
  在下列积分中改变积分的顺序

  $
    int_0^(2a) dx int_sqrt(2a x-x^2)^sqrt(2a x) f(x,y) dy space (a>0)
  $
]
分析：
$
  & 0 <= x <= 2a; quad
  sqrt(2 a x - x^2) <= y <= sqrt(2a x) \
  ==> & 0 <= x <= 2a; quad y^2 <= 2 a x <= x^2 + y^2
$
$D={(x,y) : 0 <= x <= 2a,space y^2 <= 2 a x <= x^2 + y^2 }$ 可以看做 $y^2=2a x,space (x-a)^2 + y^2 = a^2,space x=2a$ 所围成的区域。故
$
  int_0^(2a) dx int_sqrt(2a x-x^2)^sqrt(2a x) f(x,y) dy
  = int_0^(2a) int_(y^2 / (2a))^(2a) f(x, y) dx dy - int_0^a int_(a-sqrt(a^2-y^2))^(a+sqrt(a^2-y^2)) f(x,y) dx dy
$

== P151 4(1)
#prob[
  计算二重积分：$iintd x^2 y dx dy$，其中 $D$ 是由双曲线 $x^2-y^2=1$ 及直线 $y=0,y=1$ 所围成的平面区域。
]
$
  & iintd x^2 y dx dy
  = int_0^1 int_(-sqrt(y^2+1))^(sqrt(y^2+1)) x^2 dx y dy
  = int_0^1 2 / 3 y (y^2+1)^(3 / 2) dy
  = 1 / 3 int_0^1 (y^2+1)^(3 / 2) dif (y^2)\
  = & 1 / 3 int_0^1 (u+1)^(3 / 2) du
  = atpos((2 u^(5/2))/15, 1, 2)
  = (8 sqrt(2) - 2) / 15
$

== P151 4(3)
#prob[
  计算二重积分：$iintd y dx dy$，其中 $D$ 是由 $x$ 轴、$y$ 轴及曲线 $display(sqrt(x/a) + sqrt(y/b) = 1)$ 所围成的区域 $(a>0,b>0)$。
]
$
  & iintd y dx dy
  = int_0^a dx int_0^(b (1-sqrt(x/a))^2) y dy
  = int_0^a 1 / 2 (b(1-sqrt(x/a)))^2 dx
  = int_0^1 (a b^2) / 2 (1-sqrt(u))^4 dif u\
  = & (a b^2) / 2 int_1^0 t^4 (-2 (1-t) dt)
  = (a b^2) int_0^1 (t^4 - t^5) dt
  = (a b^2) / 30
$

== P151 5
#prob[
  计算：
  $
    display(int_0^(pi/6) dy int_y^(pi/6) (cos x)/x dx)
  $
]
$
  int_0^(pi / 6) dy int_y^(pi / 6) (cos x) / x dx
  = int_0^(pi / 6) (int_0^x dy) (cos x) / x dx
  = int_0^(pi / 6) x dot (cos x) / x dx
  = int_0^(pi / 6) cos x dx
  = atpos(sin x, 0, pi/6)
  = 1 / 2
$

== P151 6
#prob[
  计算：
  $
    display(int_1^2 dx int_(sqrt(x))^x sin (pi x)/(2 y) dy + int_2^4 dx int_(sqrt(x))^2 sin (pi x)/(2 y) dy)
  $
]
$D$ 相当于 $x=1,x=4,y=2,y=x,y=sqrt(x)$ 所围成的图形。那么：
$
  & int_1^2 dx int_(sqrt(x))^x sin (pi x) / (2 y) dy + int_2^4 dx int_(sqrt(x))^2 sin (pi x) / (2 y) dy
  = iintd sin (pi x) / (2y) dx dy
  = int_1^2 int_y^(y^2) sin (pi x) / (2y) dx dy\
  = & int_1^2 (2y) / pi atpos((-cos (pi x)/(2y)), y, y^2) dy
  = -2 / pi int_1^2 y cos (y pi) / 2 dy
  = (4(2+pi)) / (pi^3)
$

== P151 7(1)
#prob[
  利用极坐标计算积分：
  $
    iintd sqrt(1-x^2 -y^2) dx dy quad D={(x,y):x^2+y^2<=x}
  $
]
代入 $x=r cos theta;space y=r sin theta$ 得
$
  x^2 + y^2 <= x
  ==> r^2 cos^2 theta + r^2 sin^2 theta <= r cos theta
  ==> r^2 <= r cos theta
  ==> r <= cos theta
$
故
$
  & iintd sqrt(1-x^2 -y^2) dx dy
  = int_(-pi / 2)^(pi / 2) dif theta int_0^(cos theta) sqrt(1-r^2) r dif r
  = int_(-pi / 2)^(pi / 2) dif theta 1 / 2 int_0^(cos^2 theta) sqrt(1-t) dif t\
  = & - 1 / 3 int_(-pi / 2)^(pi / 2) (abs(sin^3 theta) - 1) dif theta
  = -2 / 3 int_0^(pi / 2) (sin^3 theta - 1) dif theta
  = pi / 3 - 4 / 9
$

== P151 7(3)
#prob[
  利用极坐标计算积分：
  $
    iintd (x+y) dx dy quad D={(x,y):x^2+y^2<=x+y+1}
  $
]
$
  x^2 + y^2 <= x + y + 1
  ==> (x-1 / 2)^2 + (y-1 / 2)^2 <= 3 / 2
$
取 $display(x=1/2 + r cos theta\,space y=1/2 + r sin theta)$ 得
$
  r^2 <= 3 / 2 ==> r <= sqrt(3/2)
$
故
$
  &iintd (x+y) dx dy
  = int_0^(2 pi) int_0^sqrt(3/2) (1 / 2 + r cos theta + 1 / 2 + r sin theta) r dif r dif theta\
  =& int_0^sqrt(3/2) int_0^(2 pi) (1+r (cos theta + sin theta)) dif theta r dif r
  = int_0^sqrt(3/2) atpos((theta + r sin theta - r cos theta), 0, 2 pi) r dif r\
  =& 2 pi int_0^sqrt(3/2) r dif r
  = 3 / 2 pi
$

== P151 7(5)
#prob[
  利用极坐标计算积分：
  $
    iintd (1-x^2-y^2) / (1+x^2+y^2) dx dy
  $
  其中 $D$ 是 $x^2+y^2=1$，$x=0$ 及 $y=0$ 所围区域在第一象限的部分。
]
$
  &iintd (1-x^2-y^2) / (1+x^2+y^2) dx dy
  = int_0^(pi / 2) int_0^1 (1-r^2) / (1+r^2) dot r dif r dif theta
  = pi / 2 int_0^1 (r-r^3) / (1+r^2) dif r
  = pi / 2 int_0^1 ((2r) / (1+r^2) - r) dif r\
  =& pi / 2 int_0^1 atpos((ln(1+r^2)-1/2 r^2),0,1)
  = pi / 2 (ln 2 - 1 / 2)
$

== P151 8(1)
#prob[
  用适当方法计算积分：
  $
    iintb(0<=x\,y<=1) abs(y-x^2) max{x,y} dx dy
  $
]
$
  & iintb(0<=x\,y<=1) abs(y-x^2) max{x,y} dx dy\
  =& int_0^1 int_x^1 (y-x^2) y dif y dif x
  + int_0^1 int_(x^2)^x (y-x^2) x dif y dif x
  + int_0^1 int_0^(x^2) (x^2 - y) x dif y dif x\
  =& int_0^1 (1 / 3 - x^2 / 2 + x^3 / 6 - x^4 / 2 + x^5) dx
  = 11 / 40
$

== P152 8(3)
#prob[
  用适当方法计算积分：
  $
    iintd(x^2/a^2 + y^2/b^2) dx dy quad D:x^2+y^2<=R^2
  $
]
$
  & iintd(x^2/a^2 + y^2/b^2) dx dy quad D:x^2+y^2<=R^2
  = int_0^(2pi) int_0^R ((r cos theta)^2 / a^2 + (r sin theta)^2 / b^2) r dif r dif theta\
  =& int_0^(2 pi) int_0^R ((cos^2 theta) / a^2 + (sin^2 theta) / b^2) r^3 dif r dif theta
  = int_0^R (pi / a^2 + pi / b^2) r^3 dif r
  = pi / 4 R^4 (1 / a^2 + 1 / b^2)
$

== P152 10
#prob[
  求抛物线 $y=x^2$ 与直线 $y=x+2$ 所围的平面图形的面积。
]
联立 $display(cases(y=x^2,y=x+2))$ 得 $display(cases(x=-1,y=1))$ 或 $display(cases(x=2,y=4))$。故
$
  S = int_(-1)^2 int_(x^2)^(x+2) dy dx
  = int_(-1)^2 (x+2-x^2) dx
  = 9 / 2
$

== P152 14(1)
#prob[
  求曲面所围成立体的体积：
  $
    z = 1+x+y,z=0,x+y=1,x=0,y=0
  $
]
$
  V &= int_0^1 int_0^(1-x) (1+x+y) dy dx
  = int_0^1 ((1+x)(1-x) + (1-x)^2 / 2) dx\
  &= int_0^1 (-x^2 / 2 + x + 3 / 2) dx
  = 5 / 6
$

== P152 14(3)
#prob[
  求曲面所围成立体的体积：
  $
    z=x^2+y^2, x^2+y^2=x, x^2+y^2=2x, z=0
  $
]
$
  V &= iintd (x^2+y^2) dx dy quad D={(x,y) : x<=x^2+y^2<=2x}
$
令 $display(cases(x = r cos theta, y = r sin theta))$，得
$
  x <= x^2 + y^2 <= 2x
  ==> r cos theta <= r^2 <= 2 r cos theta
  ==> cos theta <= r <= 2 cos theta
$
故
$
  V &= int_(-pi / 2)^(pi / 2) int_(cos theta)^(2 cos theta) r^3 dif r dif theta
  = 2 int_0^(pi / 2) int_(cos theta)^(2 cos theta) r^3 dif r dif theta
  = 2 int_0^(pi / 2) atpos(r^4/4, cos theta, 2 cos theta) dif theta\
  = & 15 / 2 int_0^(pi / 2) cos^4 theta dif theta
  = 15 / 2 dot 3 / 4 dot 1 / 2 dot pi / 2 = 45 / 32 pi
$

= 习题9-3
== P171 1(2)
#prob[
  计算下列三重积分
  $
    iiintv (dx dy dz) / ((1+x+y+z)^3)
  $
  其中 $V$ 是由曲面 $x+y+z=1,z=0,y=0,x=0$ 所围成的立体。
]
$
  & iiintv (dx dy dz) / ((1+x+y+z)^3)
  = int_0^1 dx int_0^(1-x) dy int_0^(1-x-y) (1+x+y+z)^(-3) dz\
  =& int_0^1 dx int_0^(1-x) dy int_(1+x+y)^2 (dt) / t^3
  = int_0^1 dx int_0^(1-x) dy atpos((1/(-2 t^2)), 1+x+y, 2) \
  =& int_0^1 dx int_0^(1-x) (-1 / 8 + 1 / (2 (1+x+y)^2)) dy\
  =& int_0^1 (-3 / 8 + x / 8 + 1 / (2(1+x))) dx
  = 1 / 2 ln 2 - 5 / 16
$

== P171 1(4)
#prob[
  计算下列三重积分
  $
    iiintv sqrt(x^2+y^2) dx dy dz
  $
  其中 $V$ 是由曲面 $z^2=x^2+y^2$，$z=1$ 所围成的立体。
]
$
  & iiintv sqrt(x^2+y^2) dx dy dz
  = 4 iiintb(V') sqrt(x^2 + y^2) dx dy dz
  = 4 iintb(D') sqrt(x^2 + y^2) dx dy int_sqrt(x^2+y^2)^1 dz\
  =& 4 iintb(D') sqrt(x^2 + y^2) (1-sqrt(x^2+y^2)) dx dy
  = 4 int_0^(2 pi) int_0^1 r(1-r) r dif r dif theta
  = 4 int_0^(2 pi) 1 / 12 dif theta\
  =& 4 dot (pi) / 6 = (2 pi) / 3
$

// = 习题9-4
// == P189 2
// #prob[
// 	计算曲线 $x=3t, y=3t^2, z=2 t^3$ 从 $O(0,0,0)$ 到 $A(3,3,2)$ 一段弧长。
// ]

// == P189 3(1)
// #prob[
// 	计算第一类曲面积分：
// 	$
// 	iints (x+y+z) dif S
// 	$
// 	其中 $S$ 为曲面 $x^2+y^2+z^2=a^2,space z>=0$。
// ]

// == P189 3(2)
// #prob[
// 	计算第一类曲面积分：
// 	$
// 	iints (dif S)/((1+x+y)^2)
// 	$
// 	其中 $S$ 为四面体 $x+y+z<=1,x>=0,y>=0,z>=0$ 的边界。
// ]

// == P189 3(3)
// #prob[
// 	计算第一类曲面积分：
// 	$
// 	iints abs(x y z) dif S
// 	$
// 	其中 $S$ 为曲面 $z=x^2+y^2$ 被平面 $z=1$ 所割下的部分。
// ]

// == P189 3(4)
// #prob[
// 	计算第一类曲面积分：
// 	$
// 	iints (a x + b y + c z + d)^2 dif S
// 	$
// 	其中 $S$ 是球面 $x^2+y^2+z^2=R^2$。
// ]