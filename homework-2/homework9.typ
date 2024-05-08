#import "../template.typ": *

#show: project.with(
	course: "Calculus II",
	course_fullname: "Calculus (A) II",
	course_code: "821T0160",
	title: "Homework #9：隐函数的偏导数 & 方向导数与梯度",
	authors: ((
		name: "Yulun WU",
		email: "memset0@outlook.com",
		id: "#198"
	),),
	semester: "Spring-Summer 2024",
	date: "May 7th, 2024",
)

= 习题8-4
== P98 7
#prob[
	已知 $x y = x f(z) + y g(z)$，$x f'(x) + y g'(z) != 0$，证明：
	$
	(x-g(z)) pderi(z,x) = (y-f(z)) pderi(z,y)
	$
]

两边同时对 $x$ 求偏导得
$
y = f(z) + x f'(z) pderi(z,x) + y g'(z) pderi(z,x) ==> x - f(z) = (x f'(z) + y g'(z)) pderi(z,x)
$
两边同时对 $y$ 求偏导得
$
x = x f'(z) pderi(z,y) + g(z) + y g'(z) pderi(z,y) ==> y - g(z) = (x f'(z) + y g'(z)) pderi(z,y)
$
因为 $x f'(x) + y g'(z) != 0$，所以
$
(x-g(z)) pderi(z,x) = (y-f(z)) pderi(z,y)
$
命题得证。

== P98 8
#prob[
	设函数 $z=f(x,y)$ 是由方程 $z-y-x+x e^(z-y-x) = 0$ 所确定的二元函数，求 $dif z$。
]
由题意得
$
&0 = dif (z - y - x + x e^(z-y-x)) = (dif z - dif x - dif y) + dif x e^(z-y-x) + x e^(z-y-x) (dif z - dif y - dif x)\
==>& (1+x e^(z-y-x)) dif z = (dif x + dif y) (1 + x e^(z-y-x)) - dif x e^(z-y-x)\
==>& dif z = ((1+x e^(z-y-x) - e^(z-y-x)) dif x + (1+x e^(z-y-x)) dif y)/(1+ x e^(z-y-x))
$

== P98 15
#prob[
	设函数 $u=f(x,y,z,t)$，其中 $z,t$ 是由方程组 $display(cases(y+z+t=0,y^2+z^2+t^2=1))$ 确定的函数，求 $pderi(u,x)$，$pderi(u,y)$。
]

对方程组微分得
$
cases(
	dif y + dif z + dif t = 0,
	2 y dif y + 2 z dif z + 2 t dif t = 0
)
$
解得
$
cases(
	display(dif z = (y-t)/(t-z) dif y),
	display(dif t = (y-z)/(z-t) dif y),
)
$
根据全微分公式
$
dif u = f'_x dif x + f'_y dif y + f'_z dif z + f'_t dif t
$
可知
$
cases(
	pderi(u,x) = f'_x,
	pderi(u,y) = display(f'_y + (y-t)/(t-z) f'_z + (y-z)/(z-t) f'_t),
)
$

== P99 16
#prob[
	设函数 $y=y(x)$，$z=z(x)$ 是由方程 $z=x f(x+y)$ 和 $F(x,y,z)=0$ 所确定的，其中 $f$ 可导，$F$ 具有连续的偏导数，求 $display((dif z)/(dif x))$。
]

对方程两端微分得
$
dif z = dif x f(x+y) + x f'(x + y) (dif x + dif y)
$
根据全微分公式有
$
dif F = F'_x dif x + F'_y dif y + F'_z dif z = 0
$
得 $display(F'_y = -(F'_x + F'_z)/(F'_y))$，代入可解得
$
(dif z)/(dif x) = (-x f'(x,y) F'x + (x f'(x,y) + f(x,y)) F'_y)/(F'_y + x f'(x,y) F'_z)
$

= 习题8-5
== P104 2
#prob[
	求函数 $z=x^2 - x y + y^2$ 在点 $M(1,1)$ 沿与 $O x$ 轴的正向组成 $alpha$ 角的方向 $bold(l)$ 上的方向导数，在怎样的方向上，此方向导数有：(1) 最大值；(2) 最小值；(3) 等于 $0$。
]

设点 $P_0 (1,1)$，则
$
pderi(z,x) = 2x-y ==>& atpos(pderi(z,x), P_0, "") = 1\
pderi(z,y) = -x+2y ==>& atpos(pderi(z,y), P_0, "") = 1
$
故方向导数为
$
atpos(pderi(z,bold(l)), P_0, "") = cos alpha + sin alpha
$
故方向导数：(1) $alpha=display(pi/4)+2k pi$ 时取到最大值 $sqrt(2)$。(2) $alpha=display(pi/4) + (2k+1) pi$ 时取到最小值 $-sqrt(2)$。(3) $alpha = display((3pi)/4) + k pi$ 时等于 $0$。这里 $k$ 是任意整数。

== P104 3
#prob[
	求函数 $u = x y z$ 在点 $M(1,1,1)$ 沿方向 $bold(l) = {cos alpha, cos beta, cos gamma}$ 上的方向导数，函数在该点的梯度的大小等于多少？
]
$
&pderi(u,bold(l)) = y z cos alpha + x z cos beta + x y cos gamma \
==>& atpos(pderi(u,bold(l)), P_0, "") = cos alpha + cos beta + cos gamma = {1,1,1} dot {cos alpha, cos beta, cos gamma}\
==>& abs(atpos(grad u, P_0, "")) = sqrt(1^2+1^2+1^2) = sqrt(3)
$

== P104 4
#prob[
	求函数 $u=x^2+y^2-z^2$ 在点 $A(1,0,0)$ 及 $B(0,1,0)$ 两点梯度之间的角度。
]

依题意得
$
pderi(u,x) = 2x;quad pderi(u,y) = 2y;quad pderi(u,z) = -2z
$
代入得
$
atpos(grad u, A, "") = {2,0,0};quad
atpos(grad u, B, "") = {0,2,0}
$
设角度为 $theta$，有
$
cos theta=(atpos(grad u, A, "") dot atpos(grad u, B, ""))/(abs(atpos(grad u, A, "")) dot abs(atpos(grad u, B, ""))) = 0
$
故两梯度间的夹角为 $theta= display(pi/2)$。

= 习题8-6
== P121 4(2)
#prob[
	求函数的极值：
	$
	z = x^4 + y^4 - x^2 - 2 x y - y^2
	$
]

依题意
$
cases(
	pderi(z,x) = 4 x^3-2x-2y,
	pderi(z,y) = 4y^3-2x-2y,
)
$
可得驻点为 $P_1 (0,0)$，$P_2 (1,1)$，$P_3 (-1,-1)$。再根据
$
cases(
	display((diff^2 z)/(diff x^2)) = 12 x^2 - 2,
	display((diff^2 z)/(diff x diff y)) = -2,
	display((diff^2 z)/(diff y^2)) = 12 y^2 - 2,
)
$
#table3(
	columns: (1fr, 1fr, 1fr, 1fr, 2fr, 2fr),
	[], $A$, $B$, $C$, $B^2 - A C$, [*结论*],
	$P_0$, -2, -2, -2, 0, [待定。],
	$P_1$, 10, -2, 10, 96, [是极小值点。],
	$P_2$, 10, -2, 10, 96, [是极小值点。],
)

对于 $P_0$，根据原函数在 ${1,1}$ 和 ${1,-1}$ 两个方向上的正负性不同，可验证 $P_0$ 不是极值点。

综上，函数在 $(1,1)$ 和 $(-1,-1)$ 处取到极小值 $-2$。

== P121 5(2)
#prob[
	求函数的条件极值：$u = x y z$，若 $x^2+y^2+z^2=1$，$x+y+z=0$。
]

令
$
F(x,y,z) = x y z + lambda (x^2+y^2+z^2-1) + mu(x+y+z)
$
联立
$
cases(
	pderi(F, x) = y z + 2 x lambda + mu = 0,
	pderi(F, y) = x z + 2 y lambda + mu = 0,
	pderi(F, z) = x y + 2 z lambda + mu = 0,
	pderi(F, lambda) = x^2 + y^2 + z^2 - 1 = 0,
	pderi(F, mu) = x + y + z = 0,
)
$
（省略一些步骤）最后可解得原函数：

#let t1=$display(1/sqrt(6))$
#let t2=$display(2/sqrt(6))$

(1) 在 $(-t2,t1,t1),(t1,-t2,t1),(t1,t1,-t2)$ 处取到最小值 $-display(1/(3sqrt(6)))$；

(2) 在 $(t2,-t1,-t1),(-t1,t2,-t1),(-t1,-t1,t2)$ 处取到最大值 $display(1/(3 sqrt(6)))$。

== P121 10
#prob[
	在椭圆 $x^2 + 4 y^2 = 4$ 上求一点，使其到直线 $2x + 3y - 6 = 0$ 的距离最短。
]

根据点到直线的距离公式有
$
d = (abs(2x+3y-6)/sqrt(2^2 + 3^2))^2 = abs(2x+3y-6)/sqrt(13)
$
取
$
f(x,y) = 13 d^2 = (2x+3y-6)^2
$
即求 $f(x,y,z)$ 的最值点。设
$
F(x,y) = (2x+3y-6)^2 - lambda (x^2+4 y^2 - 4)
$
联立
$
cases(
	pderi(F,x) = 2(2x+3y-6) - 2x lambda = 0,
	pderi(F,y) = 3(2x+3y-6) - 8y lambda = 0,
	pderi(F,lambda) = x^2 + 4 y^2 - 4= 0,
)
$
解得 $display((8/5,3/5)\, (-8/5, -3/5))$ 为两驻点，验证得在点 $display((8/5,3/5))$ 处取到最短距离 $display(1/sqrt(13))$。

== P121 11
#prob[
	求球面 $x^2+y^2+z^2 = 1$ 上到点 $(1,2,3)$ 的距离最短与最长的点。
]
根据两点间距离公式有
$
d=sqrt((x-1)^2 + (y-2)^2 + (z-3)^2)
$
设
$
f(x,y,z)=d^2=(x-1)^2 + (y-2)^2 + (z-3)^2
$
即求 $f(x,y,z)$ 的最值点。令
$
F(x,y,z) = (x-1)^2 + (y-2)^2 + (z-3)^2 + lambda (x^2+y^2+z^2-1)
$
联立
$
cases(
	pderi(F,x) = 2(x-1) + 2x lambda,
	pderi(F,y) = 2(y-2) + 2y lambda,
	pderi(F,z) = 2(z-3) + 2z lambda,
	pderi(F,lambda) = x^2+y^2+z^2 - 1 = 0
)
$
可解得驻点为 $display(P_1(1/sqrt(14),2/sqrt(14),3/sqrt(14))\,space P_2(-1/sqrt(14),-2/sqrt(14),-3/sqrt(14)))$。代入验证得 $P_1$ 为距离最短的点，$P_2$ 为距离最长的点。

= 第八章综合题
== P129 3
#prob[
	证明函数 $f(x,y) = root(3, x^3+y^3)$ 在点 $(0,0)$ 处沿任意方向的方向导数都存在，但在点 $(0,0)$ 处的全微分不存在。
]

设 $l^circle.small = {cos alpha, sin alpha}$，由定义式
$
pderi(f,bold(l)) = lim_(rho->0) (root(3,rho^3 cos^3 alpha+rho^3 sin^3 alpha))/(rho) = root(3,cos^3 alpha + sin^3 alpha)
$
故方向导数存在。

再验证可微性，考虑：
$
&lim_(x->0, y=k x) (f(x,y)-f(0,0))/(sqrt(x^2+y^2)) = lim_(x->0) root(3,1+ k^3)/sqrt(1+k^2)
$
取 $k=0$ 有极限为 $1$；取 $k=1$ 有极限为 $display(root(3,2)/sqrt(2))$。根据 $1!=display(root(3,2)/sqrt(2))$，原函数在点 $(0,0)$ 处不可微。

== P129 4
#prob[
	证明函数 $f(x,y) = display(cases((x^2+y^2) sin display(1/(x^2+y^2))\,quad & (x,y) != (0,0), 0\,quad& (x,y)=(0,0)))$ 在点 $(0,0)$ 的邻域中有偏导数 $f'_x (x,y)$ 和 $f'_y (x,y)$。这些偏导数在点 $(0,0)$ 处是不连续的，且在此点的任何邻域中是无界的，但此函数在点 $(0,0)$ 处可微。
]

由定义式
$
f'_x (0,0) = lim_(x->0) (f(x,0)-f(0,0))/(x-0) = lim_(x->0) (x^2 sin (1/x^2))/x = lim_(x->0) x sin(1/x) = 0
$
同理 $f'_y (0,0) = 0$。但
$
f'_x (x,y) = 2x sin(1/(x^2+y^2)) + 2x(x^2+y^2) cos(1/(x^2+y^2))quad ((x,y)!=(0,0))
$
考虑
$
lim_((x,y)->(0,0)) f'_x (x,y) 
&= lim_((x,y)->(0,0)) (2x sin(1/(x^2+y^2)) + (2x)/(x^2+y^2) cos(1/(x^2+y^2)))
$
取 $y=k x$，有
$
lim_(x->0,y=k x) f'_x (x,y) 
&= (2x sin(1/(x^2+k^2 x^2)) + (2x)/(x^2+k^2 x^2) cos(1/(x^2+k^2 x^2)))\
&= ((2)/(x(1+k^2)) cos(1/(x^2+k^2 x^2)))
$
震荡且无界，$f'_y$ 也同理。故偏导数在 $(0,0)$ 处不连续，且在邻域内无界。

另验证可微性：
$
lim_((x,y) -> (0,0)) (f(x,y)-f(0,0))/(sqrt(x^2+y^2)) = lim_((x,y)->(0,0)) ((x^2+y^2) sin (1/(x^2+y^2)))/sqrt(x^2+y^2) = lim_(t->0) sqrt(x^2+y^2) sin(1/(x^2+y^2)) = 0
$
故原函数在点 $(0,0)$ 处可微。	

== P129 9
#prob[
	设 $u=f(x,y,z,t)$，$g(y,z,t)=0$，$h(z,t)=0$，求 $display((diff u)/(diff x))$，$display((diff u)/(diff y))$。
]

联立
$
cases(
	dif u = f'_x dif x + f'_y dif y + f'_z dif z + f'_y dif t,
	g'_y dif y + g'_z dif z + g'_t dif t = 0,
	h'_z dif z + h'_t dif t = 0,
)
$
解得
$
cases(
	display(dif z = (g'_y h'_t)/(g'_t h'_z - g'_z h'_t)),
	display(dif t = (g'_y h'_z)/(g'_z h'_t - g'_t h'_z)),
)
$
代入得
$
cases(
	pderi(u,x) = f'_x,
	display(pderi(u,y) = f'_y + (g'_y h'_t)/(g'_t h'_z - g'_z h'_t) f'_z + (g'_y h'_z)/(g'_z h'_t - g'_t h'_z)f'_t),
)
$