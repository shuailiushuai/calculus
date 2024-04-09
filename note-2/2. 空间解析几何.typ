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

#set math.mat(delim: "|")
#let aa = math.bold(math.italic("a"))
#let bb = math.bold(math.italic("b"))
#let cc = math.bold(math.italic("c"))
#let dd = math.bold(math.italic("d"))
#let ee = math.bold(math.italic("e"))
#let ii = math.bold(math.italic("i"))
#let jj = math.bold(math.italic("j"))
#let kk = math.bold(math.italic("k"))
#let rr = math.bold(math.italic("r"))
#let vv = math.bold(math.italic("v"))
#let nn = math.bold(math.italic("n"))
#let mm = math.bold(math.italic("m"))


= 行列式与矢量代数

== 行列式

=== 二阶行列式

$
mat(a_11,a_12;a_21,a_22) = a_11 a_22 - a_12 a_21 
$

二阶矩阵的行列式为主对角线的积减去次对角线的积。

=== 三阶行列式

$
mat(a_11,a_12,a_13;a_21,a_22,a_23;a_31,a_32,a_33)
&= a_11 mat(a_22 a_23; a_32 a_33) - a_12 mat(a_21, a_23; a_31, a_33) + a_13 mat(a_21, a_22; a_31, a_32)\
&= a_11 a_22 a_33 + a_12 a_23 a_31 + a_13 a_21 a_32 - a_13 a_22 a_31 - a_12 a_21 a_33 - a_11 a_23 a_32\
$

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

#theorem(name: "三个矢量共面的充要条件之一")[
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

== 空间中的矢量

=== 矢量的坐标表示

#definition[
	起点在原点的矢量，设 $M(x, y, z)$，$rr = x ii + y jj + z kk= {x,y,z}$，称为#def[矢径] $rr=arrow(O M)$ 的坐标表达式。
]

#definition[
	由勾股定理可知 $abs(rr) = abs(arrow(O M)) = sqrt(x^2+y^2+z^2)$，称为矢量#def[模的坐标表示]。
]

#definition[
	非零矢量与三条坐标轴的正向的夹角 $alpha,beta,gamma$ 称为#def[方向角]。设 $rr=arrow(O M)={x,y,z}$，分析可知：
	$ x = abs(rr) cos alpha quad quad y = abs(rr) cos beta quad quad z = abs(rr) cos gamma $
	把 $cos alpha, cos beta, cos gamma$ 成为矢量 $rr$ 的#def[方向余弦]。当 $abs(rr) != 0$ 时，有：
	$ cos alpha = x/sqrt(x^2+y^2+z^2) quad quad cos beta = y/sqrt(x^2+y^2+z^2) quad quad cos gamma = z/sqrt(x^2+y^2+z^2) $
	容易发现，$ee_rr = display(rr/abs(rr)) = {cos alpha, cos beta, cos gamma}$。故常用方向余弦来表示矢量的方向。
]

#theorem[
	对于任意向量 $rr$，其方向余弦满足：
	$ cos^2 alpha + cos^2 beta + cos^2 gamma = 1 $
]

=== 数量积

#definition[
	矢量 $aa$ 与 $bb$ 的#def[数量积]记为 $aa dot bb$，
	$ aa dot bb = abs(aa) abs(bb) cos theta $
	其中 $theta$ 为 $aa$ 与 $bb$ 的夹角。数量积也称为#def[点积]。坐标表达式为
	$ aa dot bb = a_x b_x + a_y b_y + a_z b_z $
]

#theorem(name: "数量积的几何意义")[
	矢量 $aa$ 在矢量 $bb$ 上的投影长度记为 $(aa)_bb$，有 $(aa)_bb = aa dot ee_bb$。
]

#theorem(name: "两个矢量相互垂直的充要条件")[
	$aa perp bb <=> aa dot bb = 0$。
]

=== 矢量积

#definition[
	矢量 $aa$ 与 $bb$ 的#def[矢量积] $cc = aa times bb$ 规定为：

	- 大小：$abs(cc) = abs(aa) abs(bb) sin theta$；

	- 方向：$cc$ 的方向同时垂直于 $aa$ 和 $bb$，且 $aa, bb$ 与 $cc$ 成右手系。

	TBD：配图

	矢量积也称为#def[叉积]、#def[外积]。坐标表达式为：
	$
	aa times bb
	= (a_y b_z - a_z b_y) ii - (a_x b_z - a_z b_x) jj + (a_x b_y - a_y b_x) kk
	= mat(ii, jj, kk; a_x, a_y, a_z; b_x, b_y, b_z)
	$
]

#theorem(name: "矢量积的几何意义")[
	矢量 $aa,bb$ 的矢量积的模等于以这两个向量为邻边的平行四边形面积，即 $S = abs(aa times bb)$。
]

#theorem(name: "两个矢量平行的充要条件")[
	$aa parallel bb <=> aa times bb = bold(0)$
]

#theorem(name: "矢量积的运算定律")[
	
	1. 反交换律：$aa times bb = - bb times aa$。
	2. 分配律：$(aa + bb) times cc = aa times cc + bb times cc$。
	3. 若 $lambda$ 为数：$(lambda aa) times bb = aa times (lambda bb) = lambda (aa times bb)$。
]

#theorem(name: "基本单位矢量的矢量积")[
	对于一组基本单位矢量 $ii,jj,kk$，有：
	$ ii times ii = jj times jj = kk times kk = 0 quad quad ii times jj = kk, quad jj times kk = ii, quad kk times ii = jj $
]

=== 混合积

#definition[
	三个矢量 $aa,bb,cc$ 的#def[混合积]为 $(aa times bb) dot cc$。坐标表达式为：

	$ (aa times bb) dot cc = mat(a_x, a_y, a_z; b_x, b_y, b_z; c_x, c_y, c_z) $
]

#theorem(name: "混合积的几何意义")[
	矢量 $aa,bb,cc$ 的混合积的绝对值等于以这三个矢量为邻边的平行六面体的体积。即 $V = abs((aa times bb) dot cc)$。
]

#theorem(name: "三个矢量共面的充要条件之二")[
	三矢量 $aa,bb,cc$ 共面 $<=>$ $(aa times bb) dot cc = 0$。
]

#theorem(name: "混合积的轮换对称性")[
	$ (aa times bb) dot cc = (cc times aa) dot bb = (bb times cc) dot aa $
	#note[
		由行列式的性质，不难得到这一结论。
	]
]

== 平面

=== 平面方程

#definition(name: "平面的点法式方程")[
	过点 $M_0(x_0, y_0, z_0)$ 且与矢量 $nn=(A,B,C)$ 垂直的平面方程为
	$ A(x-x_0) + B(y-y_0) + C(z-z_0) = 0 $

	称为#def[平面的点法式方程]。将 $nn = {A,B,C}$ 称为平面的#def[法矢量]。
]

#note[
	1. 这说明平面可用三元一次方程表示；反之，任一三元一次方程在 $A,B,C$ 不全为 $0$ 时表示一张平面。

	2. 求两个不共线矢量 $aa,bb$ 张成的平面，就可以求出 $nn=aa times bb$ 为法向量，而得到平面的点法式方程。
]

#definition(name: "平面的一般式方程")[
	对于平面的点法式方程，令 $D = -A x_0 - B y_0 - C z_0$，得
	$ A x + B y + C z + D = 0 $
	当 $A,B,C$ _不全为 $0$_ 时，称为#def[平面的一般式方程]。
]

#definition(name: "平面的截距式方程")[
	设平面与 $x,y,z$ 三轴的交点为 $P(a,0,0)$、$Q(0,b,0)$、$R(0,0,c)$，则此平面方程为
	$ x/a  +y/b + z/c = 1 $
	称为#def[平面的截距式方程]。
]

=== 两平面的夹角

#definition(name: "平面的夹角")[
	两平面法矢量的夹角称为两平面的夹角。
]

=== 点到平面的距离

#theorem(name: "点到平面的距离公式")[
	设 $P_0(x_0,y_0,z_0)$ 是平面 $A x+B y+C z+D=0$ 外一点，则 $P_0$ 到平面的距离为
	$ d = abs(A x_0 + B y_0 + C z_0 + D)/sqrt(A^2 + B^2 + C^2) $
]

#note[
	计算点到平面的距离时，直接套用公式是一种方法。还可以通过点坐标和平面的法向量得到点到平面的垂线的点向式方程，将这一垂线的参数式方程代入平面方程即可解出垂足坐标，从而用两点距离公式得到距离。
]

== 空间直线

=== 空间直线方程

#definition(name: "直线的一般式方程")[
	空间直线可看成两个不平行平面的交线，即方程组
	$ cases(A_1 x + B_1 y + C_1 z + D_1 = 0, A_2 x + B_2 y + C_2 z + D_2 = 0) $
	其中，$A_1,B_1,C_1$ 与 $A_2,B_2,C_2$ 不对应成比例，则称为#def[直线的一般式方程]。
]

#definition(name: "直线的点向式方程")[
	过点 $M_0 (x_0,y_0,z_0)$ 且与矢量 $vv = {l,m,n}, space (vv != bold(0))$ 平行的直线 $L$ 可被表示为

	$ (x-x_0)/l = (y-y_0)/m = (z-z_0)/n $

	当 $l,m,n$ _不全为 $0$_ 时，称为#def[直线的点向式方程]。

	#warning[
		1. 当 $l=0$ 时形式不变，但应理解为 $x=x_0$ 且 $display((y-y_0)/m = (z-z_0)/n)$；对于 $m,n$ 同理。

		2. 方程不作化简，如 $display((x-6/5)/3=(y+2)/(-2)=(z-1)/3)$ _不能_化简为 $display((5x-6)/15=-(y+3)/2=(z-1)/3)$。
	]
]

#definition(name: "直线的参数式方程")[
	对于直线的点向式方程，取 $display((x-x_0)/l = (y-y_0)/m = (z-z_0)/n = t)$，可以得到
	$ cases(
		x = x_0 + l t,
		y = y_0 + m t,
		z = z_0 + n t
	) $
	称为#def[直线的参数式方程]，$l,m,n$ 称为直线的一组#def[方向数]。
]

#definition(name: "直线的两点式方程")[
	过两点 $A(x_1,y_1,z_1)$ 和 $B(x_2,y_2,z_2)$ 的直线方程为
	$ (x-x_1)/(x_2-x_1) = (y-y_1)/(y_2-y_1) = (z-z_1)/(z_2-z_1) $
	称为#def[直线的两点式方程]。
]

=== 两条直线的位置关系

#definition(name: "空间直线的夹角")[
	设直线 $L_1$ 的方向矢量为 $vv_1$，直线 $L_2$ 的方向矢量为 $vv_2$，称 $vv_1$ 和 $vv_2$ 之间的夹角 $theta$ 或 $pi - theta$ 为直线 $L_1$ 和 $L_2$ 的夹角。
]

=== 直线与平面的位置关系

#definition(name: "直线与平面的夹角")[
	设直线 $L$ 的方向矢量为 $vv$，平面 $pi$ 的法矢量为 $nn$，若 $(nn,vv) = theta$，则称 $display(pi/2-theta)$ 或 $theta - display(pi/2)$ 为直线 $L$ 和平面 $pi$ 的夹角。
]

=== 点到直线的距离

#theorem(name: "点到直线的距离公式")[
	直线 $L:space display((x-x_0)/l = (y-y_0)/m = (z-z_0)/n)$ 到点 $P(x_1,y_1,z_1)$ 的距离为
	$ d = (arrow(M P) times vv)/vv $
	其中 $M(x_0,y_0,z_0) in L$，$vv$ 是直线的方向矢量。
]

=== 直线在平面上的投影直线方程

TBD


=== 两条异面直线的距离

#theorem(name: "两条异面直线的距离公式")[
	设直线 $L_1$ 和 $L_2$ 是两条异面直线，直线 $L_1$ 的方向矢量为 $vv_1$，直线 $L_2$ 的方向矢量为 $vv_2$，则两条直线的公垂线 $L$ 的方向矢量为 $vv = vv_1 times vv_2$。取 $M_1 in L_1,space M_2 in L_2$，则 $L_1,L_2$ 的距离为
	$ d = (arrow(M_1 M_2) dot vv)/abs(vv) = (arrow(M_1 M_2) dot (vv_1 times vv_2))/abs(vv_1 times vv_2) $
]

== 平面束

#definition[
	称过直线 $L$ 的所有平面构成的集合为直线 $L$ 的#def[平面束]。设直线 $L$ 的方程为
	$ cases(A_1 x + B_1 y + C_1 z + D_1 = 0, A_2 x + B_2 y + C_2z + D_2 = 0) $
	其中，$A_1,B_1,C_1$ 和 $A_2,B_2,C_2$ 不对应成比例。则直线 $L$ 的#def[平面束方程]为：
	$ lambda(A_1 x + B_1 y + C_1 z + D_1) + mu(A_2 x + B_2 y + C_2 z + D_2) = 0 $
]

== 曲面

=== 曲面

#definition(name: "曲面方程")[
	若曲面 $S$ 与三元方程 $F(x,y,z)=0$ 有如下关系：

	(1) $S$ 上任一点的坐标都满足方程 $F(x, y, z) = 0$；
	
	(2) 坐标满足方程 $F(x, y, z) = 0$ 的点都在 $S$ 上。

	那么，方程 $F(x, y, z)=0$ 叫做曲面 $S$ 的方程；曲面 $S$ 叫做 $F(x,y,z)=0$ 的图形。
]

#definition(name: "球面方程")[
	球心在点 $M_0(x_0,y_0,z_0)$，半径为 $R$ 的#def[球面方程]为：
	$ (x-x_0)^2 + (y-y_0)^2 + (z-z_0)^2 = R^2 $
]

#definition(name: "曲面的参数方程")[
	曲面 $S$ 的参数方程为：
	$ cases(x=x(u,v), y=y(u,v), z=z(u,v)) $
	其中 $u,v$ 是参数。

	#note[
		特别地，球面的参数方程为：
		$ cases(
			x = x_0 + R sin phi cos theta,
			y = y_0 + R sin phi sin theta,
			z = z_0 + R cos phi
		), quad (0 <= phi <= pi,space 0 <= theta <= 2 pi) $
	]
]

=== 空间曲线

#definition(name: "空间曲线的一般式方程")[
	空间曲线 $C$ 可看做空间两曲面的交线，即方程组
	$ cases(F(x,y,z) = 0, G(x,y,z) = 0) $
]

#definition(name: "空间曲线的参数方程")[
	空间曲线 $C$ 的参数方程为：
	$ cases(x = x(t), y = y(t), z = z(t)) $
	其中 $t$ 是参数。
]

#definition(name: "空间曲线在平面上的投影")[
	设空间曲线 $Gamma$ 的方程为 $display(cases(F_1(x,y,z)=0,F_2(x,y,z)=0))$，消去变量 $z$ 得 $G(x,y)=0$。称 $G(x,y)=0$ 为曲线 $Gamma$ 在 $x O y$ 平面上的#def[投影柱面]；称 $display(cases(G(x,y)=0,z=0))$ 为曲线 $Gamma$ 在 $x O y$ 平面上的#def[投影曲线]。类似的，可以得到在 $y O z$ 和 $x O z$ 平面上的投影曲线和投影柱面的定义。

	#caution[当心隐含的定义域范围限制。]
]

=== 柱面

#definition[
	由动直线 $L$ 沿着一定曲线 $Gamma$ 平行移动所形成的曲面称为#def[柱面]。称动直线 $L$ 为柱面的#def[母线]，定曲线 $Gamma$ 为柱面的#def[准线]。
]

=== 锥面

#definition[
	过空间一定点 $O$ 的一条动直线 $L$，沿空间_不过定点_的定曲线 $Gamma$ 移动所形成的曲面 $Sigma$ 称为#def[锥面]。称定点 $O$ 为锥面的#def[顶点]，动直线 $L$ 为锥面的#def[母线]，定曲线 $Gamma$ 为锥面的#def[准线]。
]

#example[
	#problem[
		设锥面 $Sigma$ 的准线 $Gamma$ 的方程为 $display(cases(F(x,y)=0,z=h))space (h!=0)$，且以原点为顶点，试求锥面 $Sigma$ 的方程。
	]

	#solution[
		$forall M(x,y,z) in Sigma$，设过点 $M$ 的母线与准线 $Gamma$ 的交点为 $M_1(x_1,y_1,h)$，则 $arrow(O M_1) parallel arrow(O M)$，故 
		$ x_1/x = y_1/y=h/z $
		解得 $display(x_1 = h/z x\,space y_1 = h/z y)$，故所求锥面方程为 $F(display(h/z x\,h/z y))=0$。
	]

	#note[
		为什么有条件 $h!=0$？因为锥面的准线不能过其顶点。
	]

	特别地，将这里的准线方程换为 $display(cases(display(x^2/a^2 + y^2/b^2 =1), z=c)) space (c!=0)$，则锥面方程为 $display(x^2/a^2 + y^2/b^2 = z^2/c^2)$。称为#def[椭圆锥面]。将准线方程换为 $display(cases(x^2+y^2=a^2,z=c)) space (c!=0)$，则锥面方程为 $x^2+y^2=display(a^2/c^2 z^2)$，称为#def[圆锥面]。
]

=== 旋转曲面

#definition[
	由一条曲线，绕一条定直线旋转，所生成的曲面称为#def[旋转曲面]。称这条定直线为旋转曲面的#def[旋转轴]。
]

#example[
	#problem[
		设曲线 $Gamma$ 的参数方程为 $display(cases(x=x(t),y=y(t),z=z(t)))$，假定 $Gamma$ 不是垂直于 $z$ 轴的平面上的曲线，求 $Gamma$ 绕 $z$ 轴旋转而成的旋转曲面 $Sigma$ 的方程。
	]

	#solution[
		$forall M(x,y,z) in Sigma$，设点 $M$ 由点 $M_1(x_1,y_1,z) in Sigma$ 绕 $z$ 轴旋转而得，对应的参数是 $t_1$，则
		$ x_1=x(t_1),quad y_1=y(t_1),quad z=z(t_1) $
		解得 $x_1=x(z^(-1)(z)), space y_1 = y(z^(-1)(z))$。故所求曲面方程即
		$ x^2+y^2 = [x(z^(-1)(z))]^2 + [y(z^(-1)(z))]^2 $
	]
]

#conclusion[
	对于部分特殊曲线和旋转轴对应的旋转曲面方程，有下表：

	#table3(
		width: 70%,
		columns: (2fr, 0.7fr, 2.5fr),
		[*曲线*], [*旋转轴*], [*旋转曲面方程*],
		[#v(0.5em)$display(Gamma\:space cases(f(y,z)=0,x=0))$#v(0.5em)], [$z$ 轴], $f(pm sqrt(x^2+y^2),z)=0$,
		[#v(0.5em)$display(Gamma\:space cases(f(y,z)=0,x=0))$#v(0.5em)], [$y$ 轴], $f(y,pm sqrt(x^2+z^2))=0$,
		[#v(0.5em)$display(Gamma\:space cases(f(x,z)=0,y=0))$#v(0.5em)], [$z$ 轴], $f(pm sqrt(x^2+y^2),z)=0$,
		[#v(0.5em)$display(Gamma\:space cases(f(x,z)=0,y=0))$#v(0.5em)], [$x$ 轴], $f(x,pm sqrt(y^2+z^2))=0$,
		[#v(0.5em)$display(Gamma\:space cases(f(x,y)=0,z=0))$#v(0.5em)], [$x$ 轴], $f(x,pm sqrt(y^2+z^2))=0$,
		[#v(0.5em)$display(Gamma\:space cases(f(x,y)=0,z=0))$#v(0.5em)], [$y$ 轴], $f(pm sqrt(x^2+z^2),y)=0$
	)
]

#example[
	#problem[
		$z=sqrt(x^2+y^2)$ 在空间解析几何中表示什么图形。
	]
	
	#solution[
		可以发现，这是旋转轴为 $z$ 轴的旋转曲面。可看做曲线 $display(cases(z=sqrt(x^2+y^2),x=0))$ 绕 $z$ 轴旋转的结果。解得 $display(cases(z=|y|,x=0))$。画图可知，这是一个圆锥面。
	]
]

== 二次曲面

#definition[
	二次曲线$ a x^2 + b y^2 + c z^2 + d x y + e x z + f y z + g x + h y + i z + j = 0 $所表示的曲面称为#def[二次曲面]。一般用#def[截痕法]来了解二次曲面方程所表示曲面的总体特征。
]

=== 椭球面

#definition[
	二次曲线 $display(x^2/a^2 + y^2/b^2 + z^2/c^2 = 1)$ 所表示的二次曲面称为#def[椭球面]。

	用平行于坐标平面的平面对椭球面进行切割，得到是椭圆。

	特别地，当 $a=b$ 时，这是一个以 $z$ 轴为旋转轴的椭球面，称为#def[旋转椭球面]。当 $a=b=c$ 时，称为#def[球面]。
]

=== 椭圆抛物面

#definition[
	二次曲线 $z=display(x^2/a^2+y^2/b^2)$ 所表示的二次曲面称为#def[椭圆抛物面]。

	用平面 $x=0$ 或 $y=0$ 切割椭圆抛物面，得到的是抛物线；用平面 $z=h$ 切割，得到的是椭圆。

	特别地，当 $a=b$ 时，这是一个以 $z$ 轴为旋转轴的椭圆抛物面，称为#def[旋转抛物面]。
]

=== 单叶双曲面

#definition[
	二次曲线 $display(x^2/a^2+y^2/b^2-z^2/c^2=1)$ 所表示的二次曲面称为#def[单叶双曲面]。

	用平面 $x=0$ 或 $y=0$ 切割单叶双曲面，得到的是双曲线；用平面 $z=h$ 切割，得到是椭圆。
]

=== 双叶双曲面

#definition[
	二次曲线 $display(x^2/a^2+y^2/b^2-z^2/c^2=-1)$ 所表示的二次曲面称为#def[双叶双曲面]。

	切割双叶双曲面得到的图像与单叶双曲面类似。
]

=== 椭圆锥面

#definition[
	二次曲线 $display(x^2/a^2+y^2/b^2-z^2/c^2=0)$ 所表示的二次曲面称为#def[椭圆锥面]。
]

=== 双曲抛物面

#definition[
	二次曲线 $display(z=-x^2/a^2+y^2/b^2)$ 所表示的二次曲面称为#def[双曲抛物面]。
]

== 旋转变换$""^*$

#definition[
	#set math.mat(delim: "(")
	在二维平面直角坐标系中，我们把平面围绕坐标原点按逆时针方向旋转 $phi$ 角的变换，称为旋转变换，记作 $bold(R)_phi$。$forall alpha = display(mat(x;y))$，设 $bold(R)_phi(alpha)$ 的坐标为 $display(mat(x';y'))$，则
	$
	mat(x';y') = mat(cos phi,-sin phi;sin phi,cos phi) mat(x;y)
	quad => quad
	cases(
		x' = x cos phi - y sin phi,
		y' = x sin phi + y cos phi,
	)
	$
	#set math.mat(delim: "|")
]
