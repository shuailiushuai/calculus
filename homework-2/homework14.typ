#import "../template.typ": *

#show: project.with(
  course: "Calculus II",
  course_fullname: "Calculus (A) II",
  course_code: "821T0160",
  title: "Homework #14: 高斯公式 & Stocks 公式",
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

= 习题10-2
== P224 1(2)
#prob[
  计算第二类曲面积分：
  $
    iintb(Sigma) y z dz dx + 2 dx dy
  $
  其中 $Sigma$ 是球面 $x^2 + y^2 + z^2 = 4$ 外侧在 $z>=0$ 的部分。
]

== P224 1(3)
#prob[
  计算第二类曲面积分：
  $
    iintb(S) (y-z) dy dz + (z-x) dz dx + (x-y) dx dy
  $
  其中 $S$ 为圆锥曲面 $x^2 + y^2= z^2 space (0<=z<=h)$ 的外侧面。
]

== P224 2(2)
#prob[
  利用高斯公式计算第二类曲面积分：
  $
    iintcb(S) 2 x z dy dz + y z dz dx - z^2 dx dy
  $
  其中 $S$ 是由曲面 $z=sqrt(x^2 + y^2)$ 与 $z=sqrt(2-x^2-y^2)$ 所围立体的表面外侧。
]

== P224 2(4)
#prob[
  利用高斯公式计算第二类曲面积分：
  $
    iintb(S) - y dz dx + (z + 1) dx dy
  $
  其中 $S$ 是圆柱面 $x^2 + y^2 = 4$ 被平面 $x+z=2$ 和 $z=0$ 所截出部分的外侧。
]

== P224 3
#prob[
  证明：曲面 $S$ 所包围的体积等于
  $
    V = 1 / 3 iintb(S) (x cos alpha + y cos beta + z cos gamma) dif S
  $
  式中 $cos alpha$，$cos beta$，$cos gamma$ 为曲面 $S$ 的外法线的方向余弦。
]

= 习题10-3
== P233 1
#prob[
  利用 Stocks 公式计算第二类曲面积分：
  $
    intc_C (y+z) dx + (z + x) dy + (x + y) dz
  $
  式中 $C$ 为依据参数 $t$ 增大方向通过的椭圆：
  $
    x = a sin^2 t; quad
    y = 2a sin t cos t; quad
    z = a cos^2 t quad
    (0 <= t <= pi)
  $
]

== P233 2
#prob[
  设 $C$ 为位于平面 $x cos alpha + y cos beta + z cos gamma - p = 0$（$cos alpha$，$cos beta$，$cos gamma$ 为平面之法线的方向余弦）上并包围面积为 $S$ 的封闭曲线，其中围线 $C$ 是依正方向进行的。证明：
  $
    intc_C (z cos beta - y cos gamma) dx + (x cos gamma - z cos alpha) dy + (y cos alpha - x cos beta) dz = 2 S
  $
]

== P233 3(1)
#prob[
  计算第二类曲面积分：
  $
    int_((1,2,3))^((6,1,1)) y z dx + x z dy + x y dz
  $
]

== P233 5(1)
#prob[
  求函数的原函数：
  $
    dif u = (x^2 - 2 y z) dx + (y^2 - 2 x z) dy + (z^2 - 2 x y) dz
  $
]

== P234 6
#prob[
  当单位质量从点 $M_1 (x_1, y_1, z_1)$ 移动到点 $M_2 (x_2, y_2, z_2)$ 时，作用于单位质量的引力 $bold(F)$ 的大小为 $abs(bold(F)) = display(G/(r^2)) space (r = sqrt(x^2 + y^2 + z^2))$，方向指向原点 $O$，求引力所做的功。
]