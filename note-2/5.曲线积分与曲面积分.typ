#import "../template.typ": *

#show: project.with(
  course: "Calculus II",
  course_fullname: "Calculus (A) II",
  course_code: "821T0160",
  semester: "Spring-Summer 2024",
  title: "Note #5: 曲线积分与曲面积分",
  authors: (
    (
      name: "memset0",
      email: "memset0@outlook.com",
      id: "3230104585",
    ),
  ),
  date: "April 9, 2024",
)

= 第一类曲线积分

== 第一类曲线积分的概念

*物理背景*：曲线段的质量。

#definition[
  若曲线 $L = {(x(t),y(t),z(t)) | t in [a,b]}$ 是 $RR^3$ 上的光滑曲线，则此曲线的#def[弧微分]公式为
  $
    dif s = sqrt((x' (t))^2 + (y'(t))^2 + (z'(t))^2) dif t
  $
]

#definition[
  设 $Gamma$ 是空间（或平面）中的一段以 $A,B$ 为端点的光滑曲线，$f(P)$ 为定义在 $Gamma$ 上的有界函数。把 $Gamma$ 分割成任意 $n$ 个小段 $Delta l_1,Delta l_1,dots.c,Delta l_n$，$Delta l_i$ 的长度仍用 $Delta l_i$ 来表示。记 $lambda = display(max_(1<=i<=n) {Delta l_i})$。$forall P_i in Delta l_i$，若和式极限
  $
    lim_(lambda->0) sum_(i=1)^n f(P_i) Delta l_i
  $
  存在，且极限值与曲线 $Gamma$ 的分法及 $P_i$ 点的取法无关，则称上述极限为 $f(P)$ 在 $Gamma$ 上的#def[第一类曲线积分]。
]

== 平面曲线积分的计算法

#theorem[
  设平面曲线 $Gamma$ 的参数方程为 $display(cases(
    x = x(t),
    y = y(t)
  ) space alpha <= t <= beta)$，其中 $x'(t), space y'(t)$ 在 $[alpha,beta]$ 上连续，则弧微分为 $display(dif l = sqrt(x'^2 (t) + y'^2 (t)) dif t)$。

  设 $f(x,y)$ 为 $Gamma$ 上的连续函数，则
  $
    int_Gamma f(x,y) dif l = int_alpha^beta f(x(t), y(t)) sqrt(x'^2 (t) + y'^2 (t)) dif t
  $
]

#note[
  计算第一类曲线积分时，不要忘记利用对称性化简，可参考二重积分利用对称性化简的部分。
]

#note[
  若曲线 $Gamma$ 的方程为 $r=r(theta),space theta in [alpha,beta]$，则
  $
    int_Gamma f(x,y) dif s = int_alpha^beta f(r cos theta, r sin theta) sqrt(r^2 (theta) + r'^2 (theta)) dif theta
  $
]

#tip[
  【空间质线的转动惯量】

  设有空间质线 $Gamma$，其线密度为连续函数 $mu(x,y,z)$，则质线关于 $L$ 轴的转动惯量为
  $
    I_L = int_Gamma overline(P P_L)^2 mu(x,y,z) dif l
  $
  其中，$overline(P P_L)$ 为点 $P(x,y,z)$ 到 $L$ 轴的距离。特殊的，质线关于 $x$ 轴的转动惯量为
  $
    I_x = int_Gamma (y^2 + z^2) mu(x,y,z) dif l
  $
  关于 $y,z$ 轴的转动惯量形式也相仿。
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

#conclusion[
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

#tip[
  【求 $I = display(int_L P dx + Q dy)$ 的步骤】（涉及到下文的格林公式和路径无关性）

  1. 先判断 $display((diff P)/(diff y) = (diff Q)/(diff x))$ 是否成立。若成立，则利用路径无关性的性质计算（注意：要求在所选路径上，$P,Q$ 及其偏导数连续）

  2. 若不成立，但 $display((diff Q)/(diff x) - (diff P)/(diff y))$ 较简单；

    2.1. 若 $L$ 封闭且 $P,Q$ 及其偏导数在 $L$ 所围的区域连续时，直接用格林公式。

    2.2. 若非闭，则添加简单曲线使其变成封闭曲线，再用格林公式。要求添加的简单曲线与 $L$ 所围的区域上，$P,Q$ 及其偏导数连续。
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
      columns: (3.5fr, 1fr),
      [
        (i) 若 $D$ 是二维平面上的简单闭区域（既是 $x$ 型区域又是 $y$ 型区域，即通过 $x$ 轴上的任一点，作平行于坐标轴的直线，这条直线与 $D$ 的边界曲线 $Gamma$ 至多有两个交点，但允许其中有一段是平行于坐标轴的直线段，这时，可设
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

    (ii) 若 $D$ 是一条按段光滑的闭曲线 $Gamma$ 围成的，则可用几段光滑曲线将 $D$ 分成有限个满足 (i) 的区域，然后应用 (i) 中的方法可推得相应的格林公式。

    (iii) 若 $D$ 是由多条曲线所围成的，同样可以应用类似方法。
  ]
]

== 平面曲线积分与路径无关性

#theorem(name: [平面曲线积分与路径无关的四个条件])[
  设 $D$ 是一个平面单连通区域，若函数 $P(x,y)$ 和 $Q(x,y)$ 在区域 $D$ 上连续，且具有连续的一阶偏导数，则以下四个条件等价：

  (1) 沿 $D$ 内任一分段光滑的封闭曲线 $L$，有 $display(intc_L P dx + Q dy = 0)$。

  (2) 对 $D$ 内任一分段光滑曲线 $Gamma_(A B)$，$display(int_(Gamma_(A B)) P dx + Q dy)$ 与路径 $Gamma$ 无关，只与起点 $A$ 与终点 $B$ 的位置有关。

  (3) $P dx + Q dy$ 是 $D$ 内某一函数 $u(x,y)$ 的全微分，即存在 $u(x,y),space (x,y) in D$，使 $dif u = P dx + Q dy$。

  (4) $display((diff P)/(diff y) = (diff Q)/(diff x))$，$forall (x,y) in D$。·

  #proof[
    #record("2024-05-30第3-5节 00:15:00")
  ]

  #tip[
    【原函数的求法】

    若曲线积分与路径 $Gamma$ 无关，只与起点 $A$ 和终点 $B$ 的位置有关，则
    $
      u(x,y)
      &= int_((x_0,y_0))^((x,y)) P(x,y) dx + Q (x,y) dy + C
      = int_((x_0,y_0))^((x,y_0)) + int_((x,y_0))^((x,y)) + C\
      &= int_(x_0)^x P(x,y_0) dx + int_(y_0)^y Q(x,y) dy + C
    $
  ]
]

#theorem(name: [平面曲线积分的牛莱公式])[
  若 $dif u (x,y) = P dx + Q dy$，则
  $
    int_(Gamma_(A B)) P dx + Q dy
    = int_A^B P dx + Q dy
    = int_A^B dif u(x,y)
    = atpos(u(x,y), A(x_1,y_1), B(x_2,y_2))
    = u(x_2,y_2) - u(x_1,y_1)
  $

  #proof[
    #record("2024-05-30第3-5节 00:32:47")
  ]
]

== 空间曲线积分与路径无关性

#definition(name: [空间线(面)单连通区域])[
  区域 $V$ 称为#def[线(面)单连通区域]，如果 $V$ 内任一封闭曲线(面)可以不经过 $V$ 以外的点而连续收缩于 $V$ 中的一点。

  #note[
    也就是说这一空间线(面)的内部没有洞，否则包含这个洞的空间线(面)就不可能连续收缩于一点。
  ]
]

#theorem(name: [空间曲线积分与路径无关的四个条件])[
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

#theorem(name: [空间曲线积分的牛莱公式])[
  若 $du (x,y,z) = P dx + Q dy + R dz$，则
  $
    int_(Gamma_(A B)) P dx + Q dy + R dz
    =& int_A^B P dx + Q dy + R dz
    = int_A^B du (x,y,z)
    = atpos(u(x,y,z), A, B)
    = u(B) - u(A)
  $
]

= 第二类曲面积分

== 第二类曲面积分的概念

*物理背景*：流速场中流体通过某定侧曲面的流量。

#definition[
  设 $S$ 是一个光滑曲面，则 $S$ 上处处都有连续变动的切平面和法线。$forall M in S$，曲面 $S$ 在点 $M$ 处的法线有两个方向；当取定一个方向为正向时，另一个方向为负向。过点 $M$ 作曲面 $S$ d 法矢量 $arrow(n)$。在曲面 $S$ 上取定一点 $M_0$，当动点 $M$ 从 $M_0$ 出发沿曲面不越过边界的任一封闭曲线连续移动且回到原来的位置，若其指向也不变，则称这种曲面是#def[双侧曲面]，否则称这种曲面为#def[单侧曲面]。
]

#definition[
  指定了法线方向的双侧曲面，称为#def[定侧曲面]。这里，我们只讨论双侧曲面。
]

#definition(name: [第二类曲面积分])[
  设 $S$ 是一个有界的光滑定侧曲面，$forall M(x,y,z) in S$，点 $M$ 处的沿曲面指定侧的单位法矢量为
  $
    arrow(n^circle.small) = arrow(n^circle.small)(x,y,z) = cos alpha arrow(i) + cos beta arrow(j) + cos gamma arrow(k)
  $
  又设
  $
    arrow(A) = arrow(A)(x,y,z) = P(x,y,z) arrow(i) + Q(x,y,z) arrow(j) + R(x,y,z) arrow(k)
  $
  其中函数 $P(x,y,z)$，$Q(x,y,z)$，$R(x,y,z)$ 是定义在 $S$ 上的有界函数。则
  $
    arrow(A) dot arrow(n^circle.small) = P(x,y,z) cos alpha + Q(x,y,z) cos beta + R(x,y,z) cos gamma
  $
  所以
  #set math.mat(delim: "|")
  $
    iintb(S) arrow(A) dot arrow(n^circle.small) dif S
    &= iintb(S) P(x,y,z) cos alpha dif S + iintb(S) Q(x,y,z) cos beta dif S + iintb(S) R(x,y,z) cos gamma dif S\
    &= iintb(S) P(x,y,z) dy dz + iintb(S) Q(x,y,z) dz dx + iintb(S) R(x,y,z) dx dy\
    &defeq iintb(S) P(x,y,z) dy dz + Q(x,y,z) dz dx + R(x,y,z) dx dy
    = iintb(S) mat(
      dy dz, dz dx, dx dy;
      P, Q, R
    ) dif S \
    &defeq arrow(A) dot arrow(dif S)\
  $
  #set math.mat(delim: "(")
  上式称为函数 $P(x,y,z),space Q(x,y,z), space R(x,y,z)$ 沿曲面 $S$ 指定侧的#def[第二类曲线积分]，也称为#def[对坐标的积分]。
]

== 第二类曲面积分的性质

#property(name: [线性性质])[
  若 $alpha,beta$ 为常数，则有 $
    iintb(S) (alpha arrow(A) + beta arrow(B)) arrow(dif S)
    = alpha iintb(S) arrow(A) dot arrow(dif S)
    + beta iintb(S) arrow(B) dot arrow(dif S)
  $
]

#property(name: [对定侧曲面的可加性])[
  若曲面 $S$ 分为两个曲面 $S_1$ 与 $S_2$，满足 $S = S_1 union S_2$，且 $S_1$ 与 $S_2$ 没有公共内点，但不改变曲面的侧，则
  $
    iintb(S) arrow(A) dot arrow(dif S)
    = iintb(S_1) arrow(A) dot arrow(dif S)
    + iintb(S_2) arrow(A) dot arrow(dif S)
  $
]

#property(name: [方向性])[
  若 $S^-$ 表示曲面 $S$ 的另一侧，则
  $
    iintb(S) arrow(A) dot arrow(dif S)
    = - iintb(S^-) arrow(A) dot arrow(dif S)
  $
  #proof[
    这是因为曲面不同的侧，每点处的 $arrow(n^circle.small)$ 方向恰好相反，故面积的投影相差一个负号。
  ]
]

== 第二类曲面积分的计算

第二类曲面积分的三个部分要分开计算，下面以 $display(iintb(S) R(x,y,z) dx dy)$ 为例。其中 $dx dy = cos gamma dif S$。考虑到：
$
  dx dy = cos gamma dif S = cases(
  dif sigma\,&quad cos gamma > 0,
  0\,&quad cos gamma = 0,
  -dif sigma\,&quad cos gamma < 0
)
$
我们可以得到
#conclusion[
  $
    iintb(S) R(x,y,z) dx dy
    = cases(
      display(iintb(sigma_(x y)) R(x,y,z(x,y)) dif sigma \,&quad gamma in [0,pi/2)),
      display(0 \,&quad gamma = pi/2),
      display(-iintb(sigma_(x y)) R(x,y,z(x,y)) dif sigma \,&quad gamma in (pi/2,pi]),
    )
  $
]

== 高斯公式

格林公式建立了沿封闭曲线的第二类曲线积分与二重积分的联系，类似地，沿空间闭曲面的第二类曲面积分和三重积分也有类似的联系。

#theorem(name: [高斯公式])[
  设 $V$ 是一个空间有界闭区域，它的边界 $S$ 由有限多个分片光滑曲面所围成。函数 $P(x,y,z)$，$Q(x,y,z)$，$R(x,y,z)$ 在 $V$ 上连续，且具有连续的偏导数，则
  $
    iintcb(S) P dy dz + Q dz dx + R dx dy
    = iiintb(V) ((diff P) / (diff x) + (diff Q) / (diff y) + (diff R) / (diff z)) dif V
  $
  其中上式左端的曲面 $S$ 取外侧，$cos alpha, cos beta, cos gamma$ 是曲面 $S$ 外法线的方向余弦。
]

== Stocks 公式

#theorem(name: [Stocks 公式])[
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

== 场论初步

=== 通量与散度

// TBD：https://classroom.zju.edu.cn/livingroom?course_id=60204&sub_id=1157684&tenant_code=112

#definition(name: [散度])[
  设 $arrow(A)(x,y,z) = P(x,y,z) arrow(i)$
]

=== 矢量场的旋度

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