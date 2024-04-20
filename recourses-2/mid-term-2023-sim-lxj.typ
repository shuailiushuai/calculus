#import "../template.typ": *

#show: project.with(
	course: "Calculus II",
	course_fullname: "Calculus (A) II",
	course_code: "821T0160",
	title: "Mid Term 2023: 卢兴江模拟题",
	authors: ((
		name: "memset0",
		email: "https://mem.ac/",
		id: [_memset0\@outlook.com_],
	),),
	semester: "Spring-Summer 2024",
	date: "April 10, 2024",
)

#v(-2em)
#let int = math.integral
#let divider = [#v(1fr)$ "" $]

*Problem 1.* (12 points) 分析下列级数是绝对收敛？条件收敛？还是发散？

(1) $display(sum_(n=1)^(oo) (-1)^(n-1) int_0^(1/n) sqrt(x)/(1+x^2) dif x)$
#v(0.5em)
(2) $display(sum_(n=1)^(oo) (-1)^n (3^n)/(n(3^n+2^n)))$

#divider
*Problem 2.* (12 points)

(1) 求过 $x$ 轴且与 $x+y+z=1$ 垂直的平面方程。

(2) 求过点 $(1,-1,2)$ 且与 $display(x/1 = (y-1)/1 = (z-3)/(-3))$ 垂直相交的直线方程。

#divider
#pagebreak(weak: true)
*Problem 3.* (12 points)

(1) 已知 $z=z(x,y)$ 满足 $display((diff z)/(diff y) = x^2 + 2y)$，$z(x,x^2)=1$，求 $z(x,y)$ 的表达式。

(2) 设 $z=f(2x-y, x^2 y) + g(x^2 + y^2)$，其中 $f$ 具有二阶连续偏导数，$g$ 具有二阶连续导数，求 $display((diff^2 z)/(diff x diff y))$。

#divider
*Problem 4.* (12 points)

(1) 已知函数 $f(x) = x+1$。若 $f(x) = display((a_0)/2 + sum_(n=1)^(oo) a_n cos n x),space x in [0,pi]$，求 $display(sum_(n=1)^(oo) a_(2n-1))$ 的和。

(2) 将函数 $display(f(x) = x/(x^2-5x+6))$ 展开成 $x-1$ 的幂级数并指出收敛域。

#divider
#pagebreak(weak: true)
*Problem 5.* (12 points)

(1) 求直线 $display(cases(x-y+2x-1=0,2x+y+z-2=0))$ 绕 $x$ 轴旋转一周所得的旋转曲面方程。
#v(0.5em)
(2) 求曲线 $display(cases(z=x^2 + 2y^2, 2x-4y+z=1))$ 在平面 $2x+y+5z=0$ 上的投影曲线方程。

#divider
*Problem 6.* (10 points) 设 $u=display(x/y)$，$v=x$，$w = x z - y$，试将方程 $display(y (diff^2 z)/(diff y^2) + 2 (diff z)/(diff y) = 2 /x)$ 变换成函数 $w=w(u,v)$ 关于变量 $u,v$ 的方程。

#divider
#pagebreak(weak: true)
*Problem 7.* (10 points) 设球面 $S$ 与平面 $x-2y+2z=3$ 与 $2x+2y-2z=8$ 皆相切，且球心在直线 $display(cases(2x-y=0,3x-z=0))$ 上，求此球面的方程。

#divider
*Problem 8.* (10 points) 求级数 $display(sum_(n=1)^(oo) ((x^2+x+1)^n)/(n(n+1)))$ 的收敛域与和函数。

#divider
*Problem 9.* (10 points) 设正数列 ${a_n}$ 单调增加且有界，证明级数 $display(sum_(n=1)^(oo) (1-a_n/a_(n+1)))$ 收敛。
#divider
