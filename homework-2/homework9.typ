#import "../template.typ": *

#show: project.with(
	course: "Calculus II",
	course_fullname: "Calculus (A) II",
	course_code: "821T0160",
	title: "Homework #9",
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
	(x-g(z)) (diff z)/(diff x) = (y-f(z)) (diff z)/(diff y)
	$
]

== P98 8
#prob[
	设函数 $z=f(x,y)$ 是由方程 $z-y-x+x e^(x-y-z) = 0$ 所确定的二元函数，求 $dif z$。
]

== P98 15
#prob[
	设函数 $u=f(x,y,z,t)$，其中 $z,t$ 是由方程组 $display(cases(y+z+t=0,y^2+z^2+t^2=1))$ 确定的函数，求 $display((diff u)/(diff x))$，$display((diff u)/(diff y))$。
]

== P99 16
#prob[
	设函数 $y=y(x)$，$z=z(x)$ 是由方程 $z=x f(x+y)$ 和 $F(x,y,z)=0$ 所确定的，其中 $f$ 可导，$F$ 具有连续的偏导数，求 $display((dif z)/(dif x))$。
]

= 习题8-5
== P104 2
#prob[
	求函数 $z=x^2 - x y + y^2$ 在点 $M(1,1)$ 沿与 $O x$ 轴的正向组成 $alpha$ 角的方向 $bold(l)$ 上的方向导数，在怎样的方向上，此方向导数有：(1) 最大值；(2) 最小值；(3) 等于 $0$。
]

== P104 3
#prob[
	求函数 $u = x y z$ 在点 $M(1,1,1)$ 沿方向 $bold(l) = {cos alpha, cos beta, cos gamma}$ 上的方向导数，函数在该点的梯度的大小等于多少？
]

== P104 4
#prob[
	求函数 $u=x^2+y^2-z^2$ 在点 $A(1,0,0)$ 及 $B(0,1,0)$ 两点梯度之间的角度。
]

= 习题8-6
== P121 4(2)
#prob[
	求函数的极值：
	$
	z = x^4 + y^4 - x^2 - 2 x y - y^2
	$
]

== P121 5(2)
#prob[
	求函数的条件极值：$u = x y z$，若 $x^2+y^2+z^2=1$，$x+y+z=0$。
]

== P121 10
#prob[
	在椭圆 $x^2 + 4 y^2 = 4$ 上求一点，使其到直线 $2x + 3y - 6 = 0$ 的距离最短。
]

== P121 11
#prob[
	求球面 $x^2+y^2+z^2 = 1$ 上到点 $(1,2,3)$ 的距离最短与最长的点。
]

= 第八章综合题
== P129 3
#prob[
	证明函数 $f(x,y) = root(3, x^3+y^3)$ 在点 $(0,0)$ 处沿任意方向的方向倒数都存在，但在点 $(0,0)$ 处的全微分不存在。
]

== P129 4
#prob[
	证明函数 $f(x,y) = display(cases((x^2+y^2) sin display(1/(x^2+y^2))\,quad & (x,y) != (0,0), 0\,quad& (x,y)=(0,0)))$ 在点 $(0,0)$ 的邻域中有偏导数 $f'_x (x,y)$ 和 $f'_y (x,y)$。这些偏导数在点 $(0,0)$ 处是不连续的，且在此点的任何邻域中是无界的，但此函数在点 $(0,0)$ 处可微。
]

== P129 9
#prob[
	设 $u=f(x,y,z,t)$，$g(y,z,t)=0$，$h(z,t)=0$，求 $display((diff u)/(diff x))$，$display((diff u)/(diff y))$。
]