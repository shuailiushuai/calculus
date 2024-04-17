#import "../template.typ": *

#show: project.with(
	course: "Calculus II",
	course_fullname: "Calculus (A) II",
	course_code: "821T0160",
	title: "Homework #7",
	authors: ((
		name: "Yulun WU",
		email: "memset0@outlook.com",
		id: "#198"
	),),
	semester: "Spring-Summer 2024",
	date: "April 17, 2024",
)

#let defeq = math.attach("=", t: math.Delta)
#let atpos(f, b, t) = $lr(display(#f) |)_(#b\ "")^(\ #t)$

= 习题7-7
== P54 9
#prob[
	试求 $O y z$ 平面上的抛物线 $z=sqrt(y-1)$ 绕 $O y$ 轴旋转一周所成的旋转曲面方程。
]

用 $pm sqrt(x^2+z^2)$ 代换 $z$ 得：
$
&pm sqrt(x^2+z^2) = sqrt(y-1)\
==> & x^2 + z^2 = y-1 quad (y>=1)
$

== P54 12(1)
#prob[
	求曲线在 $O x y$ 平面上的投影曲线方程：

	(1) $display(cases(
		x^2 + (y-2)^2 + (z-1)^2 = 25,
		x^2 + y^2 + z^2 = 16
	))$
]

两式相减得
$
-4y+4-2z+1=9 ==> z=-2y-4
$
代入 ① 式得
$
x^2 + (y-2)^2 + (-2y-5)^2 = 25
==> x^2 + 5y^2 + 16y + 4 = 0
$
故投影曲线的方程为
$
cases(
	x^2 + 5y^2 + 16y + 4 = 0,
	z=0
)
$

= 习题7-8
== P59 1(1)(3)(5)
#prob[
	指出下列方程所表示曲面的名称。若是旋转曲面，指出它是由什么曲线绕什么轴旋转而生成的。

	(1) $9 x^2 + 4 y^2 + 4 z^2 = 36$

	(3) $x^2-y^2-z^2 = 1$

	(5) $x^2-y^2 = 4z$
]

(1) 旋转椭球面。由 $9x^2+4y^2$ 绕 $O x$ 轴旋转而成。

#h(-indent) (3) 旋转双叶双曲面。由 $x^2-y^2$ 绕 $O x$ 轴旋转而成。

#h(-indent) (5) 双曲抛物面。

== P59 2(1)(2)
#prob[
	指出下列方程表示怎样的曲面，并作出其草图：

	(1) $display(x^2 + y^2/4 + z^2/9 = 1)$

	(2) $display(36x^2 + 9 y^2 - 4z = 36)$
]

(1) 椭球面 $quad$ (2) 双曲抛物面

#align(center, image("images/2024-04-18-00-54-11.png", width: 100%))

== P60 4(1)(4)(7)(10)
#prob[
	画出下列各组曲面所围成的例题图形：

	略。
]

#align(center, image("images/2024-04-18-01-03-20.png", width: 100%))

= 习题8-1
== P68 5(2)
#prob[
	求极限：
	$
	lim_(x->+oo\ y->+oo) (x^2+y^2) e^(-(x+y))
	$
]

注意到
$
0< (x^2+y^2)/(e^(x+y)) < (x+y)^2/(e^(x+y))
$
由于
$
lim_(x->+oo\ y->+oo) (x+y)^2/e^(x+y) = lim_(u->+oo) u^2/e^u = 0
$
故所求极限
$
lim_(x->+oo\ y->+oo) (x^2+y^2) e^(-(x+y)) = 0
$

== P68 7(2)
#prob[
	研究函数的连续性：
	$
	f(x,y) = cases(
		display((x y^2) / (x^2 + y^4)\,quad& (x,y) != (0,0)),
		0\, &(x,y) = (0,0)
	)
	$
]

考察
$
lim_(x->0\ y=0) (x y^2)/(x^2+y^4) = 0
quad quad
lim_(y->0\ x=y^2) (y^4)/(y^4+y^4) = lim_(y->0) (y^4)/(2 y^4) = 1/2
$
由于 $display(0!=1/2)$，可知 $f(x,y)$ 在点 $(0,0)$ 处不连续。而在其余点处，由初等函数的性质显然连续。

= 习题8-2
== P81 1
#prob[
	设函数 $f(x,y) = display(cases((x^2+y^2) sin display(1/(x^2 + y^2))\, quad& (x,y)!=(0,0), 0\, quad& (x,y) = (0,0)))$。求 $f'_x (0,0)$，$f'_y (0,0)$，$f'_x (x,y)$，$f'_y (x,y)$。
]

根据定义：
$
f'_x (0,0) = lim_(x->0) (f(x,0)-f(0,0))/(x) = lim_(x->0) (x^2 sin display(1/x^2))/x = 0
$
由于 $f(x,y)$ 关于 $x,y$ 是对称的，同理可得 $f'_y (0,0)=0$。

当 $(x,y)!=(0,0)$ 时，有
$
(diff f)/(diff x) = 2x sin 1/(x^2+y^2) - (2x)/(x^2+y^2) cos 1/(x^2+y^2)
$
在 $(x,y)$ 时偏导函数也成立。故有
$
f'_x (x,y) = 2x sin 1/(x^2+y^2) - (2x)/(x^2+y^2) cos 1/(x^2+y^2)
$
同理有
$
f'_y (x,y) = 2y sin 1/(x^2+y^2) - (2y)/(x^2+y^2) cos 1/(x^2+y^2)
$

== P81 4
#prob[
	设函数 $z=f(e^(x y) - y^2)$，其中 $f$ 为可导函数，求 $display((diff z)/(diff x)\, (diff z)/(diff y))$。
]

$
(diff z)/(diff x) = e^(x y) y f'
quad quad
(diff z)/(diff y) = (e^(x y) - 2 y) f'
$

== P82 6(3)
#prob[
	求函数的所有二阶偏导数：
	$
	u=x^y
	$
]
$
(diff^2 u)/(diff x^2) = y (y-1) x^(y-2)
quad quad
(diff^2 u)/(diff y^2) = x^y (ln x)^2\
(diff^2 u)/(diff x diff y) = (diff^2 u)/(diff y diff x) = x^(y-1) + y x^(y-1) ln x
$

== P82 11(2)
#prob[
	求函数的全微分：
	$
	u=sin(x^2 + y^2)
	$
]
$
(diff u)/(diff x) = 2 x cos (x^2+y^2)
quad quad
(diff u)/(diff y) = 2 y cos (x^2+y^2)
$
故有
$
dif u = 2x cos(x^2+y^2) dif x + 2y cos (x^2+y^2) dif y
$

== P82 12
#prob[
	设函数 $f(x,y,z) = display(root(z, x/y))$，求 $dif f(1,1,1)$。
]

$
&atpos((diff f)/(diff x), (1,1,1), "") = atpos((dif)/(dif x) (x), x=1, "") = 1\
&atpos((diff f)/(diff y), (1,1,1), "") = atpos((dif)/(dif y) (1/y), y=1, "") = atpos(-1/y^2, y=1, "") = -1 \
&atpos((diff f)/(diff z), (1,1,1), "") = atpos((dif)/(dif z) root(z,1), z=1, "") = 0
$
故有
$
dif f (1,1,1) = dif x  -dif y
$

== P82 14(2)
#prob[
	求下列各式的近似值：

	(1) $sqrt(1.02^3 + 1.97^3)$

	(2) $0.97^1.05$。
]

(1) 设函数 $f(x,y) = sqrt(x^3 + y^3)$。则
$
f(1,2) = 3
quad
f'_x (1,2) = 1
quad
f'_y (1,2) = 4
$
故
$
sqrt(1.02^3+1.97^3) = f(1.02,1.97) = f(1,2) + 0.02 f'_x (1,2) - 0.03 f'_y (1,2) = 2.90
$

(2) 设函数 $f(x,y) = x^y$。则
$
f(1,1) = 1
quad
f'_x (1,1) = 1
quad
f'_y (1,1) = 0
$
故
$
0.97^1.05 = f(0.97,1.05) = f(1,1)- 0.03 f'_x (1,1) + 0.05 f'_y (1,1) = 0.97
$