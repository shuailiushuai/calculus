#import "../template.typ": *

#show: project.with(
	course: "Calculus II",
	course_fullname: "Calculus (A) II",
	course_code: "821T0160",
	title: "Quiz #1 (Spring-Summer 2024, Wednesday)",
	authors: ((
		name: "memset0",
		email: "https://mem.ac/",
		id: [_memset0\@outlook.com_],
	),),
	semester: "Spring-Summer 2024",
	date: "April 10, 2024",
)

#let int = math.integral
#let divider = [#v(15em)$ "" $]

*Problem 1.* 已知直线 $L:space display(cases(x+2y+z=3, 2x-3y+9z=1))$ 与平面 $pi:space x+y+2z=2$ 之间的关系为
#table(stroke: 0pt, columns: (1fr, 1fr, 1fr), inset: 0.6em, [(A) 垂直], [(B) 斜交], [(C) $L$ 在 $pi$ 上], [(D) 平行但 $L$ 不在 $pi$ 上], [(E) 其他选项均不合题意])


#divider
*Problem 2.* 设空间四个点 $P_1 (1,0,1),space P_2 (0,-1,2), space P_3 (1,a,-2),space P_4 (-1,b,0)$。则下列陈述正确的是：
#table(stroke: 0pt, columns: (1fr), inset: 0.6em, [(A) 无论 $a,b$ 取何值，$P_1,P_2,P_3,P_4$ 四点均不共线], [(B) 若 $Delta P_1 P_2 P_3$ 面积为 $display(3/2 sqrt(6))$，则 $a=display(3/2)$], [(C) 若 $P_1,P_2,P_3,P_4$ 四点共面，则向量 $arrow(P_1 P_2) parallel arrow(P_3 P_4)$], [(D) 若以 $P_1,P_2,P_3,P_4$ 为顶点的四面体体积为 $1$，则 $a=b+2$], [(E) 其他选项均不合题意])

#divider
*Problem 3.* 设幂级数 $display(sum_(i=1)^(+oo) a_n (x-2)^n)$ 的收敛半径 $r=1$，则级数 $display(sum_(n=1)^(+oo) (-1)^n 2^n a_n)$
#table(stroke: 0pt, columns: (1fr, 1fr, 1fr), [(A) 绝对收敛], [(B) 条件收敛], [(C) 发散], [(D) 敛散性无法确定], [(E) 其他选项均不合题意])


#divider
*Problem 4.* 设 ${u_n}$ 是实数列，则下列陈述正确的是
#table(stroke: 0pt, columns: (1fr), inset: 0.6em,
	[(A) 若 $display(sum_(n=1)^(+oo)) (u_(2n-1) - u_(2n))$ 收敛，则 $display(sum_(n=1)^(+oo)) u_n$ 收敛],
	[(B) 若 $display(sum_(n=1)^(+oo)) u_n$ 收敛，则 $display(sum_(n=1)^(+oo)) (u_(2n-1) - u_(2n))$ 收敛],
	[(C) 若 $display(sum_(n=1)^(+oo)) u_n$ 收敛，则 $display(sum_(n=1)^(+oo)) (u_(2n-1) + u_(2n))$ 收敛],
	[(D) 若 $display(sum_(n=1)^(+oo)) (u_(2n-1) + u_(2n))$ 收敛，则 $display(sum_(n=1)^(+oo)) u_n$ 收敛],
	[(E) 其他选项均不合题意]
)

#divider
*Problem 5.* 设 $f(x) = display(cases(x\,quad &0<=x<=display(1/2), 2-2x\,quad & display(1/2) <= x <= 1))$，$S(x) = display((a_0)/2 + sum_(n=1)^(+oo) a_n cos n pi x space (x in RR))$，其中 $a_n = 2 display(int_0^1 f(x) cos n pi x dif x space (n=1,2,dots.c))$，则 $S(display(-5/2))$ 和 $S(-3)$ 的值分别为？

#divider
*Problem 6.* 级数 $display(sum_(n=1)^(+oo) (sin n alpha + (-1)^n n)/(n^2)) space (alpha in RR)$ 的敛散性为：
#table(stroke: 0pt, columns: (1fr, 1fr, 1fr), inset: 0.6em, [(A) 绝对收敛], [(B) 条件收敛], [(C) 发散], [(D) 敛散性与 $alpha$ 选择有关], [(E) 其他选项均不合题意])

#divider
*Problem 7.* 设 $alpha$ 是常实数，已知 $display(sum_(n=1)^(+oo) (-1)^n sqrt(n) sin (1/(n^alpha)))$ 绝对收敛，$display(sum_(n=1)^(+oo) ((-1)^(n-1))/(n^(2-a)))$ 条件收敛，则常数 $a$ 的取值范围是？

#divider
*Problem 8.* 已知幂级数 $display(sum_(n=0)^(+oo) a_n x^n)$ 的和函数为 $ln(2+x)$，求 $display(sum_(n=1)^(+oo) n a_(2n))$。

#divider
*Problem 9.* 在平行四边形 $A B C D$ 中，向量 $arrow(A C) = {1, 2, 4};space arrow(B D) = {-3, 0, 2}$，求 $A B C D$ 的面积 $S$。

#divider
*Problem 10.* 下列陈述错误的是：
#table(stroke: 0pt, columns: (1fr), inset: 0.6em,
	[(A) 若正项级数 $display(sum_(n=1)^(+oo)) a_n$ 收敛，则级数 $display(sum_(n=1)^(+oo)) display((1-2/n)^n a_n)$ 也收敛],
	[(B) 正数列 ${a_n}$ 单调递减，且 $display(sum_(n=1)^(+oo)) (-1)^(n-1) a_n$ 发散，则 $display(sum_(n=1)^(+oo) (1/(1+a_n))^n)$ 发散],
	[(C) 若级数 $display(sum_(n=1)^(+oo)) a_n$ 收敛，则级数 $display(sum_(n=1)^(+oo)) a_n^3$ 也收敛],
	[(D) 若正项级数 $display(sum_(n=1)^(+oo)) a_n$ 收敛，则 $a_n = o(display(1/n)) space (n->+oo)$],
	[(E) 其他选项均不合题意],
)