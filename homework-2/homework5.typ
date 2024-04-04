#import "../template.typ": *

#show: project.with(
	course: "Calculus II",
	course_fullname: "Calculus (A) II",
	course_code: "821T0160",
	title: "Homework #5: 矢量与立体几何",
	authors: ((
		name: "Yulun WU",
		email: "memset0@outlook.com",
		id: "#198"
	),),
	semester: "Spring-Summer 2024",
	date: "April 3, 2024",
)

#let pp = math.bold(math.italic("p"))
#let aa = math.bold(math.italic("a"))
#let bb = math.bold(math.italic("b"))
#let cc = math.bold(math.italic("c"))
#let ee = math.bold(math.italic("e"))
#let ii = math.bold(math.italic("i"))
#let jj = math.bold(math.italic("j"))
#let kk = math.bold(math.italic("k"))
#let ff = math.bold(math.italic("f"))
#let gg = math.bold(math.italic("g"))
#let hh = math.bold(math.italic("h"))
#let nn = math.bold(math.italic("n"))
#let vv = math.bold(math.italic("v"))

= 习题7-4
== P27 4
#prob[
	证明矢量 $pp = (aa dot cc) bb - (bb dot cc) aa$ 与矢量 $cc$ 垂直。
]

$
pp dot cc
= (aa dot cc) dot bb dot cc - (bb dot cc) dot aa dot cc
= 0
$

所以矢量 $pp$ 与矢量 $cc$ 垂直。

== P27 6
#prob[
	设力 $ff = 2 ii - 3 jj + 4 kk$ 作用在一质点上，质点从 $M_1 (2, 4, -5)$ 沿直线运动到 $M_2 (4, 3, -2)$，求此力所做的功（力的单位为 N，位移的单位为 m）。
]

$
W = ff dot arrow(M_1 M_2)
= (2ii - 3jj + 4kk) dot (2ii - jj + 3kk)
= 19 upright("J")
$

== P27 8
#prob[
	已知 $A(2, 2, 2), sp B(3, 3, 2), sp C(3, 2, 3)$，求矢量 $arrow(A B)$ 与 $arrow(A C)$ 的夹角 $theta$，以及 $arrow(A B)$ 在 $arrow(A C)$ 上的投影。
]

$
arrow(A B) dot arrow(A C) = (ii + jj) dot (ii + kk) = 1
=>
cos(theta) = (arrow(A B) dot arrow(A C)) / (abs(arrow(A B)) abs(arrow(A C))) = 1 / 2
=>
theta = pi/3
$

$
(arrow(A B))_(arrow(A C)) = (arrow(A B) dot arrow(A C)) / abs(arrow(A C)) = sqrt(2) / 2
$

== P27 12
#prob[
	试求与矢量 $aa = 2 ii + 2 jj + kk, sp bb = - ii + 5 jj + 3 kk$ 都垂直的单位矢量。
]

#set math.mat(delim: "|")
$
aa times bb = mat(
	ii, jj, kk;
	2, 2, 1;
	-1, 5, 3;
) = ii - 7 jj + 12kk
$
#set math.mat(delim: "(")

$
ee_cc = pm (aa times bb)/(abs(aa times bb))
= pm (ii - 7 jj + 12 kk) / sqrt(194)
= pm (1/sqrt(194) ii - 7/sqrt(194) jj + 12/sqrt(194) kk)
$


== P27 14
#prob[
	设一三角形的三顶点为 $A(2, 2, 2), sp B(4, 3, 1), sp C(3, 5, 2)$，求该三角形的面积。
]

$
S = 1/2 abs(arrow(A B) times arrow(A C))
= 1/2 abs((2 ii + jj - kk) times (ii + 3jj))
= 1/2 |3 ii + jj + 5 kk| = 1/2 sqrt(35)
$

= 习题7-5
== P31 2
#prob[
	求以 $A(1, 1, 1), sp B(3, 6, 8), sp C(5, 10, 3), sp D(1, -1, 7)$ 为顶点的四面体的体积。
]

$
V = 1/6 abs(arrow(A B) dot (arrow(A C) times arrow(A D)))
= 1/6 abs((2 ii + 5 jj + 7 kk) dot (58 ii - 24 jj - 8 kk))
= 1/6 abs(-60) = 10
$

= 习题7-6
== P43 3
#prob[
	求通过直线 $L_1: sp display((x-1)/2 = (y+2)/3 = (z+3)/4)$ 且平行于直线 $L_2: sp display(x/1 = y/1 = z/2)$ 的平面方程。
]

直线的方向矢量为：

$
vv_1 &= 2ii+3jj+4kk\
vv_2 &= ii+jj+2kk
$

设所求平面的法向量为 $nn$，则

$
nn dot vv_1 = nn dot vv_2 = 0
=> nn = vv_1 times vv_2
= mat(
	ii, jj, kk;
	2, 3, 4;
	1, 1, 2
) = 2 ii - kk
$

取点 $(1, -2, -3)$ 代入得平面方程

$
2(x-1) - (k+3) = 0 => 2x - z - 5=0
$

== P43 4
#prob[
	求过点 $(1, 0, -2)$ 且与平面 $2x+y-1=0$ 及 $x-4y+2z-3=0$ 均平行的直线方程。
]

平面的法向量为：

$
nn_1 &= 2 ii + jj\
nn_2 &= ii - 4 jj + 2 kk\
$

则有 $vv bot nn_1 and vv bot nn_2$，故

$
vv = nn_1 times nn_2 = mat(
	ii, jj, kk;
	2, 1, 0;
	i, -4, 2;
) = 2 ii - 4 jj - 9 kk
$

再考虑到过点 $(1, 0, -2)$ 得直线方程

$
(x-1)/2 = y/(-4) = (z+2)/(-9)
$

== P43 9
#prob[
	求过点 $P(-1, 2, -3)$ 且垂直于矢量 $aa = {6, -2, -3}$，还与直线 $display((x-1)/3 = (y+1)/4 = (z-3)/(-5))$ 相交的直线方程。
]

过点 $(-1, 2, -3)$ 且垂直于矢量 $aa$ 的平面为

$ 6(x+1) -2(y-2) -3(z+3)=0 => 6x-2y-3z+1=0 $

联立可得于另一直线的交点

$
cases(
	6x-2y-3z+1=0,
	display((x-1)/3 = (y+1)/4 = (z-3)/(-5))
) => cases(
	x=1, y=-1, z=3
)
$

故所求直线过 $(-1, 2, -3)$ 和 $(1, -1, 3)$ 其方程为：

$
(x+1)/2 = (y-2)/(-3) = (z+3)/6
$

== P43 13
#prob[
	求直线 $display(cases(
		x+y-z-1=0\,,
		x-y+z+1=0
	))$ 在平面 $x+y+z=0$ 上的投影直线的方程。
]

直线的方向矢量：

$
vv = nn_1 times nn_2 = mat(
	ii, jj, kk;
	1, 1, -1;
	1, -1, 1;
) = - 2 jj - 2 kk
$

当前平面的法向量：

$
nn = ii  + jj + kk => ee_nn = 1/sqrt(3) (ii+jj+kk)
$

故投影直线的方向向量为：

$
vv' = vv - (vv dot ee_nn) ee_nn = 4/3 ii - 2/3 jj - 2/3 kk 
$

在原直线上任取一点 $(0, 1, 0)$，沿法向量平移得 

$
(0+t) + (1+t) + (0+t) = 0 => t = -1/3
$

可知投影直线过平面上一点 $display((-1/3, 2/3, -1/3))$。从而可得投影直线方程为

$
(x+1/3)/(4/3) = (y-2/3)/(-2/3) = (z+1/3)/(-2/3)
=> (x+1/3)/2 = (y-2/3)/(-1) = (z+1/3)/(-1)
$
