#import "../template.typ": *

#show: project.with(
  course: "Calculus II",
  course_fullname: "Calculus (A) II",
  course_code: "821T0160",
  semester: "Spring-Summer 2024",
  title: "Note #4: 二重积分",
  authors: ((name: "Yulun WU", email: "memset0@outlook.com", id: "3230104585"),),
  date: "April 9, 2024",
)

= 二重积分

== 二重积分的概念

#definition(name: [二重积分])[
  设二元函数 $z=f(x,y)$ 在平面有界闭区域 $sigma$ 上有界。用任意的曲线网将 $sigma$ 分割成 $n$ 个小闭区域：$Delta sigma_1, Delta sigma_2, dots.c, Delta sigma_n$。其中 $Delta sigma_i$ 的面积仍旧用 $Delta sigma_i$ 来表示，$Delta sigma_i$ 的直径用 $lambda_i$ 来表示，$i=1,2,dots.c,n$。$lambda=max{lambda_i | i=1,2,dots.c,n}$。$forall P_i (xi_i,eta_i) in Delta sigma_i$，若极限
  $
    display(sum_(i=1)^n f(xi_i,eta_i) Delta)
  $
  存在，且与 $sigma$ 的分割方法及 $P_i$ 的取法无关，则称 $f(x,y)$ 在 $sigma$ 上可积，并称此极限为函数 $z=f(x,y)$ 在区域 $sigma$ 上的#def[二重积分]。记作
  $
    iintsg f(x,y) dsg
  $

  其中，称 $sigma$ 为#def[积分区域]，$f(x,y)$ 为#def[被积函数]，$x,y$ 为#def[积分变量]，$dsg$ 为#def[面积元素]，$f(x,y) dsg$ 为#def[被积表达式]。
]

#theorem(name: [可积性])[
  设 $z=f(x,y)$ 是有界闭区域 $sigma$ 上的一个函数，则

  (1) 若 $f(x,y)$ 在 $sigma$ 上连续，则 $f(x,y)$ 在 $sigma$ 上可积；

  (2) 若 $f(x,y)$ 在 $sigma$ 上可积，则 $f(x,y)$ 在 $sigma$ 上有界。
]

== 二重积分的性质

下面总假定 $f(x,y)$，$g(x,y)$ 在有界闭区域 $sigma$ 上可积。

#theorem[
  $iintsg dsg = sigma$
]

#theorem(name: [二重积分的线性性质])[
  $
    iintsg (f(x,y) + g(x,y)) dsg = iintsg f(x,y) dsg + iintsg g(x,y) dsg
  $
  $
    iintsg k f(x,y) dsg = k iintsg f(x,y) dsg quad (k "为常数")
  $
]

#theorem(name: [二重积分的区域可加性])[
  设 $sigma=sigma_1 union sigma_2$ 且 $sigma_1,sigma_2$ 无公共内点，则
  $
    iintsg f(x,y) dsg = iintb(sigma_1) f(x,y) dsg + iintb(sigma_2) f(x,y) dsg
  $
]

#theorem(name: [二重积分的保序性])[
  若 $f(x,y) >= 0 space ((x,y) in sigma)$，则 $iintsg f(x,y) dsg >=0$。
]

#corollary[
  若 $f(x,y) >= g(x,y) space ((x,y) in sigma)$，则 $iintsg f(x,y) dsg >= iintsg g(x,y) dsg$。
]

#theorem[
  设 $f(x,y)$ 在有界闭区域 $sigma$ 上连续。若 $f(x,y) >= 0$ 且 $f(x,y) equiv.not 0$，$(x,y) in sigma$，则
  $
    iintsg f(x,y) dsg > 0
  $
]

#theorem[
  $
    abs(iintsg f(x,y) dsg) <= iintsg abs(f(x,y)) dsg
  $
]

#theorem(name: [估值定理])[
  设 $f(x,y)$ 在有界闭区域 $sigma$ 上的最小值为 $m$，最大值为 $M$，则
  $
    m sigma <= iintsg f(x,y) dsg <= M sigma
  $
]

#theorem(name: [积分中值定理])[
  若 $f(x,y)$ 在 $sigma$ 上连续，则存在一点 $(xi,eta) in sigma$，满足
  $
    iintsg f(x,y) dsg = f(xi,eta) sigma
  $
  其中 $display(1/sigma iintsg f(x,y) dsg)$ 称为 $f(x,y)$ 在 $sigma$ 上的平均值。
]

== 二重积分在直角坐标系中的计算

在直角坐标系中，面积元素为 $dif sigma = dx dy$，故二重积分可写为
$
  iintsg f(x,y) dif sigma = iintsg f(x,y) dx dy
$