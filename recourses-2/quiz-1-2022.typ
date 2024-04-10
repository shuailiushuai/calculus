#import "../template.typ": *

#show: project.with(
	course: "Calculus II",
	course_fullname: "Calculus (A) II",
	course_code: "821T0160",
	title: "Quiz #1 (Spring-Summer 2023 ver.)",
	authors: ((
		name: "memset0",
		email: "https://mem.ac/",
		id: [_memset0\@outlook.com_],
	),),
	semester: "Spring-Summer 2024",
	date: "April 9, 2024",
)

#let int = math.integral
#let divider = [#v(12em)$ "" $]

*Problem 1.* 设 $f(x) = display(cases(sin pi x\, quad& 0 <= x <= display(1/2), 0\,quad & display(1/2<=x<=1)))$。记 $display(b_n=2 int_0^1 f(x) sin (n pi x) dif x)$，$S(x) = display(sum_(n=1)^(+oo) b_n sin (n pi x))$。求 $S(0),space S(display(3/2))$。

#divider
*Problem 2.* 求过点 $(1,2,5)$ 与直线 $display(cases(x+y-z=1,2x+z=3))$ 的平面的方程。

#divider
*Problem 3.* 已知平行四边形 $A B C D$ 中，$arrow(A C) = {2,1,3}$，$arrow(B D) = {2,-3,1}$，求平行四边形 $A B C D$ 的面积。

#divider
*Problem 4.* 设 $display(sum_(n=1)^(+oo) a_n (x-1)^n)$ 的收敛半径为 $1$。判断 $display(sum_(n=1)^(+oo) (-1)^n (3^n a_n)/(n+1))$ 的敛散性。（条件收敛 / 绝对收敛 / 发散）

#divider
*Problem 5.* 设 $x in (-1,1)$，有 $display(1/(x^2-x+1) = sum_(n=0)^(+oo) a_n x^n)$，求 $a_0,a_1,a_2,dots.c,a_7$ 的每一项。

#divider
*Problem 6.* 求直线 $display((x-3)/1 = (y-1)/2 = z/(-1))$ 绕 $z$ 轴旋转一周得到的曲面方程，并判断曲面类型。

#divider
*Problem 7.* 求 $display(sum_(n=1)^(+oo) n x^(n-1))$ 的和函数与收敛域。

#divider
*Problem 8.* 设 $alpha in RR$，且已知 $display(sum_(n=1)^(+oo) (-1)^n sqrt(n) sin (1/(n^alpha)))$ 条件收敛，$display(sum_(n=1)^(+oo) ((-1)^(n-1))/(n^(2-alpha)))$ 绝对收敛，求 $alpha$ 的范围。

#divider
*Problem 9.* 求过点 $(1,-1,1)$ 与直线 $display(cases(x-y+z=1,3x-4y+2z=0))$ 垂直的平面方程。

#divider
*Problem 10.* 判断以下对错：

(1) 若 $a_n > 0$，$display(sum_(n=1)^(+oo) sqrt(a_n a_(n+1)))$ 收敛，则 $display(sum_(n=1)^(+oo) a_n)$ 收敛。

(2) 若 $a_n > 0$，$display(sum_(n=1)^(+oo) a_n)$ 收敛，则 $display(sum_(n=1)^(+oo) a_n^2)$ 收敛。

(3) 若 $a_n > 0$，$display(sum_(n=1)^(+oo) a_n)$ 发散，则 $display(sum_(n=1)^(+oo) (a_n)/(1+n^2 a_n))$ 发散。

(4) 若 $display(sum_(n=1)^(+oo) a_n)$ 条件收敛，则 $display(sum_(n=1)^(+oo) (|a_n| + a_n))$ 发散。