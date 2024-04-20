#import "../template.typ": *

#show: project.with(
	course: "Calculus II",
	course_fullname: "Calculus (A) II",
	course_code: "821T0160",
	title: "Homework #8: 多元函数微分学",
	authors: ((
		name: "Yulun WU",
		email: "memset0@outlook.com",
		id: "#198"
	),),
	semester: "Spring-Summer 2024",
	date: "April 18, 2024",
)

= 习题8-2
== P82 16
#prob[
	证明：函数 $f(x,y)=sqrt(|x y|)$ 在点 $(0,0)$ 处的两个偏导数都存在，但在点 $(0,0)$ 处不可微。
]

$	
f'_x (0,0) = lim_(x->0) (f(x,0)-f(0,0))/x = lim_(x->0) (sqrt(abs(x dot 0)) - 0)/x = 0
$
由于 $f(x,y)$ 关于 $x,y$ 对称，故同理可得 $f'_y (0,0) = 0$。

考察：
$
&lim_((Delta x,Delta y)->(0,0)) = (Delta f - A Delta x - B Delta y)/(sqrt(Delta x^2 + Delta y^2))\
=& lim_((x,y)->(0,0)) sqrt(abs(x y))/sqrt(x^2+y^2)\
=& lim_((x,y)->(0,0)) root(4, (x^2 y^2)/(x^4+2x^2 y^2+y^4))\
=& root(4, lim_((x,y)->(0,0)) (x^2 y^2)/(x^4+2x^2 y^2+y^4))
$
令 $y=k x$，得
$
lim_((x,y)->(0,0)) (x^2 y^2)/(x^4+2x^2 y^2+y^4)
&= lim_(x->0) (x^4 k^2)/(x^4+2x^4 k^2+x^4 k^4)\
= k^2/(1+2k^2+k^4)
$
故原极限不存在，故原函数在点 $(0,0)$ 处不可微。

= 习题8-3
== P89 7
#prob[
	设函数 $z=f(2x-y)+g(x,x y)$，其中 $f$ 二阶可导，$g$ 具有连续的二阶偏导数，求 $display((partial^2 z)/(px py))$。
]
$
pz/px &= partial/px f(2x-y) + partial/px g(x,x y)\
&= pf/(partial (2x-y)) (partial (2x-y))/px + (partial g)/(partial x) px/px + (partial g)/(partial (x y)) (partial (x y))/px\
&= 2 f' + g'_1 + y g'_2\
$
$
(partial^2 z)/(px py)
&= diff/(py) (2f' + g'_1 + y g'_2)\
&= 2 (diff f')/(diff (2x-y)) (diff(2x-y))/py + (diff g'_1)/(diff x) px/py + (diff g'_1)/(diff (x y)) (diff (x y))/py + y (diff g'_2)/(diff x) px/py + y (diff g'_2)/(diff (x y)) (diff (x y))/py\
&= -2 f'' + x g''_12 + x y g''_22
$

== P89 9
#prob[
	设函数 $u=f(x y z)$，其中 $f$ 可导，求 $dif u$。
]
$
dif u
= pf/px dx + pf/py dy + pf/pz dif z
= f' (y z dif x + x z dif y + x y dif z)
$

== P89 14
#prob[
	取 $x$ 作为函数，而 $u=y-z$，$v=y+z$ 作为自变量，变换方程
	$
	(y-z) pz/px + (y+z) pz/py = 0
	$
]

$
cases(
	display(pz/pu = pz/px px/pu + pz/py py/pu = pz/px px/pu = -1/2),
	display(pz/pv = pz/px px/pv + pz/py py/pv = pz/px px/pv = 1/2),
)==> pz/px = 1/display(px/pv - px/pu)
$
从而化简原方程：
$
(y-z) pz/px + (y+z) pz/py = 0 <=> u/display(px/pv - px/pu) = 0
$

#bug[
	纠错：

	$
	dif u = dif y - dif z,space dif v = dif y + dif z
	$
	$
	& dif x = px/pu dif u + px/pv dif v = px/pu (dy-dif z) + px/pv (dy+dif z)\
	==>& (px/pu - px/pv) dif z = - dif x + (px/pu + px/pv) dif y\
	==>& dif z = 1/display(px/pv - px/pu) + display(px/pu + px/pv)/display(px/pu-px/pv) dif y\
	==>& pz/px = 1/display(px/pv - px/pu),space pz/py = display(px/pu + px/pv)/display(px/pu-px/pv)
	$
	代入得
	$
	&u dot 1/display(px/pv - px/pu) + v dot display(px/pu + px/pv)/display(px/pu-px/pv) = 0\
	==>& px/pu + px/pv = u/v space (v!=0)
	$
]

== P90 15
#prob[
	引用新的自变量 $xi=x-a t$，$eta = x + a t$ 化简方程。
	$
	(partial^2 u)/(partial t^2) = a^2 (partial^2 u)/(partial x^2)
	$
]

$
pu/px &= pu/(diff xi) (diff xi)/px + pu/(diff eta) (diff eta)/px = pu/(diff xi) + pu/(diff eta)\
(diff^2 u)/(diff x^2) &= (diff^2 u)/(diff xi^2) (diff xi)/px + (diff^2 u)/(diff xi diff eta) (diff eta)/px + (diff^2 u)/(diff xi diff eta) (diff xi)/px + (diff^2 u)/(diff eta^2) (diff eta)/px = (diff^2 u)/(diff xi diff xi) + 2 (diff^2 u)/(diff xi diff eta) + (diff^2 u)/(diff eta diff eta)\
pu/(diff t) &= pu/(diff xi) (diff xi)/(diff t) + pu/(diff eta) (diff eta)/(diff t) = -a pu/(diff xi) + a pu/(diff eta)\
(diff^2 u)/(diff t^2) &= -a (diff^2 u)/(diff xi^2) (diff xi)/px -a (diff^2 u)/(diff xi diff eta) (diff eta)/px + a (diff^2 u)/(diff xi diff eta) (diff xi)/px + a (diff^2 u)/(diff eta^2) (diff eta)/px = a^2 (diff^2 u)/(diff xi diff xi) - 2 a^2 (diff^2 u)/(diff xi diff eta) + a^2 (diff^2 u)/(diff eta diff eta)\
$