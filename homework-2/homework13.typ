#import "../template.typ": *

#show: project.with(
  course: "Calculus II",
  course_fullname: "Calculus (A) II",
  course_code: "821T0160",
  title: "Homework #13: 格林公式 & 路径无关性",
  authors: (
    (
      name: "Yulun WU",
      email: "memset0@outlook.com",
      id: "#198",
    ),
  ),
  semester: "Spring-Summer 2024",
  date: "June 4th, 2024",
)

= 习题10-1
== P212 4(1)
#prob[
  利用格林公式计算第二类曲线积分：
  $
    intcb(C) (x+y)^2 dx - (x^2 + y^2) dy
  $
  其中围线 $C$ 依正方向经过以 $A(1,1)$，$B(3,2)$，$C(2,5)$ 为顶点的三角形 $Delta A B C$。
]

== P212 4(4)
#prob[
  利用格林公式计算第二类曲线积分：
  $
    intb(accent(A B O, paren.t)) (e^x sin y - m y) dx + (e^x cos y - m) dy
  $
  其中 $accent(A B O, paren.t)$ 为由点 $A(a,0)$ 至点 $O(0,0)$ 的上半圆周 $x^2 + y^2 = a x$。
]

== P213 5
#prob[
  计算：
  $
    I=intcb(C) (x dy - y dx) / (x^2 + y^2)
  $
  式中 $C$ 为依正向而不经过坐标原点的简单封闭曲线。
]

== P213 6
#prob[
  设位于点 $(0,1)$ 的质点 $A$ 对质点 $M$ 的引力大小为 $G"/"r^2$（$G>0$ 为万有引力系数，$r$ 为质点 $A$ 与 $M$ 之间的距离），质点 $M$ 沿曲线 $y=sqrt(2x - x^2)$ 自 $B(2,0)$ 运动到 $O(0,0)$，求在此过程中点 $A$ 对质点 $M$ 的引力所做的功。
]

== P213 7(1)
#prob[
  利用第二类曲线积分计算曲线所围的面积：（星形线）
  $
    x = a cos^3 t, quad
    y = b sin^3 t quad
    (0 <= t <= 2pi)
  $
]

== P213 8(1)
#prob[
  计算第二类曲线积分：
  $
    int_((0,1))^((2,3)) (x+y) dx + (x-y) dy
  $
]

== P213 8(3)
#prob[
  计算第二类曲线积分：
  $
    int_((0,-1))^((1,0)) (x dy - y dx) / ((x-y)^2)
  $
  沿着与直线 $y=x$ 不相交的路径。
]

== P213 9(1)
#prob[
  求原函数 $u$：
  $
    dif u = (x^2 + 2x y - y^2) dx + (x^2 - 2 x y - y^2) dy
  $
]

== P213 9(2)
#prob[
  求原函数 $u$：
  $
    dif u = (y dx - x dy) / (3x^2 - 2x y + 3y^2)
  $
]
