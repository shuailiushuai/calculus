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

*物理背景*：曲面薄壳的质量。

#definition[
  设 $S$ 是空间中的一张有界光滑曲面，$f(x,y,z)$ 为定义在 $S$ 上的有界函数。将 $S$ 分成互不相交的 $n$ 个小块 $Delta S_1,Delta S_2,dots.c,Delta S_n$，$Delta S_i$ 的面积仍旧用 $Delta S_i$ 来表示，记 $lambda= max_(1<=i<=n) {Delta S_i "的直径"}$。$forall P_i (xi_i,eta_i,zeta_i) in Delta S_i$，若极限
  $
    lim_(lambda->0) sum_(i=1)^n f(xi_i,eta_i,zeta_i) Delta S_i
  $
  存在，且极限值与区域 $S$ 的分割方法及 $P_i$ 的取法无关，则称上述极限为函数 $f(x,y,z)$ 在 $S$ 上的第一类曲面积分，记作
  $
    iintb(S) f(x,y,z) dif S
  $
]

== 第一类曲面积分的计算：微元法

投影到 $x O y$ 平面：$forall dif S subset  S$，$forall P(x,y,z(x,y)) in dif S$，设 $dif sigma$ 为 $dif S$ 在 $x O y$ 平面上的投影，则曲面 $S$ 在该点处的法矢量为
$
  arrow(n) = pm {(diff z) / (diff x),(diff z) / (diff y),-1}
$
则 $arrow(n)$ 与 $z$ 轴正向夹角 $gamma$ 的余弦为：
$
  cos gamma = pm 1 / display(sqrt(1+((diff z)/(diff x))^2+((diff z)/(diff y))^2))
$
则
$
  dif sigma = dif S dot.c abs(cos gamma) = sqrt(1+((diff z)/(diff x))^2 + ((diff z)/(diff y))^2) dif sigma
$

#theorem[
  设 $f(x,y,z)$ 在曲面 $S$ 上连续，若 $S:z=z(x,y),space (x,y) in sigma_(x y)$，则
  $
    iintb(S) f(x,y,z) dif S
    = iintb(sigma_(x y)) f(x,y,z(x,y)) sqrt(1+((diff z)/(diff x))^2+((diff z)/(diff y))^2) dif sigma
  $
  同理，可以得到投影到 $y O z$ 平面和 $x O z$ 平面的类似结论。
]

== 点函数积分

#definition[
  设 $Omega$ 为有界形体，$partial Omega$ 为 $Omega$ 的边界。若 $partial Omega subset Omega$，则称 $Omega$ 是#def[闭形体]。
]

#definition[
  设 $Omega$ 是#def[可度量的]，则称 $Omega$ 是可求长（或面积、体积）的。对应的长度（或面积、体积）称为 $Omega$ 的#def[量度]。
]

#definition[
  设 $Omega$ 是 $n$ 维有界闭形体，$f(P)$ 是定义在 $Omega$ 上的有界函数。将 $Omega$ 分割成 $n$ 个小子形体：$Delta Omega_1,Delta Omega_2,dots.c,Delta Omega_n$，$Delta Omega_i$ 的量度仍旧用 $Delta Omega_i$ 来表示，$Delta Omega_i$ 的直径用 $lambda_i$ 来表示，$i=1,2,dots.c,n$。记 $lambda=max{lambda_i | i=1,2,dots.c,n}$。$forall P_i in Delta Omega_i$，作和 $display(sum_(i=1)^n f(P_i) Delta Omega_i)$，若极限
  $
    lim_(lambda->0) sum_(i=1)^n f(P_i) Delta Omega_i
  $
  存在，且与 $Omega$ 的分割方法及 $P_i$ 的取法无关，则称此极限为点函数 $f(P)$ 在区域 $Omega$ 上的积分，记作
  $
    int_Omega f(P) dif Omega
  $
]

\

我们学过的点函数积分有以下五种：

1. #[
    一元函数定积分：设 $Omega = [a,b] subset RR^1$，$f(P) = f(x), space x in [a,b]$，则
    $
      int_Omega f(P) dif Omega = int_a^b f(x) dif x
    $
  ]

2. #[
    二重积分：设 $Omega = sigma subset RR^2$，$f(P)=f(x,y), space (x,y) in sigma$，则
    $
      int_Omega f(P) dif Omega = iintb(sigma) f(x,y) dif sigma
    $
  ]

3. #[
    三重积分：设 $Omega = V subset RR^3$，$f(P) = f(x,y,z), space (x,y,z) in V$，则
    $
      int_Omega f(P) dif Omega = iiintb(V) f(x,y,z) dif V
    $
  ]

4. #[
    第一类曲线积分（对弧长的积分）：设 $Omega = Gamma subset RR^3$，$f(P) = f(x,y,z) , space (x,y,z) in Gamma$，则
    $
      int_Omega f(P) dif Omega = int_Gamma f(x,y,z) dif s
    $
  ]

5. #[
    第一类曲面积分（对面积的积分）：设 $Omega = S subset RR^3$，$f(P) = f(x,y,z), space (x,y,z) in S$，则
    $
      int_Omega f(P) dif Omega = iintb(S) f(x,y,z) dif S
    $
  ]

#note[
  点函数积分是我们到目前为止学过的以上五种积分的总称。
]

= 第二类曲线积分

== 第二类曲线积分的概念

*物理背景*：变力沿曲线所作的功。

#definition(name: [第二类曲线积分])[
  设 $Gamma$ 是一条以 $A,B$ 为端点的光滑曲线，并指定从 $A$ 到 $B$ 的曲线方向。在 $Gamma$ 上任取一点 $M(x,y,z)$，作曲线的单位切矢量
  $
    arrow(T^circle.small) = arrow(T^circle.small) (x,y,z) = cos alpha arrow(i) + cos beta arrow(i) + cos gamma arrow(k)
  $
  其方向与指定的曲线方向一致。又设
  $
    arrow(A) = arrow(A) (x,y,z) = P(x,y,z) arrow(i) + Q(x,y,z) arrow(j) + R(x,y,z) arrow(k)
  $
  其中，$P(x,y,z)$，$Q(x,y,z)$，$R(x,y,z)$ 是定义在 $Gamma$ 上的有界函数。
  $
    arrow(A) dot arrow(T^circle.small) = P(x,y,z) cos alpha + Q(x,y,z) cos beta + R(x,y,z) cos gamma
  $
  那么
  $
    int_Gamma arrow(A) dot arrow(T^circle.small) dif l
    &= int_Gamma P(x,y,z) cos alpha dif l + int_Gamma Q(x,y,z) cos beta dif l + int_Gamma R(x,y,z) cos gamma dif l\
    &= int_Gamma P(x,y,z) dif x + Q(x,y,z) dif y + R(x,y,z) dif z
  $
  上式称为函数 $P(x,y,z)$，$Q(x,y,z)$，$R(x,y,z)$ 沿曲线 $Gamma$ 从点 $A$ 到点 $B$ 的#def[第二类曲线积分]，或称为#def[对坐标的曲线积分]，或称为#def[关于弧长元素投影的积分]。
]

#definition[
  另记 $arrow(dif l) = arrow(T^circle.small) dif l$，则 $arrow(dif l) = {cos alpha dif l, cos beta dif l, cos gamma dif l} = {dx, dy,dz}$，称为#def[有向弧长元素]。
]

== 第二类曲线积分的性质

#property(name: [线性性质])[
  $display(
    int_Gamma (a arrow(F) + beta arrow(G)) dif l = alpha int_Gamma arrow(F) dif l + beta int_Gamma arrow(G) dif l
  )$，其中 $alpha,beta$ 是常数。
]

#property(name: [弧段可加性])[
  设 $Gamma = Gamma_1 union Gamma_2$，$Gamma_1$ 与 $Gamma_2$ 没有公共内点，且 $Gamma_1,Gamma_2$ 的方向都与 $Gamma$ 的方向一致，则有 $display(
    int_Gamma arrow(F) arrow(dif l) = int_(Gamma_1) arrow(F) arrow(dif l) + int_(Gamma_2) arrow(F) arrow(dif l)
  )$。
]

#property[
  设曲线 $l$ 的端点为 $A,B$，则 $display(int_(Gamma_(A B)) arrow(F) arrow(dif l) = - int_(Gamma_(B A)) arrow(F) arrow(dif l))$。即改变曲线积分的方向，其结果添负号。
]

== 第二类曲线积分的计算

#theorem[
  设空间光滑曲线 $Gamma_(A B)$ 的参数方程为 $x = x(t); space y = y(t); space z = z(t)$ 起点 $A$ 所对应的参数值为 $t_A$，终点 $B$ 所对应的参数值为 $t_B$，且 $P(x,y,z),space Q(x,y,z),space R(x,y,z)$ 在 $Gamma_(A B)$ 上连续，则
  $
    & int_(Gamma_(A B)) P(x,y,z) dif x + Q(x,y,z) dif y + R(x,y,z) dif z\
    =& int_(t_A)^(t_B) (P(x(t),y(t),z(t)) x'(t) + Q(x(t),y(t),z(t)) y'(t) + R(x(t),y(t),z(t)) z'(t))
    dif t \
  $
]

#tip[
  【求力场 $arrow(F)$ 对运动质点所作的功 $W$】

  1. 利用 $arrow(F) = abs(F) arrow(F^circle.small)$，求出 $arrow(F) = P arrow(i) + Q arrow(j) + R arrow(k)$。

  2. 求出质点运动路径 $Gamma_(A B)$ 的参数方程。

  3. 写出功 $W$ 的积分表达式 $display(W = int_(Gamma_(A B)) P dx + Q dy + R dz)$ 并计算。
]

== 格林公式

#theorem[
  设 $D$ 是一个平面有界闭区域，它的边界 $Gamma$ 由有限条分段光滑的曲线组成。函数 $P(x,y)$，$Q(x,y)$ 在 $D$ 上连续，并且具有连续的偏导数，则
  #set math.mat(delim: "|")
  $
    intcb(Gamma) P dx + Q dy
    = iintb(D) ((diff Q) / (diff x) - (diff P) / (diff y)) dif sigma
    defeq iintb(D) mat(
      display(diff/(diff x)), display(diff/(diff y));
      P, Q
    ) dif sigma
  $
  #set math.mat(delim: "(")

  TBD：正向

  #proof[
    #grid(
      columns: (4fr, 1fr),
      [
        若 $D$ 是二维平面上的简单闭区域，即通过 $x$ 轴上的任一点，作平行于坐标轴的直线，这条直线与 $D$ 的边界曲线 $Gamma$ 至多有两个交点，但允许其中有一段是平行于坐标轴的直线段，这时，可设
        $
          D = {(x,y) | y_1(x)<=y<=y_2(x),space a<=x<=b}。
        $

        先证：
        $
          intcb(Gamma) P dif x = - iintb(D) (diff P) / (diff y) dif sigma。
        $
      ],
      [
        #align(center, image("images/2024-06-07-21-49-14.png", width: 100%))
      ],
    )
    设 $Gamma_1$ 是区域 $D$ 下方的一段边界曲线，$Gamma_2$ 是上方的一段，$Gamma_3$ 是垂直的一段，则
    $
      intcb(Gamma) P dif x
      &= intcb(Gamma_1) P dif x + intcb(Gamma_2) P dif x + intcb(Gamma_3) P dif x\
      &= int_a^b P(x,y_1(x)) dx + int_b^a P(x,y_2(x)) dx + 0\
      &= int_a^b P(x,y_1(x)) dx - int_a^b P(x,y_2(x)) dx
    $
    $
      - iintb(D) (diff P) / (diff y) dif sigma
      &= -int_a^b dx int_(y_1(x))^(y_2(x)) (diff P) / (diff y) dif y
      = - int_a^b atpos(P(x,y), y=y_1(x), y=y_2(x)) dx\
      &= - int_a^b P(x,y_2(x)) dx + int_a^b P(x,y_1(x)) dx
    $
    同理，$display(intcb(Gamma) Q dif y = iintb(D) (diff Q) / (diff x) dif sigma)$。两式相加即得
    $
      intcb(Gamma) P dx + Q dy = iintb(D) ((diff Q) / (diff x) - (diff P) / (diff y)) dif sigma
    $

    TBD：Ep 13-2 内里有洞的情形 01:15:23
  ]
]

== 平面曲线积分与路径的无关性

= 第二类曲面积分

== 第二类曲面积分的概念

= ?

== Stocks 公式

#theorem[
  设函数 $P(x,y,z)$，$Q(x,y,z)$，$R(x,y,z)$ 及其一阶偏导数在空间区域 $Omega$ 上连续，$S$ 是 $Omega$ 内的一张光滑曲面，曲面 $S$ 的边界曲线 $L$ 是分段光滑的连续曲线，$S$ 的法线方向与 $L$ 的方向符合右手法则（即人在 $S$ 的正侧沿 $L$ 行走时，$S$ 总位于他的左边），则
  #set math.mat(delim: "|")
  $
    intcb(L) P dx + Q dy + R dz
    =& iintb(S) ((diff R) / (diff y) - (diff Q) / (diff z)) dy dz
    + ((diff P) / (diff z) - (diff R) / (diff x)) dz dx
    + ((diff Q) / (diff x) - (diff P) / (diff y)) dx dy\
    =& iintb(S) mat(
      dy dz, dz dx, dx dy;
      display(diff/(diff x)), display(diff/(diff y)), display(diff/(diff z));
      P, Q, R)
    = iintb(S) mat(
      cos alpha, cos beta, cos gamma;
      display(diff/(diff x)), display(diff/(diff y)), display(diff/(diff z));
      P, Q, R) dif S
  $
  #set math.mat(delim: "(")

  #note[
    Stokes 公式中的曲面 $S$ 是以 $L$ 为边界的有侧光滑曲面。左端的积分值与以 $L$ 为边界的光滑曲面 $S$ 的形状无关。因此在计算中，可以选择最简单的曲面来求积分。
  ]
]

== 空间曲线积分与路径无关性

#definition(name: [空间线(面)单连通区域])[
  区域 $V$ 称为#def[线(面)单连通区域]，如果 $V$ 内任一封闭曲线(面)可以不经过 $V$ 以外的店而连续收缩于 $V$ 中的一点。

  #note[
    也就是说这一空间线(面)的内部没有洞，否则选上这个洞的空间线(面)就不可能连续收缩于一点。
  ]
]

#theorem[
  设 $V$ 是一个空间线单连通区域，若函数 $P(x,y,z)$，$Q(x,y,z)$，$R(x,y,z)$ 在区域 $V$ 上连续，且具有连续的一阶偏导数，则以下四个条件等价：

  (1) 对 $V$ 内任一分段光滑的封闭曲线 $L$，有 $display(intc_L P dx + Q dy + R dz) = 0$。

  (2) 对 $V$ 内任一分段光滑曲线 $Gamma_(A B)$，$display(int_(Gamma_(A B)) P dx + Q dy + R dz)$ 与路径 $Gamma$ 无关，只与起点 $A$ 和终点 $B$ 的位置有关。

  (3) 存在 $u(x,y,z),space (x,y,z) in V$，使 $du = P dx + Q dy + R dz$。这时，我们称 $u(x,y,z)$ 为 $P dx + Q dy + R dz$ 的一个原函数。

  (4) $display((diff P)/(diff y) = (diff Q)/(diff x))$，$display((diff Q)/(diff z) = (diff R)/(diff y))$，$display((diff R)/(diff x) = (diff P)/(diff z))$，$forall (x,y,z) in V$。

  #tip[
    【原函数的求法】

    既然曲线积分与路径 $Gamma$ 无关，只与起点 $A(x_0,y_0,z_0)$ 和终点 $B(x,y,z)$ 的位置有关，我们不妨设其沿着一条最简单的路径运动。

    $
      u(x,y,z) =& int_((x_0,y_0,z_0))^((x,y,z)) P(x,y,z) dx + Q(x,y,z) dy + R(x,y,z) dz + C\
      =& int_((x_0,y_0,z_0))^((x,y_0,z_0)) + int_((x_0,y_0,z_0))^((x,y,z_0)) + int_((x_0,y_0,z_0))^((x,y,z)) + C\
      =& int_(x_0)^x P(x,y_0,z_0) dx + int_(y_0)^y Q(x,y,z_0) dy + int_(z_0)^z R(x,y,z) dz + C
    $
  ]
]

== 曲线积分的牛莱公式

#theorem[
  若 $du (x,y,z) = P dx + Q dy + R dz$，则
  $
    int_(Gamma_(A B)) P dx + Q dy + R dz
    =& int_A^B P dx + Q dy + R dz
    = int_A^B du (x,y,z)
    = atpos(u(x,y,z), A, B)
    = u(B) - u(A)
  $
]

== 矢量场的旋度

#definition(name: [矢量场的循环量、环量])[
  在矢量场 $arrow(A) (M)$ 中，矢量 $arrow(A) (M)$ 沿有向封闭曲线 $L$ 的曲线积分 $display(intc_L arrow(A) dot dif arrow(l))$ 称为矢量场 $arrow(A) (M)$ 沿封闭曲线 $L$ 的#def[循环量]。
]

#definition(name: [平均循环量、平均环量密度])[
  设 $L$ 是所围的曲面为 $S$，其面积也记为 $S$，且 $L$ 的方向与 $S$ 的法矢量 $arrow(n)$ 的方向符合右手法则，则 $display(display(intc_L arrow(A) dot dif arrow(l))/(S))$ 称为矢量场 $arrow(A) (M)$ 沿封闭曲线 $L$ 的绕法矢量 $arrow(n)$ 的#def[平均循环量]，即循环量关于面积的平均变化率。
]

#definition(name: [环量密度])[
  设 $arrow(A) = arrow(A) (M)$ 是一个矢量场，$L$ 是场中的一条封闭光滑曲线，$S$ 是以 $L$ 为边界的任意光滑曲面，其面积也记为 $S$，$L$ 的方向与曲面 $S$ 的法矢量 $arrow(n)$ 的方向符合右手法则，如果平均循环量 $display(display(intc_L arrow(A) dot dif arrow(l))/(S))$ 当曲面 $S$ 按任意方式无限收缩于点 $M$ 时，极限 $display(lim_(S -> M) display(intc_L arrow(A) dot dif arrow(l))/S)$ 存在，则称此极限为矢量场 $arrow(A) (M)$ 在点 $M$ 处绕 $arrow(n)$ 的#def[环量密度]。

]

#definition(name: [旋度])[
  设矢量场 $arrow(A) (x,y,z) = P(x,y,z) arrow(i) + Q(x,y,z) arrow(j) + R(x,y,z) arrow(k)$ 满足 Stocks 公式的条件，则
  $
    intc_L arrow(A) dot dif arrow(l)
    &= intc_L P dx + Q dy + R dz\
    &= iintb(S) ((diff R) / (diff y) - (diff Q) / (diff z)) dy dz
    + ((diff P) / (diff z) - (diff R) / (diff x)) dz dx
    + ((diff Q) / (diff x) - (diff P) / (diff y)) dx dy\
    &= iintb(S) (
      ((diff R) / (diff y) - (diff Q) / (diff z)) arrow(i)
      + ((diff P) / (diff z) - (diff R) / (diff x)) arrow(j)
      + ((diff Q) / (diff x) - (diff P) / (diff y)) arrow(k)
    ) dot (dy dz arrow(i) + dz dx arrow(j) + dx dy arrow(k)))\
    &defeq iintb(S) rot arrow(A) dot arrow(dif S)
    = iintb(S) rot arrow(A) dot arrow(n^circle.small) dif S
  $

  即称
  #set math.mat(delim: "|")
  $
    rot arrow(A)
    = ((diff R) / (diff y) - (diff Q) / (diff z)) arrow(i)
    + ((diff P) / (diff z) - (diff R) / (diff x)) arrow(j)
    + ((diff Q) / (diff x) - (diff P) / (diff y)) arrow(k)
    defeq mat(
      arrow(i), arrow(j), arrow(k);
      display(diff/(diff x)), display(diff/(diff y)), display(diff/(diff z));
      P, Q, R;
    )
  $
  #set math.mat(delim: "(")
  为矢量场 $arrow(A)$ 在点 $M$ 处的#def[旋度]。
]

#theorem(name: [旋度与环量密度的关系])[
  矢量场 $arrow(A) (M)$ 在点 $M$ 处绕 $arrow(n)$ 的环量密度
  $
    display(lim_(S->M) display(intc_L arrow(A) dot dif arrow(l))/S = lim_(S->M) display(iintb(S) rot arrow(A) dot arrow(n^circle.small) dif S)/S)
  $
]