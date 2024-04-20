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
f'_x (0,0)
= lim_(x->0) (f(x,0) - f(0,0))/x
= lim_(x->0) (sqrt(|x| dot 0) - 0)/x = 0
$
由于 $f(x,y)$ 关于 $x,y$ 对称，故同理可得 $f'_y (0,0) = 0$。即在点 $(0,0)$ 处两个偏导数都存在。考察：
$
lim_(x->0\ y=x) f(x,y) = lim_(x->0\ y=x) sqrt(abs(x y)) = lim
$

= 习题8-3
== P89 7
#prob[
	设函数 $z=f(2x-y)+g(x,x y)$，其中 $f$ 二阶可导，$g$ 具有连续的二阶偏导数，求 $display((partial^2 z)/(px py))$。
]

== P89 9
#prob[
	设函数 $u=f(x y z)$，其中 $f$ 可导，求 $dif u$。
]

== P89 14
#prob[
	取 $x$ 作为函数，而 $u=y-z$，$v=y+z$ 作为自变量，变换方程
	$
	(y-z) pz/px + (y+z) pz/py = 0
	$
]

== P90 15
#prob[
	引用新的自变量 $xi=x-a t$，$eta = x + a t$ 化简方程。
	$
	(partial^2 u)/(partial t^2) = a^2 (partial^2 u)/(partial x^2)
	$
]