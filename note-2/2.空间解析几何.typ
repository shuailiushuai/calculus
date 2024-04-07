#import "../template.typ": *

#show: project.with(
	course: "Calculus II",
	course_fullname: "Calculus (A) II",
	course_code: "821T0160",
	semester: "Spring-Summer 2024",
	title: "Note #2 空间解析几何",
	authors: ((
		name: "Yulun WU",
		email: "memset0@outlook.com",
		id: "3230104585"
	),),
	date: "April 7, 2024",
)

#let aa = math.bold(math.italic("a"))
#let bb = math.bold(math.italic("b"))
#let cc = math.bold(math.italic("c"))
#let dd = math.bold(math.italic("d"))
#let ee = math.bold(math.italic("e"))
#let ii = math.bold(math.italic("i"))
#let jj = math.bold(math.italic("j"))
#let kk = math.bold(math.italic("k"))
#let rr = math.bold(math.italic("r"))


= 行列式与矢量代数

== 行列式

=== 二阶行列式

#set math.mat(delim: "|")
$
mat(a_11,a_12;a_21,a_22) = a_11 a_22 - a_12 a_21 
$
#set math.mat(delim: "(")

二阶矩阵的行列式为主对角线的积减去次对角线的积。

=== 三阶行列式

#set math.mat(delim: "|")
$
mat(a_11,a_12,a_13;a_21,a_22,a_23;a_31,a_32,a_33)
&= a_11 mat(a_22 a_23; a_32 a_33) - a_12 mat(a_21, a_23; a_31, a_33) + a_13 mat(a_21, a_22; a_31, a_32)\
&= a_11 a_22 a_33 + a_12 a_23 a_31 + a_13 a_21 a_32 - a_13 a_22 a_31 - a_12 a_21 a_33 - a_11 a_23 a_32\
$
#set math.mat(delim: "(")

== 矢量

=== 矢量的概念

#definition[
	关于矢量的若干基本概念：

	1. #def[数量]：只有大小，没有方向的量，记作 $a, b, c$ 等。

	2. #def[矢量]：既有大小，又有方向的量，记作 $aa, bb, cc$（或 $arrow(a),arrow(b),arrow(c)$）等。

	3. #def[自由矢量]：矢量不规定起点的位置。

	4. #def[模]：矢量的大小，记为 $abs(arrow(A B))$ 或 $abs(aa)$。

	5. #def[单位矢量]：模为 $1$ 的矢量。

	6. #def[零矢量]：模为 $0$ 的矢量，记为 $arrow(0)$，方向任意。
]


#definition[
	关于矢量的若干基本关系：

	1. #def[相等]：矢量 $aa$ 与 $bb$ 大小相等且方向相同，即通过平移可以使他们重合，记为 $aa=bb$。

	2. #def[平行（或共线）]：矢量 $aa$ 与 $bb$ 的方向相同或相反，记为 $a parallel b$。

	3. #def[共面]：与同一个平面平行的矢量，称为#def[共面矢量]。
]

#definition[
	设有非零向量 $aa,bb$。平移，使他们的起点重合，则此时的夹角 $theta sp (0<=theta<=pi)$ 称为矢量 $aa$ 与 $bb$ 的#def[夹角]，记为 $(aa,bb)$。特别地，当 $theta = display(pi/2)$ 时，称 $aa$ 与 $bb$ #def[垂直]，记作 $aa perp bb$。

	特殊地，规定零矢量与任意矢量的夹角可以是任意值。
]

=== 矢量的线性运算

关于矢量的加法与减法略。

==== 矢量的数乘

#definition[
	设 $lambda$ 为实数。数 $lambda$ 与矢量 $aa$ 的乘积是一个矢量，记作 $lambda aa$。

	- 当 $lambda > 0$ 时，$lambda aa$ 与 $aa$ 同向；
	- 当 $lambda < 0$ 时，$lambda aa$ 与 $aa$ 反向；
	- 当 $lambda = 0$ 时，$lambda aa = bold(0)$，它的方向可以是任意的。
]

#theorem(name: "两个矢量共线的充要条件")[
	设 $aa != bold(0)$，则 $bb parallel aa$ 的充要条件是存在唯一实数 $k$ 使得 $bb = k aa$。
]

#theorem(name: "三个矢量共面的充要条件")[
	设 $aa,bb$ 不共线，则 $cc$ 与 $aa,bb$ 共面的充要条件是存在唯一实数 $lambda,mu$ 使得 $cc = lambda aa + mu bb$。
]

==== 矢量的单位化

#definition(name: "矢量的单位化")[
	设 $aa != bold(0)$，则 $display(aa/abs(aa))$ 表示与 $aa$ 方向相同的单位矢量，记为 $ee_aa$。。
]

==== 矢量在三维空间中的分解

#theorem[
	设 $aa,bb,cc$ 不共面，则对于空间中的任意一个向量 $dd$，存在唯一实数 $lambda,mu,upsilon$ 使得 $dd = lambda aa + mu bb + upsilon cc$。
]

= 空间解析几何

== 空间直角坐标系

空间直角坐标系要求是_右手系_。

#definition(name: "卦限")[
	TBD：图。
]

#definition(name: "基本单位矢量")[
	用 $ii, jj, kk$ 分别表示沿 $x,y,z$ 轴正方向的单位向量。

	TBD：图。
]

#definition(name: "矢径")[
	起点在原点的矢量，设 $M(x, y, z)$，$rr = x ii + y jj + z kk= {x,y,z}$，称为矢径 $rr=arrow(O M)$ 的坐标表达式。
]