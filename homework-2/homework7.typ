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

= 习题7-7
== P54 9
#prob[
	试求 $O y z$ 平面上的抛物线 $z=sqrt(y-1)$ 绕 $O y$ 轴旋转一周所成的旋转曲面方程。
]

== P54 12(1)
#prob[
	求曲线在 $O x y$ 平面上的投影曲线方程：

	(1) $display(cases(
		x^2 + (y-2)^2 + (z-1)^2 = 25,
		x^2 + y^2 + z^2 = 16
	))$
]

= 习题7-8
== P59 1(1)(3)(5)
#prob[
	指出下列方程所表示曲面的名称。若是旋转曲面，指出它是由什么曲线绕什么轴旋转而生成的。

	(1) $9 x^2 + 4 y^2 + 4 z^2 = 36$

	(3) $x^2-y^2-z^2 = 1$

	(5) $x^2-y^2 = 4z$
]

== P59 2(1)(2)
#prob[
	指出下列方程表示怎样的曲面，并作出其草图：

	(1) $display(x^2 + y^2/4 + z^2/9 = 1)$

	(2) $display(36x^2 + 9 y^2 - 4z = 36)$
]

== P60 4(1)(4)(7)(10)
#prob[
	画出下列各组曲面所围成的例题图形：

	略。
]

= 习题8-1
== P68 5(2)
#prob[
	求极限：
	$
	lim_(x->+oo\ y->+oo) (x^2+y^2) e^(-(x+y))
	$
]

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

= 习题8-2
== P81 1
#prob[
	设函数 $f(x,y) = display(cases((x^2+y^2) sin display(1/(x^2 + y^2))\, quad& (x,y)!=(0,0), 0\, quad& (x,y) = (0,0)))$。求 $f'_x(0,0)$，$f'_y(0,0)$，$f'_x(x,y)$，$f'_y(x,y)$。
]

== P81 4
#prob[
	设函数 $z=f(e^(x y) - y^2)$，其中 $f$ 为可导函数，求 $display((diff z)/(diff x)\, (diff z)/(diff y))$。
]

$
(diff z)/(diff x) = d
$

== P82 6(3)
#prob[
	求函数的所有二阶偏导数：
	$
	u=x^y
	$
]

== P82 11(2)
#prob[
	求函数的全微分：
	$
	u=sin(x^2 + y^2)
	$
]

== P82 12
#prob[
	设函数 $f(x,y,z) = display(root(z, x/y))$，求 $dif f(1,1,1)$。
]

== P82 14
#prob[
	求下列各式的近似值：

	(1) $sqrt(1.02^3 + 1.97^3)$

	(2) $0.97^1.05$。
]
