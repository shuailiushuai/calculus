#import "../template.typ": *

#show: project.with(
  course: "Calculus II",
  course_fullname: "Calculus (A) II",
  course_code: "821T0160",
  semester: "Spring-Summer 2024",
  title: "Note #4: 重积分",
  authors: ((name: "Yulun WU", email: "memset0@outlook.com", id: "3230104585"),),
  date: "April 9, 2024",
)

#let iintd = iintb($D$)
#let iints = iintb($S$)
#let iintsg = iintb($sigma$)
#let iiintv = iiintb($V$)
#let iiintog = iiintb($Omega$)

= 二重积分

== 二重积分的定义

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

== 二重积分的可积条件

二重积分的可积性理论远比一元函数定积分复杂，故这里只给出二重积分可积的一个充分条件和一个必要条件。

#theorem[
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

#theorem(name: [中值定理])[
  若 $f(x,y)$ 在 $sigma$ 上连续，则存在一点 $(xi,eta) in sigma$，满足
  $
    iintsg f(x,y) dsg = f(xi,eta) sigma
  $
  其中 $display(1/sigma iintsg f(x,y) dsg)$ 称为 $f(x,y)$ 在 $sigma$ 上的平均值。
]

== 二重积分的计算：累次积分

#definition[
  平面点集
  $
    D = {(x,y) | a<=x<=b,space phi_1 (x) <= y <= phi_2 (x)}
  $
  称为 #def[$x$ 型区域]；平面点集
  $
    D = {(x,y) | a<=y<=b,space psi_1 (y) <= x <= psi_2 (y)}
  $
  称为 #def[$y$ 型区域]。
]

#definition[
  设 $f$ 为定义在 $x$ 型区域 $D$ 上的函数，若对 $[a,b]$ 上的每一个固定的 $x$，$f(x,y)$ 作为以 $y$ 为自变量的函数在区间 $[phi_1 (x),phi_2 (x)]$ 上可积，则得到如下用 #def[含参量 $x$ 积分]所表示的函数：
  $
    A(x) = int_(phi_1 (x))^(phi_2 (x)) f(x,y) dif y, quad x in [a,b]
  $
]

#theorem[
  对于 $x$ 型区域 $D$ 上的二重积分，可以将其化为先对 $y$ 积分再对 $x$ 积分的#def[累次积分]：
  $
    iintd f(x,y) dx dy = int_a^b dx int_(phi_1 (x))^(phi_2 (x)) f(x,y) dif y
  $
  类似地，对于 $y$ 型区域 $D$ 上的二重积分，可以将其化为先对 $x$ 积分再对 $y$ 积分的累次积分：
  $
    iintd f(x,y) dx dy = int_c^d dy int_(psi_1 (y))^(psi_2 (y)) f(x,y) dif x
  $
]

#tip[
  【空间立体体积的计算方法】

  1. 确定底面 $z_下 = z_1 (x,y)$，顶面 $z_上 = z_2 (x,y)$。

  2. 将立体向 $x O y$ 平面作投影，求出投影区域 $sigma_(x y)$：

    - 题中不含 $z$ 的方程就是 $sigma_(x y)$ 的边界曲线方程。
    - 若题中没有不含 $z$ 的方程，则联立 $display(cases(z=z_1 (x,y),z = z_2 (x,y)))$ 消去 $z$，记得 $sigma_(x y)$ 在平面直角坐标系中的边界曲线方程。
    - 以上两种情况兼而有之。

  3. 套公式 $V = display(iintb(sigma_(x y)) (z_1 - z_2) dif sigma)$。
]

#property[
  设积分区域 $sigma$ 关于 $y$ 轴对称，则

  (1) 若 $f(x,y)$ 关于 $x$ 是奇函数，即 $f(x,y) = -f(-x,y)$，则有 $display(iintb(sigma) f(x,y) dif sigma = 0)$。

  (2) 若 $f(x,y)$ 关于 $x$ 是偶函数，即 $f(x,y) = f(-x,y)$，则有 $display(iintb(sigma) f(x,y) dif sigma = 2 iintb(sigma\,x>=0) f(x,y) dif sigma)$。

  关于 $x$ 轴对称的情形也同理。
]

== 二重积分的计算：变量替换

这里先给出二重积分关于一般变量替换的定理。

#theorem[
  设 $D' subset RR^2$ 是有界闭区域，该区域的边界 $diff D'$ 由有限条分段光滑曲线所组成，变换 $T(u,v) : display(cases(x = x(u, v), y = y(u,v)))$ 是 $D'$ 到有界闭区域 $D$ 上连续可导的一一映射，且满足 $display((diff (x,y))/(diff (u,v)) != 0)$。如果 $f$ 在有界闭区域 $D$ 上可积，则
  $
    iintd f(x,y) dx dy = iintb(D') f(x(u,v), y(u,v)) display(abs((diff (x,y))/(diff (u,v)))) dif u dif v
  $
  其中 $display((diff (x,y))/(diff (u,v)))$ 为雅可比行列式：
  #set math.mat(delim: "|")
  $
    (diff (x,y)) / (diff (u,v))
    = mat(
      space display((diff x)/(diff u)),
      space,
      display((diff y)/(diff u)) space;
      space display((diff x)/(diff v)),
      space,
      display((diff y)/(diff v)) space;
    )
  $
  #set math.mat(delim: "(")
]

=== 极坐标换元

#note[
  当被积函数或积分区域的边界曲线方程含有 $x^2+y^2$ 时，常采用极坐标计算二重积分。
]

#corollary[
  作极坐标变换
  $
    x = r cos theta,quad y = r sin theta quad (0<=r<=+oo,space 0<=theta<=2 pi)
  $
  极坐标变换的雅可比行列式为 $display((diff (x,y))/(diff (r,theta)) = r)$，由上述定理可得
  $
    iintsg f(x,y) dif sigma = iintb(sigma') f(r cos theta, r sin theta)r dif r dif theta
  $

  更进一步地，设 $sigma$ 为 $phi_1 (theta) <= phi_2 (theta), space alpha<=theta<=beta$，则二重积分可写为

  $
    iintsg f(x,y) dsg
    = int_alpha^beta dif theta int_(phi_1 (theta))^(phi_2 (theta)) f(r cos theta, r sin theta) dot r dif r
  $
]

=== 广义极坐标换元

#corollary[
  作广义极坐标变换
  $
    x = a r cos theta, quad y = b r sin theta quad (0<=r<=+theta, space 0<=theta<=2 pi)
  $
  可得
  $
    iintsg f(x,y) dif sigma = iintb(sigma') f(a r cos theta, b r sin theta) a b r dif r dif theta
  $
]

= 三重积分

== 三重积分的定义

#definition[
  设 $V$ 为空间有界闭区域，$f(x,y,z)$ 为 $V$ 上的有界函数，将 $V$ 任意划分成 $n$ 个小区域：$Delta V_1,Delta V_2,dots.c, Delta V_n$，记 $lambda = display(max_(1<=i<=n)) {Delta V_i "的直径"}$。并任取 $M_i (xi_i,  eta_i, zeta_i) in Delta V_i$，若极限 $display(lim_(lambda -> 0) sum_(i=1)^n f(xi_i, eta_i, zeta_i) Delta V_i)$ 存在，则称此极限为函数 $f(x,y,z)$ 在闭区域 $V$ 上的#def[三重积分]，记作 $iiintv f(x,y,z) dif V$，即
  $
    iiintv f(x,y,z) dif V = lim_(lambda->0) sum_(i=1)^n f(xi_i, eta_i, zeta_i) Delta V_i`
  $
]

\

三重积分的可积条件与三重积分的性质可类比二重积分，这里略去。

== 三重积分的计算：累次积分

=== 投影法

#theorem[
  记 $sigma_(x y)$ 是空间有界区域 $V$ 在 $x O y$ 平面的投影：
  $
    V = {(x,y,z) | z_1 (x,y) <= z <= z_2 (x,y),space (x,y) in sigma_(x y)}
  $

  即 $V$ 的底面为 $z= z_1 (x,y)$，顶面为 $z = z_2 (x,y)$，侧面是以 $sigma_(x y)$ 的边界曲线为准线，母线平行于 $z$ 轴的柱面。

  如果对每一个固定的点 $(x,y) in sigma_(x y)$，$f(x,y,z)$ 是一个关于变量 $z$ 在区间 $[z_1 (x,y),z_2 (x,y)]$ 上的可积函数，则可以考虑如下积分
  $
    g(x,y)= int_(z_1 (x,y))^(z_2 (x,y)) f(x,y,z) dif z
  $
  进一步地，如果这一积分可积，则有
  $
    iiintv f(x,y,z) dx dy dz = iintb(sigma_(x y)) dx dy int_(z_1 (x,y))^(z_2 (x,y)) f(x,y,z) dif z
  $
]

=== 截面法（平行截割法）

#theorem[
  设 $V$ 在 $z$ 轴上的投影是一个区间 $[c_1,c_2]$，对每个 $z in [c_1,c_2]$，如果 $f(x,y,z)$ 是关于变量 $x,y$ 在 $z$ 截面 $J_z$ 上的可积函数，则可以考虑如下积分
  $
    iintb(J_z) f(x,y,z) dx dy
  $
  进一步地，如果这一积分可积，则有
  $
    iiintv f(x,y,z) dx dy dz = int_(c_1)^(c_2) dz iintb(J_z) f(x,y,z) dx dy
  $
]

== 三重积分的计算：变量替换

三重积分的一般变量替换定理可类比二重积分。

=== 柱面坐标变换

#definition[
  对于 $RR^3$ 中任意一点 $P(x,y,z)$，若将前两个分量 $(x,y)$ 在 $x O y$ 平面内用极坐标 $(r, theta)$ 表示，则 $P$ 可以表示为
  $
    display(cases(
      x = r cos theta,
      y = r sin theta,
      z = z
    ))
  $
  称为点 $P$ 的#def[柱面坐标]。
]

#corollary[
  三重积分的柱面坐标换元公式为
  $
    iiintv f(x,y,z) dx dy dz
    = iiintv f(r cos theta, r sin theta, z) r dif r dif theta dif z
  $
  转化成累次积分公式即
  $
    iiintv f(x,y,z) dx dy dz
    = iintb(sigma_(r theta)) r dif r dif theta int_(z_1 (r, theta))^(z_2 (r, theta)) f(
      r cos theta, r sin theta, z
    ) dif z
  $
]

=== 球面坐标变换

#definition[
  注意到柱面坐标变换中，$z$ 轴和极轴 $r$ 总是正交的，如果对于 $z O r$ 平面引入极坐标 $(rho, phi)$，其中 $rho$ 表示点 $P$ 到原点的距离，而 $phi$ 表示 $z$ 轴到新的极径 $rho$ 的夹角，则 $P$ 可以表示为
  $
    display(cases(
      x = rho sin phi cos theta,
      y = rho sin phi sin theta,
      z = rho cos phi
    ))
  $
  称为点 $P$ 的#def[球面坐标]。
]

#theorem[
  三重积分的球面坐标换元公式为
  $
    iiintv f(x,y,z) dx dy dz
    = iiintv f(rho sin phi cos theta, rho sin phi sin theta, rho cos phi) rho^2 sin phi dif rho dif phi dif theta
  $
  转化成累次积分公式即
  $
    iiintv f(x,y,z) dx dy dz
    = int_(theta_1)^(theta_2) dif theta
    int_(phi_1)^(phi_2) dif phi
    int_(rho_1 (theta, phi))^(rho_2 (theta, phi)) f(
      rho sin phi cos theta, rho sin phi sin theta, rho cos phi
    ) rho^2 sin phi dif rho
  $
]

