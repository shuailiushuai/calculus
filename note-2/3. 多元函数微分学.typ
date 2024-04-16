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

#let defeq = math.attach("=", t: math.Delta)

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

	(2) $forall P_0 (x_0,y_0) in diff D,space display(lim_(x->x_0\ y->y_0\ (x,y) in D) f(x,y) = f(x_0,y_0))$。

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
	存在，则称此极限为函数 $z=f(x,y)$ 在点 $(x_0,y_0)$ 处对 $x$ 的#def[偏导数]。记作 $f'_x (x_0,y_0), display(lr((diff f)/(diff x)|)_((x_0,y_0)))$ 或 $lr(z'_x|)_((x_0,y_0)), display(lr((diff z)/(diff x)|)_((x_0,y_0)))$。
]