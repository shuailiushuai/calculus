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

设围线 $C$ 是区域 $D$ 的边界曲线，由题意知 $C$ 是正向的。根据格林公式得
$
  & intcb(C) (x+y)^2 dx - (x^2 + y^2) dy
  = iintb(D) ((diff (x^2 + y^2)) / (diff x) - (diff ((x+y)^2)) / (diff y)) dx dy\
  =& iintb(D) (2x - 2(x+y)) dx dy
  = -2 iintb(D) y dx dy
  = -2 (int_1^2 7 / 4 (y-1) y dy + int_2^5 (-7 / 12 y + 35 / 12) y dy)\
  =& -2 (49 / 12 - 21 / 8 - 819 / 36 + 735 / 24)
  = -56
$

#correction[
  注意 $P = - (x^2+y^2)$ 而不是 $P= x^2 + y^2$。所以应用格林公式后得到的积分应是：
  $
    iintb(D) (-(diff (x^2 + y^2)) / (diff x) - (diff ((x+y)^2)) / (diff y)) dx dy = iintb(D) (-4x-2y) dx dy
  $
]

== P212 4(4)
#prob[
  利用格林公式计算第二类曲线积分：
  $
    intb(accent(A B O, paren.t)) (e^x sin y - m y) dx + (e^x cos y - m) dy
  $
  其中 $accent(A B O, paren.t)$ 为由点 $A(a,0)$ 至点 $O(0,0)$ 的上半圆周 $x^2 + y^2 = a x$。
]

设区域 $D$ 的边界曲线为 $accent(A B O, paren.t)$ 与 $overline(O A)$ 拼接而成的曲线，记为 $L^+$。由格林公式得：
$
  & intb(accent(A B O, paren.t)) (e^x sin y - m y) dx + (e^x cos y - m) dy\
  =& iintb(D) (e^x cos y - (e^x cos y - m)) dx dy
  - intb(overline(O A)) (e^x sin y - m y) dx + (e^x cos y - m) dy\
  =& iintb(D) m dx dy - 0
  = m dot 1 / 2 dot pi (a / 2)^2
  = (pi m a^2) / 8
$

== P213 5
#prob[
  计算：
  $
    I=intcb(C) (x dy - y dx) / (x^2 + y^2)
  $
  式中 $C$ 为依正向而不经过坐标原点的简单封闭曲线。
]

设 $D$ 为正向封闭曲线 $C$ 所围成的区域，则依格林公式得：
$
  I &= iintb(D) ((diff display(x/(x^2+y^2))) / (diff x) + (diff display(y/(x^2+y^2))) / (diff y)) dx dy
  = intb(D) ((-x^2 + y^2) / ((x^2+y^2)^2) + (x^2 - y^2) / ((x^2+y^2)^2)) dx dy \
  &= 0
$

#correction[
  这是坐标原点在区域 $D$ 外部的情况，有 $I=0$；还需要考虑坐标原点在 $D$ 内部的情况，这时候由于 $P,Q$ 在坐标原点无定义，不能直接应用格林公式。

  取 $a>0$ 使得中心在原点半径为 $a$ 的圆周 $L_a$：$x^2+y^2=a^2$ 完全位于围线 $C$ 之内，用 $D'$ 来表示 $C$ 与 $L_a$ 之间的环形闭区域，显然，在 $D'$ 上，$P,Q$ 及其偏导数均连续，可用格林公式：
  $
    (intc_C + intc_(-L_a)) P dx + Q dy = iintb(D') ((diff Q) / (diff x) - (diff P) / (diff y)) dx dy = 0
  $
  故
  $
    I =& intcb(L_a) P dx + Q dy
    = intcb(L_a) (x dy - y dx) / (x^2 + y^2)
  $
  应用极坐标变换得
  $
    I =& int_0^(2 pi) (a cos theta dif (a sin theta) - a sin theta dif (a cos theta)) / ((a cos theta)^2 + (
      a sin theta
    )^2) dif theta\
    =& int_0^(2 pi) (a^2) / (a^2) dif theta
    = 2pi
  $
]

== P213 6
#prob[
  设位于点 $(0,1)$ 的质点 $A$ 对质点 $M$ 的引力大小为 $G"/"r^2$（$G>0$ 为万有引力系数，$r$ 为质点 $A$ 与 $M$ 之间的距离），质点 $M$ 沿曲线 $y=sqrt(2x - x^2)$ 自 $B(2,0)$ 运动到 $O(0,0)$，求在此过程中点 $A$ 对质点 $M$ 的引力所做的功。
]

万有引力的方向即两点间连线的方向，故：
$
  W
  &= int_accent(B M O, paren.t) arrow(A) dot arrow(T^circle.small) dif l
  = int_accent(B M O, paren.t) G / r^3 (x dx + (y-1) dy)
$
其中 $display(r = sqrt(x^2 + (y-1)^2))$。从物理意义出发，可验证 $display((diff Q)/(diff x) = (diff P)/(diff y))$ 且连续，故积分关于路径无关：
$
  W
  &= int_overline(B O) G / r^3 (x dx + (y-1) dy)
  = int_2^0 (x dx) / ((sqrt(x^2+1))^3)
  = k(1-1 / sqrt(5))
$
// #align(center, image("images/2024-06-12-11-51-46.png", width: 100%))

== P213 7(1)
#prob[
  利用第二类曲线积分计算曲线所围的面积：（星形线）
  $
    x = a cos^3 t, quad
    y = b sin^3 t quad
    (0 <= t <= 2pi)
  $
]

设 $D$ 为星形线所围成的区域，由格林公式得（取 $display(P = -1/2\;space Q=1/2)$）：
$
  S =& iintb(D) dx dy
  = 1 / 2 intc_C x dy - y dx
  = (3 a b) / 2 int_0^(2 pi) (cos^4 t sin^2 t + cos^2 t sin^4 t) dif t \
  =& 3 / 8 a b int_0^(2 pi) sin^2 t dif t
  = 3 / 8 pi a b
$

== P213 8(1)
#prob[
  计算第二类曲线积分：
  $
    int_((0,1))^((2,3)) (x+y) dx + (x-y) dy
  $
]

$P = x + y;space Q = x-y$ 都连续。且 $display((diff Q)/(diff x) = (diff P)/(diff y) = 1)$ 都连续。故原积分关于路径无关：

$
  & int_((0,1))^((2,3)) (x+y) dx + (x-y) dy
  = int_((0,1))^((2,1)) (x+y) dx + int_((2,1))^((2,3)) (x-y) dy\
  =& int_0^2 (x+1) dx + int_1^3 (2-y) dy
  = 4 + 0 = 4
$

== P213 8(3)
#prob[
  计算第二类曲线积分：
  $
    int_((0,-1))^((1,0)) (x dy - y dx) / ((x-y)^2)
  $
  沿着与直线 $y=x$ 不相交的路径。
]

由于 $display((diff Q)/(diff x)=(diff P)/(diff y))$ 且连续，故原积分关于路径无关：
$
  int_((0,-1))^((1,0)) (x dy - y dx) / ((x-y)^2)
  =& int_(0)^1 dx / ((x+1)^2) + int_(-1)^0 dy / ((1-y)^2)
  =& (atpos(-1/(1+x), 0, 1)) + (atpos(1/(1-y), -1, 0))
  = 1
$

== P213 9(1)
#prob[
  求原函数 $u$：
  $
    dif u = (x^2 + 2x y - y^2) dx + (x^2 - 2 x y - y^2) dy
  $
]
$
  (diff Q) / (diff x) = 2x - 2y; quad
  (diff P) / (diff y) = 2x - 2y
$
故 $display((diff Q) / (diff x) = (diff P)/(diff y))$ 且连续， 原积分关于路径无关。可以求得其原函数：
$
  u(x,y)
  &= int_0^x P(x,0) dx + int_0^y Q(x,y) dy + C
  = int_0^x x^2 dx + int_0^y (x^2 - 2x y - y^2) dy + C\
  &= x^3 / 3 + x^2 y - x y^2 - y^3 / 3 + C
$

== P213 9(2)
#prob[
  求原函数 $u$：
  $
    dif u = (y dx - x dy) / (3x^2 - 2x y + 3y^2)
  $
]
$
  (diff Q) / (diff x)
  &= diff / (diff x) ((-x) / (3x^2 - 2 x y + 3 y^2))
  = (-(3x^2 - 2 x y + 3 y^2) + x(6x - 2y)) / ((3x^2 - 2 x y + 3 y^2)^2)
  = (3(x^2-y^2)) / ((3x^2 - 2 x y + 3 y^2)^2)\
  (diff P) / (diff y)
  &= diff / (diff y) ((y) / (3x^2 - 2 x y + 3 y^2))
  = ((3x^2 - 2 x y + 3 y^2) - y(2x + 6y)) / ((3x^2 - 2 x y + 3 y^2)^2)
  = (3(x^2 - y^2)) / ((3x^2 - 2 x y + 3 y^2)^2)
$
故 $display((diff Q) / (diff x) = (diff P)/(diff y))$ 且连续， 原积分关于路径无关。可以求得其原函数：
$
  u(x,y)
  &= int_0^x P(x,0) dx + int_0^y Q(x,y) dy + C
  = int_0^y (-x dy) / (3x^2 -2x y + 3y^2) + C\
  &= -x / 3 int_0^y dy / (y^2 - 2 / 3 x y + x^2) + C
  = -1 / (2 sqrt(2)) arctan (3y-x) / (2 sqrt(2) x) + C // TBD：好难算
$