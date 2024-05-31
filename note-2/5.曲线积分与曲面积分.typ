#import "../template.typ": *

#show: project.with(
  course: "Calculus II",
  course_fullname: "Calculus (A) II",
  course_code: "821T0160",
  semester: "Spring-Summer 2024",
  title: "Note #5: 曲线积分与曲面积分",
  authors: ((name: "Yulun WU", email: "memset0@outlook.com", id: "3230104585"),),
  date: "April 9, 2024",
)

= 第一类曲线积分

== 第一类曲线积分的概念

#definition[
  若曲线 $L = {(x(t),y(t),z(t)) | t in [a,b]}$ 是 $RR^3$ 上的光滑曲线，则此曲线的#def[弧微分]公式为
  $
    dif s = sqrt((x' (t))^2 + (y'(t))^2 + (z'(t))^2) dif t
  $
]

#definition[
  设 $f(x,y,z)$ 是定义在空间曲线 $L$ 上的有界函数，将 $L$ 分成任意 $n$ 个小段 $Delta s_1,Delta s_2,dots.c,Delta s_n$，记 $lambda$ 为各小段曲线 $Delta s_i$ 中的最长值（$Delta s_i$ 也表示其长度）。如果存在常数 $I in RR$，对任意的 $eps>0$，总存在 $delta>0$，使得对于任何满足 $lambda<=delta$ 的分割和任意选取的点 $(eps_i,eta_i,zeta_i) in Delta s_i$，都成立
  $
    abs(sum_(i=1)^n f(eps_i,eta_i,zeta_i) Delta s_i - I) <= eps
  $
  则称 $f$ 在曲线 $L$ 上可积，称 $I$ 为 $f$ 在 $L$ 上的#def[第一类曲线积分]，亦称为#def[对弧长的积分]，记作 $display(int_L f(x,y,z) dif s)$。
]

== 第一类曲线积分的计算

=== ?

#theorem[
  若曲面 $S$ 为光滑曲面，$z=z(x,y)$，$(x,y) in sigma_(x y)$（$sigma_(x y)$ 是曲面 $S$ 在 $O x y$ 平面上的投影），则
  $
    iintb(S) f(x,y,z) dif S = iintb(sigma_(x y)) f(x,y,z(x,y)) sqrt(1+z'_x^2+z'_y^2) dif sigma
  $

  还可以投影到平面 $O x z$、$O y z$ 上，得到两个形式相似的式子。

  #proof[
    由于 $dif S$ 很小，可以把 $dif S$ 看做一个平面，则平面 $dif S$ 与平面 $sigma_(x y)$（也就是 $O x y$）的夹角 $theta$（取锐角）的余弦为
    $
      cos theta = 1 / sqrt(z'_x^2 + z'_y^2 + 1)
    $
    将 $dif S$ 与 $dif sigma_(x y)$ 分别积分（具体过程略）可以得到 $cos theta dif S = dif sigma$，代入可得证。
  ]
]

= 第一类曲面积分

== 第一类曲面积分的概念

= 第二类曲线积分

== 第二类曲线积分的概念

#definition[
  设 $L$ 为光滑或者分段光滑的空间有向连续曲线，$P(x,y,z),space Q(x,y,z),space R(x,y,z)$ 为定义在 $L$ 上的有界函数，则称
  $
    int_(L_(A B)) P(x,y,z) dx + Q(x,y,z) dy + R(x,y,z) dz
  $
  为函数 $P(x,y,z),space Q(x,y,z),space R(x,y,z)$ 沿曲线 $L$ 从 $A$ 到 $B$ 的#def[第二类曲线积分]，亦称为#def[对坐标的曲线积分]，或称为#def[关于弧长元素投影的积分]。
]

== 第二类曲线积分的计算

= 第二类曲面积分

== 第二类曲面积分的概念