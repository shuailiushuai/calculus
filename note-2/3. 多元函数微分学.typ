#import "../template.typ": *

#show: project.with(
	course: "Calculus II",
	course_fullname: "Calculus (A) II",
	course_code: "821T0160",
	semester: "Spring-Summer 2024",
	title: "Note #3 多元函数微分学",
	authors: ((
		name: "Yulun WU",
		email: "memset0@outlook.com",
		id: "3230104585"
	),),
	date: "April 9, 2024",
)

= 多元函数微分学

== $n$ 维空间

#theorem(name: [$n space.thin$维空间的距离公式])[
	设 $P_1 (x_1,x_2,dots.c,x_n)$，$P_2 (y_1,y_2,dots.c,y_n)$，则
	$ |P_1 P_2| = sqrt((y_1-x_1)^2 + (y_2-x_2)^2 + dots.c + (y_n-x_n)^2) $
]

#definition(name: [$n space.thin$维空间的邻域])[
	设 $P_0 (p_1,p_2,dots.c,p_n) in RR^N$，$delta$ 是某一正数，点 $P_0$ 的 $delta$ 邻域，记为 $U(P_0,delta)$。
	$ U(P_0,delta) = {P | abs(P P_0) < delta} = lr({(x_1,x_2,dots.c,x_n) mid(|) sqrt(sum_(i=1)^n (x_i - p_i)^2) < delta}) $
]

#definition(name: [内点、外点、边界])[
	设 $E subset RR^n$，

	(1) 对于 $M in E$，若 $exists delta > 0$，使得 $U(M,delta)<E$，则称 $M$ 为 $E$ 的一个#def[内点]。

	(2) 对于点 $P in.not E$，若 $exists delta > 0$，使得 $U(P,delta) sect E = emptyset$，则称 $P$ 为 $E$ 的一个#def[外点]。

	(3) 对于点 $Q$，若 $forall delta > 0$，$U(Q,delta)$ 内总有属于 $E$ 的点，又有不属于 $E$ 的点，则称 $Q$ 为 $E$ 的一个#def[边界点]。

	(4) $E$ 的全体边界点构成的集合，称为 $E$ 的#def[边界]，记作 $diff E$。

	(5) $E$ 的全体内点构成的集合，称为 $E$ 的#def[内部]，记作 $"int" E$。

	#tip[
		【画图（一般为 $n=2$ 的情况）】
		
		- 平面直角坐标系要有箭头、方向、坐标轴名称和_必要的_刻度单位。
		- $E$ 的边界要用虚线表示，$E$ 的内部要用阴影表示。
	]
]

#definition(name: [开集、闭集])[
	设 $E subset RR^n$，

	(1) 若 $E$ 中任一点都是 $E$ 的内点，则称 $E$ 为#def[开集]。

	(2) 若 $E$ 在 $RR^n$ 中的余集 $RR^n-E$ 是一个开集，则称 $E$ 为#def[闭集]。

	(3) 若 $E$ 中任意两点，总可以用含于 $E$ 的一条折线连接起来，则称集合 $E$ 是#def[连通的]。

	(4) 连通的开集称为#def[开区域]。

	(5) 开区域连同其边界所构成的点集称为#def[闭区域]。

	(6) 开区域，闭区域，或者开区域连同其一部分边界点组成的点集统称为#def[区域]。

	(7) 若 $exists r > 0$，使得 $E subset U(O,r)$，则称 $E$ 是#def[有界集]；否则，称 $E$ 是#def[无界集]。
]

== 多元函数的概念

#definition[
	设 $D$ 是 $RR^n$ 中的一个非空子集，若存在一个对应规则 $f$，使得 $forall P in D$，有唯一的实数 $u$ 与之对应，则称 $f$ 是定义在 $D$ 上的一个函数，或说 $u$ 是点 $P$ 的函数，简称#def[点函数]。记作
	$ u=f(P),space P in D $
	集合 $D$ 称为函数 $f$ 的#def[定义域]。集合 ${u | u = f(P), P in D} defeq R(f)$ 称为函数 $f$ 的#def[值域]。

	对于函数 $u=f(P),space P in D$，若点 $P(x_1,x_2,dots.c,x_n) in D$，则
	$ u = f(x_1,x_2,dots.c,x_n),space (x_1,x_2,dots.c,x_n) in D $
	称为#def[ $n$ 元函数]，其中 $x_1,x_2,dots.c,x_n$ 称为#def[自变量]，$u$ 称为#def[因变量]。
]

#definition(name: [二元函数的对称])[
	$f(x,y)$ 关于 $x,y$ #def[对称] $<==>$ $f(x,y) = f(y,x)$。

	例如：函数 $f(x,y) = display((x y)/(x^2+y^2))$ 关于 $x,y$ 是对称的。
]

== 多元函数的极限

#definition[
	设函数 $u=f(P)$ 在点 $P_0$ 的某一空心邻域内有定义，$A$ 是一个常数。若
	$ forall eps > 0, space exists delta > 0, space "当 " P in U^o (P_0,delta) "时，有 " abs(f(P) - A) < eps $
	则称 $A$ 是函数 $u=f(P)$ 当 $P -> P_0$ 时的#def[极限]，记作
	$ lim_(P->P_0) f(P) = A $
]

#definition[
	我们把二元函数的极限称为#def[二重极限]，记为
	$
	lim_((x,y) -> (x_0,y_0)) f(x,y) = A
	quad quad "或" quad quad
	lim_(x->x_0\ y->y_0) f(x,y) = A
	$

	#note[
		- #box(width: 100%)[
			平面上 $P(x,y)->P_0 (x_0,y_0)$ 的方式有无穷多种，
			$ lim_((x,y) -> (x_0,y_0)) f(x,y) = A $ 
			要求不管 $P$ 以何种形式趋于 $P_0$，$f(x,y)$ 均趋于 $A$。
		]
		- 二元函数的极限运算法则与一元函数类似。变量替换，等价无穷小替换，夹逼定理等方法仍然可以适用。
	]
]

#example[
	#problem[
		求 $display(lim_((x,y)->(0,0)) (x^2 y)/(x^2+y^2))$。
	]

	#solution[
		由基本不等式 $display(abs(x y) <= 1/2 abs(x^2+y^2))$ 知
		$
		abs((x^2 y)/(x^2 + y^2)) <= 1/2 abs((x(x^2+y^2))/(x^2+y^2)) = 1/2 abs(x) -> 0 quad ((x,y) -> (0,0))
		$
	]
]


#tip[
	【确定二重极限不存在的方法】

	找两种特殊的趋近方式，若得到不同的极限，则可断言二重极限 $display(lim_((x,y) -> (x_0,y_0)) f(x,y) = A)$ 不存在。

	#example[
		#problem[
			考察 $f(x,y)=display((x y)/(x^2+y^2))$ 当 $(x,y)->(0,0)$ 时的极限。
		]

		#solution[
			沿 $x$ 轴考察，$display(lim_((x,y)->(0,0)\ y=0) f(x,y) = lim_(x->0) 0/(x^2) = 0)$。而 $display(lim_((x,y)->(0,0)\ y=x) f(x,y) = lim_(x->0) (x^2)/(x^2+x^2) + 1/2 != 0)$。故当 $(x,y)->(0,0)$ 时，$f(x,y)$ 无极限。
		]
	]
]

== 多元函数的连续性

=== 函数的全增量与偏增量

#definition(name: [函数全增量])[
	设二元函数 $z=f(x,y)$ 在点 $P_0 (x_0,y_0)$ 的某一邻域内有定义。称
	$
	Delta = x - x_0,quad Delta y =y - y_0
	$
	为 $z=f(x,y)$ 在点 $P_0 (x_0,y_0)$ 处的#def[自变量增量]。称
	$
	Delta z = f(x_0+Delta x,y_0+Delta y)-f(x_0,y_0)
	$
	为 $z=f(x,y)$ 在点 $P_0 (x_0,y_0)$ 处的#def[全增量]。
]

#definition(name: [函数偏增量])[
	设二元函数 $z=f(x,y)$ 在点 $P_0 (x_0,y_0)$ 的某一邻域内有定义。称
	$
	f(x_0+Delta x,y_0) - f(x_0,y_0) defeq Delta_x z
	$
	为 $z=f(x,y)$ 在点 $P_0(x_0,y_0)$ 处关于 $x$ 的#def[偏增量]。
]

=== 二元函数函数连续的定义

#definition(name: [二元函数在一点处来连续的定义])[
	设二元函数 $z=f(x,y)$ 在点 $P_0(x_0,y_0)$ 的某一邻域内有定义。若
	$ lim_((x,y) -> (x_0,y_0)) f(x,y) = f(x_0,y_0) quad "即" quad lim_(Delta x->0\ Delta y->0) Delta z = 0 $
	则称 $z=f(x,y)$ 在点 $P_0(x_0,y_0)$ 处#def[连续]。
]

#definition(name: [二元函数在开区域连续的定义])[
	设二元函数 $z=f(x,y)$ 在开区域 $D$ 内有定义，若函数 $z=f(x,y)$ 在开区域 $D$ 内每一点都连续，则称 $z=f(x,y)$ 在开区域 $D$ 内#def[连续]。
]

#definition(name: [二元函数在闭区域连续的定义])[
	设二元函数 $z=f(x,y)$ 在闭区域 $D$ 上有定义，若

	(1) $forall P_0 (x_0,y_0) in "int" D,space display(lim_(x->x_0\ y->y_0) f(x,y) = f(x_0,y_0))$，即 $z=f(x,y)$ 在 $"int" D$ 内每一点处都连续。

	(2) $forall P_0 (x_0,y_0) in diff D,space display(lim_(space space x->x_0\ space space y->y_0\ (x,y) in D) f(x,y) = f(x_0,y_0))$。

	则称 $z=f(x,y)$ 在闭区域 $D$ 上#def[连续]。
]

=== 有界闭区域上连续函数的性质

#theorem(name: [最大值和最小值定理])[
	在有界闭区域 $D$ 上的多元连续函数，必定在 $D$ 上有界，且能取得它的最大值和最小值。
]

#theorem(name: [介值定理])[
	在有界闭区域 $D$ 上的多元连续函数必取得介于最大值和最小值之间的任何值。
]




== 偏导数

#definition[
	设函数 $z=f(x,y)$ 在点 $(x_0,y_0)$ 的某一邻域内有定义，如果极限
	$
	lim_(Delta x -> 0) (Delta_x z)/(Delta x) = lim_(x->0) (f(x_0 + Delta x,y_0) - f(x_0,y_0))/(Delta x)
	$
	存在，则称此极限为函数 $z=f(x,y)$ 在点 $(x_0,y_0)$ 处对 $x$ 的#def[偏导数]。记作 $f'_x (x_0,y_0), atpos((diff f)/(diff x), (x_0,y_0), "")$ 或 $atpos(z'_x, (x_0,y_0), ""), atpos((diff z)/(diff x), (x_0,y_0), "")$。
]

#tip[
	可以适当调换求偏导和代入顺序，来简化运算。
]

#note[
	几何意义：由 $f'_x (x_0,y_0) = atpos(dif/(dif x) f(x, y_0), x=x_0, "")$ 知，$f'_x (x_0,y_0)$ 在几何上表示曲线 $display(cases(z=f(x,y),y=y_0))$ 在对应点 $  M_0 (x_0,y_0,f(x_0,y_0))$ 处的切线 $M_0 T_x$ 对 $x$ 轴的斜率（与 $x$ 轴正向夹角的正切）。
]

#caution[
	求分界点处的偏导数要用定义求。
]

== 高阶偏导数

#definition[
	TBD

	$
	(diff)/(diff x)((diff z)/(diff x)) = (diff^2 z)/(diff x^2) = f''_(x x)
	quad quad quad quad quad
	(diff)/(diff y)((diff z)/(diff y)) = (diff^2 z)/(diff y^2) = f''_(y y)
	$

	混合偏导数

	$
	(diff)/(diff y)((diff z)/(diff x)) = (diff^2 z)/(diff x diff y) = f''_(x y)
	quad quad quad quad quad
	(diff)/(diff x)((diff z)/(diff y)) = (diff^2 z)/(diff y diff x) = f''_(y x)
	$
]

#theorem[
	若函数 $z=f(x,y)$ 的二阶偏导数 $f''_(x y)(x,y)$ 和 $f''_(y x) (x,y)$ 都在点 $P_0 (x_0,y_0)$ 处连续，则
	$
	f''_(x y) (x_0,y_0) = f''_(y x) (x_0,y_0)	
	$
	更近一步地，我们有：

	若混合偏导数连续，则混合偏导数与求导顺序无关。
]

== 全微分

#definition[
	若二元函数 $z=f(x,y)$ 在点 $(x,y)$ 处的#def[全增量] $Delta z=f(x+Delta x,y+Delta y)-f(x,y)$ 可以表示为
	$
	Delta z = A Delta x + B Delta y + o(rho) quad (rho=sqrt((Delta x)^2 + (Delta y)^2) -> 0)
	$
	其中 $A,B$ 与增量 $Delta x,Delta y$ 无关，只与 $x,y$ 有关，则称函数 $f(x,y)$ 在点 $(x,y)$ 处#def[可微]。其中 $A Delta x + B Delta y$ 称为函数 $f(x,y)$ 在点 $(x,y)$ 处的#def[全微分]，记作 $dif z$。
]

#theorem[
	若二元函数 $z=f(x,y)$ 在点 $(x,y)$ 处可微，则：
	
	(1) $f(x,y)$ 在点 $(x,y)$ 处连续。

	(2) $f(x,y)$ 在点 $(x,y)$ 处的两个偏导数 $f'_x (x,y)$ 和 $f'_y (x,y)$ 都存在，且 $A = f'_x (x,y), B = f'_y (x,y)$。
]

#theorem(name: [全微分公式])[
	若二元函数 $z=f(x,y)$ 在区域 $D$ 上的每点 $(x,y)$ 处都可微，则称函数 $f$ 在区域 $D$ 上可微，且 $f$ 在 $D$ 上的全微分为
	$
	dif z = f'_x (x,y) dif x + f'_y (x,y) dif y
	quad "或记" quad
	dif z = pz/px dif x + pz/py dif y
	$
]

#caution[
	注意 $f'_x (x,y)$ 和 $f'_y (x,y)$ 都存在不能推出函数的全微分存在，需要另验证函数是否可微。如例题中给的例子 $f(x,y) = display(cases(display((2x y)/sqrt(x^2+y^2))\,quad& x^2+y^2!=0, 0\,&x^2+y^2=0))$。
]

#theorem(name: [可微的充分条件])[
	若二元函数 $z=f(x,y)$ 的偏导数 $f'_x (x,y)$，$f'_y (x,y)$ 在点 $(x_0,y_0)$ 处连续，则 $z=f(x,y)$ 在点 $(x_0,y_0)$ 处可微。
]

#tip[
	【验证多元函数可微的另一种方法】证明多元函数 $z=f(x,y)$ 满足以下性质：

	(1) $f(x,y)$ 在点 $(x,y)$ 处连续。

	(2) $f'_x (x_0,y_0)$ 和 $f'_y (x_0,y_0)$ 都存在。

	(3) $display(lim_(Delta x->0\ Delta y->0) (Delta z - f'_x (x_0,y_0) Delta x - f'_y (x_0,y_0) Delta y)/rho = 0)$，其中 $rho = sqrt(Delta x^2 + Delta y^2)$。

	反过来，可以用这些条件证明多元函数不可微。
]

== 复合函数的偏导数

#definition[
	若 $z=f(u,v)$ 而 $u=phi(x,y)$，$v=psi(x,y)$，于是称 $z$ 是 $x$ 与 $y$ 的#def[复合函数]：
	$
	z = f(phi(x,y), psi(x,y))
	$
]

#theorem(name: [偏导数公式])[
	若函数 $u=phi(x,y)$，$v=psi(x,y)$ 在点 $(x,y)$ 处的偏导数都存在，$z=f(u,v)$ 在点 $(u,v)=(phi(x,y),psi(x,y))$ 处可微，则复合函数 $z=f(phi(x,y),psi(x,y))$ 在点 $(x,y)$ 处的偏导数存在且
	$
	pz/px = pz/pu dot pu/px + pz/pv dot pv/px
	quad quad
	px/py = pz/pu dot pu/py + pz/pv dot pv/py
	$
]

#definition[
	若 $z=f(u,v)$，$u=phi(x)$，$v=psi(x)$，则称 $z$ 是一个自变量 $x$ 的复合函数，记 $display((dif z)/(dif x))$ 为#def[全导数]。
]

#theorem(name: [全导数公式])[
	若 $z=f(u,v)$，$u=phi(x)$，$v=psi(x)$，则 $z$ 关于 $x$ 的全导数为
	$
	(dif z)/dx = pz/pu dot du/dx + pz/pv dot dv/dx
	$
]

#theorem(name: [全微分的形式不变性])[
	设 $z=f(u,v)$，$u=u(x,y)$，$v=v(x,y)$ 都有连续偏导数，则复合函数 $z=f(u(x,y),v(x,y))$ 可微，且有
	$
	dif z = pz/pu dot du + pz/pv dot dv
	$

	#proof[
		$
		dif z
		&= pz/px dot dx + pz/py dy
		= (pz/pu pu/px + pz/pv pv/px) dif x + (pz/pu pu/py + pz/pv pv/py) dif y\
		&= pz/pu (pu/px dx + pu/py dy) + pz/pv (pv/px dx + pv/py dy)
		= pz/pu du + pz/pv dv
		$
	]
]

== 隐函数的偏导数

=== 一元隐函数的偏导数

#theorem(name: [一元隐函数存在定理])[
	设函数 $F(x,y)$ 满足：

	(1) $F(x_0,y_0) = 0$；

	(2) 在点 $P(x_0,y_0)$ 的某一邻域内 $F$ 具有连续的偏导数 $F'_x, F'_y$；

	(3) $F'_y (x_0,y_0) != 0$，

	则在点 $P(x_0,y_0)$ 的某一邻域内存在唯一的隐函数 $y=f(x)$，满足 $F(x,y) equiv 0$，且有连续的导数 $display((dif y)/(dif x)=-(F'_x)/(F'_y))$。

	#proof[
		考虑 $F(x,y(x))=0$，求全导数得 $F'_x + F'_y display((dif y)/(dif x))$，移项解得 $display((dif y)/(dif x) = -(F'_x)/(F'_y))$。
	]

	#note[
		第 (2) 和 (3) 条条件可以保证分母不为零。
	]
]

=== 二元隐函数的偏导数

#theorem(name: [二元隐函数存在定理])[
	设函数 $F(x,y,z)$ 满足：

	(1) $F(x_0,y_0,z_0)= 0$；

	(2) 在点 $P(x_0,y_0,z_0)$ 的某一邻域内 $F$ 具有连续的偏导数 $F'_x, F'_y, F'_z$；

	(3) $F'_z (x_0,y_0,z_0) != 0$，

	则在点 $P(x_0,y_0,z_0)$ 的某一邻域内存在唯一的隐函数与 $z=f(x,y)$，满足 $F(x,y,f(x,y))=0$，且有连续的偏导数 $display((diff z)/(diff x) = - (F'_x)/(F'_z)\;quad (diff z)/(diff y) = -(F'_y)/(F'_z))$。
]

== 场的方向导数与梯度

=== 场的概念

#definition[
	设空间区域 $V$ 上的每一点 $P$，对应着某个物理量所确定的值，则称空间区域 $V$ 确定了该物理量的#def[场]。如果这个量是数量，则称为#def[数量场]；如果这个量是矢量，则称为#def[矢量场]。

	不随时间的变化二变化的场，称为#def[稳定场]；否则，称为#def[不稳定场]。
]

#definition[
	设给定一个数量场 $u=u(P),space P in V$，称具有同函数值 $C$（是一个常数）的点 $P$ 的集合所形成的曲面
	$
	{P in V | u(P) = C}
	$
	为#def[等值面]。在二维平面中的情况称为#def[等值线]。
]

=== 数量场的方向导数

#definition[
	设有数量场 $u=u(P),space P in V$。$P_0 in V$，$l$ 是从 $P_0$ 出发的一条射线。在 $l$ 上任取一点 $P$，$P != P_0$，则 $u(P)$ 在线段 $P_0 P$ 上的平均变化率为
	$
	(u(P) - u(P_0))/(abs(P_0 P))
	$
	若极限
	$
	lim_(P -> P_0) (u(P) - u(P_0))/abs(P_0 P)
	$
	存在，则称此极限为数量场 $u(P)$ 在点 $P_0$ 处沿方向 $l$ 的#def[方向导数]，记作 $lr(display((diff u)/(diff bold(l)))|)_(P_0\ )$。

	记 $rho = abs(P_0 P)$。特别地，在二维平面上，设数量场为 $Z=f(x,y),space (x,y) in D,space P_0 (x_0,y_0) in D$，方向 $bold(l) = {cos phi, sin phi},space P(x_0 + Delta x, y_0 + Delta y) in l$，则 $Delta x = rho cos phi, space Delta y = rho sin phi, space rho = sqrt(Delta x ^2 + Delta y^2)$，那么
	$
	lr((diff z)/(diff bold(l))|)_(P_0\ ) = lim_(rho -> 0) (f(x_0+rho cos phi, y_0 rho sin phi) - f(x_0, y_0))/rho
	$
]

#theorem[
	若函数 $u=u(x, y ,z)$ 在点 $P_0 (x_0, y_0, z_0)$ 处偏导数连续，则 $u$ 在点 $P_0$ 处沿任一方向 $l$ 的方向导数都存在，且
	$
	lr((diff u)/(diff bold(l))|)_(P_0\ ) = lr((diff u)/(diff x)|)_(P_0\ ) cos alpha + lr((diff u)/(diff y)|)_(P_0\ ) cos beta + lr((diff u)/(diff z)|)_(P_0\ ) cos gamma
	$
	其中，方向 $l$ 上的单位矢量为
	$
	bold(l)^circle.small = {cos alpha, cos beta, cos gamma}
	$
]

#note[
	分区域定义的函数，若在点 $P_0$ 处的偏导数不连续，则可以考虑用定义来讨论方向导数的存在性或计算。
]

=== 数量场的梯度

若函数 $u=u(x, y, z)$ 在点 $P_0 (x_0, y_0, z_0)$ 处可微，则
$
lr((diff u)/(diff bold(l))|)_(P_0\ ) = (lr((diff u)/(diff x)|)_(P_0\ ) bold(i) + lr((diff u)/(diff y)|)_(P_0\ ) bold(j) + lr((diff u)/(diff z)|)_(P_0\ ) bold(k)) dot (cos alpha bold(i) + cos beta bold(j) + cos gamma bold(k)) defeq bold(G) (P_0) dot bold(l)^circle.small = abs(bold(G) (P_0)) cos theta
$

#definition[
	称
	$
	((diff u)/(diff x) bold(i) + (diff u)/(diff y) bold(j) + (diff u)/(diff z) bold(k)) _(P_0)
	$
	为数量场 $u=u(x, y, z)$ 在点 $P_0$ 处的#def[梯度]，记作 $atpos(grad u, P_0, "")$
]

#theorem[
	数量场 $u(P)$ 在点 $P_0$ 处沿 $bold(l)$ 方向的方向导数等于梯度在 $bold(l)$ 方向上的_投影_，且方向导数沿梯度方向取得最大值，最大值等于梯度的模。即
	$
	atpos((diff u)/(diff bold(l)), P_0, "") = atpos(grad u, P_0, "") dot bold(l)^circle.small
	;quad quad quad
	max(atpos((diff u)/(diff bold(l)), P_0, "")) = abs(atpos(grad u, P_0, "")) 
	$
]

== 多元函数的极值

#definition[
	设函数 $z=f(x,y)$ 在点 $(x_0,y_0)$ 的某邻域内有定义。若对于该邻域内任意点 $(x,y)$，都有

	(1) $f(x,y) >= f(x_0,y_0)$，则称 $f(x_0,y_0)$ 为 $f(x,y)$ 的极小值，称 $(x_0,y_0)$ 为 $f(x,y)$ 的极小值点；

	(2) $f(x,y) <= f(x_0,y_0)$，则称 $f(x_0,y_0)$ 为 $f(x,y)$ 的极大值，称 $(x_0,y_0)$ 为 $f(x,y)$ 的极大值点；
]

=== 极值的必要条件

#theorem[
	设函数 $z=f(x,y)$ 在点 $(x_0,y_0)$ 具有偏导数，且在点 $(x_0,y_0)$ 处有极值，则它在该点的偏导数必然为零：
	$
	f'_x (x_0,y_0) = f'_y (x_0,y_0) = 0
	$
	称该点为该函数的 #def[驻点]。
]

=== 极值的充分条件

#theorem[
	设函数 $z=f(x,y)$ 在点 $(x_0,y_0)$ 的某邻域内连续，有一阶及二阶连续偏导数。若 $f'_x (x_0,y_0) = 0$，$f'_y (x_0,y_0) = 0$，零 $f''_(x x) (x_0,y_0) = A,space f''_(x y) (x_0,y_0) = B,space f''_(y y) (x_0,y_0) = C$，则 $f(x,y)$ 在点 $(x_0,y_0)$ 处是否取得极值的条件如下：

	(1) $B^2-A C < 0$ 时具有极值，且当 $A<0$ 时有极大值，$A>0$ 时有极小值（可以证明 $A,C$ 同号）；

	(2) $B^2 - A C > 0$ 时没有极值；

	(3) $B^2 - A C = 0$ 时可能有极值，可能没有极值。
]

#tip[
	【求多元函数的极值点】

	1. 找出极值的嫌疑点：驻点，不可导点。

	2. 通过极值点的充分条件验证，不能直接验证时用定义或其他方法进行判定。
]

#tip[
	【求多元函数的最大值和最小值】

	1. 找出最值的嫌疑点：驻点，不可导点，边界点（只需要算出在边界上的最大值和最小值即可）。

	2. 计算以上诸点处的函数值并作比较，其中最大者即为最大值，最小者即为最小值。
]

=== 条件极值问题

#theorem(name: [拉格朗日乘数法])[
	求函数 $z=f(x,y)$ 在约束条件 $phi(x,y)=0$ 下的条件极值，引入拉格朗日函数
	$
	F(x,y,lambda) = f(x,y) + lambda phi(x,y)
	$
	其中 $lambda$ 为参数。令：
	$
	cases(
		F'_x = f'_x (x,y) + lambda phi'_x (x,y) = 0,
		F'_y = f'_y (x,y) + lambda phi'_y (x,y) = 0,
		F'_lambda phi(x,y) = 0
	)
	$
	解出 $x,y,lambda$，其中 $x,y$ 就是可能的极值点的坐标。若这样的点唯一，由实际问题，可直接确定此即所求的点。
]