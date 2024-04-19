#import "../template.typ": *
#import "@preview/xarrow:0.3.0": xarrow

#show: project.with(
	course: "Calculus II",
	course_fullname: "Calculus (A) II",
	course_code: "821T0160",
	semester: "Spring-Summer 2024",
	title: "Note #1 级数",
	authors: ((
		name: "Yulun WU",
		email: "memset0@outlook.com",
		id: "3230104585"
	),),
	date: "January 24, 2024",
)

#let ss = [$display(attach(inline(sum), t: +oo, b: n=1))$]
#let sf(x) = [$display(attach(inline(sum), t: +oo, b: n=#x))$]
#let sss = [$display(attach(sum, t: +oo, b: n=1))$]
#let ssf(x) = [$display(attach(sum, t: +oo, b: n=#x))$]
#let int = math.integral
#let dx = [$dif x$]
#let dy = [$dif y$]

= 数项级数

#definition[
	给定数列 ${a_n}$，将其每一项依次用“$+$”号连接起来的表达式 $a_1 + a_2 + dots.c + a_n + dots.c = ss a_n$ 称为#bb[无穷级数]。
]

#definition[
	在级数 $ss a_n$ 中，前 $n$ 项的和 $display(S_n = a_1 + a_2 + dots.c + a_n)$ 	称为它的第 $n$ 个#bb[部分和]。所得到的数列 ${S_n}$ 称为#bb[部分和数列]。
]

== 级数收敛的定义与判别

#definition[
	对于级数 $ss a_n$，若它的部分和数列 ${S_n}$ 收敛，则称该无穷级数#bb[收敛]。且称 $S=display(lim_(n->oo) S_n = S)$ 为该级数的#bb[和]；若数列 ${S_n}$ 发散，则称该无穷级数#bb[发散]。
]

#theorem(name: "柯西收敛准则")[
	级数 $ss a_n$ 收敛的充要条件是：$forall eps > 0,sp exists N>0$，当 $n>N$ 时，$forall p in NN_+$，均有
	$ |S_(n+p) - S_n| = |a_(n+1) + a_(n+2) + dots.c + a_(n+p)| < eps $
]

#example[
	#problem[
		证明级数 $sss display(1/(n^2))$ 收敛。
	]

	#solution(tag: "证明")[
		当 $k>=2$ 且 $k in NN_+$ 时，有 $display(1/(k^2) < 1/((k-1)k) = 1/(k-1) - 1/k)$，对任意 $p in NN_+$ 有
		$
		sum_(k=n+1)^(n+p) 1/(k^2) < sum_(k=n+1)^(n+p) 1/((k-1)k) = sum_(k=n+1)^(n+p) (1/(k-1) - 1/k) = 1/n - 1/(n+p) < 1/n
		$
		所以 $forall eps >0,sp exists N = display([1/eps])$ 满足当 $n>N$ 时，$forall p in NN_+$ 均有 $display(sum_(k=n+1)^(n+p) 1/(k^2) < 1/n < eps)$，则根据柯西收敛准则，级数 $display(sum_(n=1)^(+oo) 1/(n^2))$ 收敛。
	]
]

== 收敛级数的基本性质

#theorem[
	若级数 $ss a_n, ss b_n$ 均收敛，则对任意 $k_1,k_2 in RR$，$ss (k_1 a_n + k_2 b_n)$ 也收敛，且
	$
	sss (k_1 a_n + k_2 b_n) = k_1 sss a_n + k_2 sss b_n
	$
]

#corollary[
	若级数 $ss a_n$ 收敛且级数 $ss b_n$ 发散，则级数 $ss (a_n + b_n)$ 发散。
]

#theorem[
	去掉、添加或修改级数中的有限项，不影响级数的敛散性。

	#proof[
		由柯西收敛准则可知级数的敛散性与其前有限项无关。
	]
]

#theorem(name: "收敛级数的结合性")[
	收敛级数任意添加括号后所得级数仍然收敛，且其和不变。

	#proof[
		原级数收敛，故其部分和数列 ${S_n}$ 收敛。而添加括号后的级数的部分和数列 ${sigma_n}$ 是 ${S_n}$ 的一个子列，故 ${sigma_n}$ 收敛，且极限与 ${S_n}$ 的极限相同。
	]

	#caution[
		这一结论对于发散级数并不成立，如 $(1-1)+(1-1)+dots.c$ 收敛但原级数发散。
	]
]

#theorem(name: "级数收敛的必要条件")[
	若级数 $ss a_n$ 收敛，则 $display(lim_(n->+oo) a_n) = 0$。

	#caution[
		这是必要条件而非充分条件，例： 级数 $sss display(ln(1+1/n))$ 的一般项趋于 $0$ 而级数发散。
	]
]

== 正项级数

#definition[
	若级数 $ss a_n$ 中的各项均有 $a_n>0$，则该级数为#bb[正项级数]。
]

#theorem(name: "正项级数收敛的充要条件")[
	正项级数收敛的充要条件是它的部分和数列 ${S_n}$ 有上界。

	#proof[
		可由单调有界定理导出。
	]
]


== 正项级数的敛散性判别

#theorem(name: "比较判别法")[
	对于正项级数 $ss a_n,ss b_n$，若存在 $N$ 使得当 $n>N$ 时 $a_n<=k b_n sp (k>0)$ 恒成立，则：

	(1) 若 $ss b_n$ 收敛，则 $ss a_n$ 必收敛。

	(2) 若 $ss a_n$ 发散，则 $ss b_n$ 必发散。
]

\

比较判别法也可用极限形式表示。

#theorem(name: "极限判别法")[
	对于正项级数 $ss a_n, ss b_n$，如果 $display(lim_(n->+oo) (a_n)/(b_n)) = l$，那么

	(1) 当 $0<l<+oo$ 时，级数 $ss a_n, ss b_n$ 具有相同的敛散性；
	
	(2) 当 $l=0$ 时，若 $ss b_n$ 收敛，则 $ss a_n$ 也收敛；
	
	(3) 当 $l=+oo$ 时，若 $ss b_n$ 发散，则 $ss a_n$ 也发散。

	#proof[
		(1) 123


		(3) 是 (2) 倒过来的情况，证明只需要注意到“若 $ss a_n$ 发散，则 $ss a_n$ 发散”是“若 $ss b_n$ 收敛，则 $ss b_n$ 收敛”的逆否命题。
	]
]

#note[
	这一定理的记忆可以类比无穷小的概念：若 $l=1$，则 $a_n$ 是 $b_n$ 的等价无穷小；若 $l=0$，则 $a_n$ 是 $b_n$ 的高阶无穷小。一般来说，我们找个同阶无穷小来判定敛散性会比较方便。
]

#example[
	#problem[
		判断级数 $sss display((1/n - ln(1+1/n)))$ 的敛散性。
	]

	#solution[
		因为当 $x->0$ 时，$display(x-ln(1+x) = x - (x - x^2/2 + o(x^2)) = x^2/2 + o(x^2))$。所以

		$ lim_(x->0) (x-ln(1+x))/(x^2) = 1/2 $
		
		从而有

		$ lim_(n->+oo) n^2 (1/n - ln(1+1/n)) = 1/2 $

		而级数 $sss display(1/(n^2))$ 收敛，因此级数 $sss display((1/n - ln(1+1/n)))$ 也收敛。
	]
]

\

#property[
	通常称 $sss display(1/(n^p))$ 为 #bb[$p$-级数]。当 $p<=1$ 时，$p$-级数发散；当 $p>1$ 时，$p$-级数收敛。

	#proof[
		当 $p<=1$ 时，$display(1/(n^p)>=1/n)$，而调和级数发散，因此当 $p<=1$ 时，级数 $sss display(1/(n^p))$ 发散。

		当 $p>1$ 时，对函数 $f(x)=display(1/(x^(p-1)) sp (x>=1))$ 在区间 $[n,n+1]$ 上应用拉格朗日中值定理，$exists theta_n in (0,1)$ 使得

		$ 1/((n+1)^(p-1)) - 1/(n^(p-1)) = f(n+1)-f(n) = f'(n+theta_n) = - (p-1)/(n+theta_n)^p $

		则

		$ 1/(p-1) (1/(n^(p-1)) - 1/((n+1)^(p-1))) = 1/((n+theta_n)^p) > 1/((n+1)^p) $

		又正项级数 $sss display((1/(n^(p-1)) - 1/((n+1)^(p-1))))$ 收敛，根据比较判别法，当 $p>1$ 时，级数 $sss display(1/(n^p))$ 收敛。
	]
]

#theorem(name: "比值判别法，达朗贝尔判别法")[
	对于正项级数 $ss a_n$，若 $display(lim_(n->+oo) (a_(n+1))/(a_n)) = l$，则

	(1) 当 $0<=l<1$ 时，级数 $ss a_n$ 收敛；
	
	(2) 当 $l>1$ 时，级数 $ss a_n$ 发散；

	(3) 当 $l=1$ 时，比值判别法失效。

	// #proof[]
]


#theorem(name: "根值判别法，柯西判别法")[
	对于正项级数 $ss a_n$，若 $display(lim_(n->+oo) root(n,a_n)) = l$，则

	(1) 当 $0<=l<1$ 时，级数 $ss a_n$ 收敛；
	
	(2) 当 $l>1$ 时，级数 $ss a_n$ 发散；

	(3) 当 $l=1$ 时，比值判别法失效。

	// #proof[]
]


#theorem(name: "积分判别法")[
	设函数 $f(x)$ 在 $[1, +oo)$ 上单调递减，则级数 $ss f(n)$ 与反常积分 $display(int_1^(+oo) f(x) dx)$ 具有相同的敛散性。

	// #proof[]
]

== 一般项级数的敛散性判别

=== 交错级数与莱布尼茨判别法

#definition[
	若 $a_n>0 sp(n=1,2,dots.c)$，则称 $ss (-1)^(n-1) a_n$ 为#bb[交错级数]。
]

#theorem(name: "莱布尼茨判别法")[
	若交错级数 $ss (-1)^(n-1) a_n sp(a_n>0)$ 满足

	(1) 数列 ${a_n}$ 单调递减，即 $a_(n+1)<=a_n sp (n=1,2,dots.c)$；

	(2) $display(lim_(n->+oo) a_n = 0)$。

	则交错级数 $ss (-1)^(n-1) a_n$ 收敛且其和 $S<=a_1$。

	#proof[
		$
		S_(2m) = (a_1-a_2)+(a_3-a_4)+dots.c+(a_(2m-1)-a_(2m))
		$
		由 ${a_n}$ 单调递减知 ${S_(2m)}$ 单调增。另一方面：
		$
		S_(2m) = a_1 - (a_2-a_3) - (a_4-a_5)-dots.c-(a_(2m-2)-a_(2m-1))-a_(2m)<a_1
		$
		根据单调有界定理知 $S_(2m)$ 有上界，故 ${S_(2m)}$ 收敛。记 $dp(lim_(m->+oo) S_(2m) = S<a_1)$。

		而 $S_(2m+1)=S_(2m)+a_(2m+1)$，由条件 $dp(lim_(n->+oo) a_n)=0$ 和极限的四则运算法则得 $dp(lim_(m->+oo) S_(2m+1)=S)$。故原级数收敛且其和为 $S$。
	]
]

#example[
	#problem[
		判断级数 $display(sum_(n=2)^(+oo) ((-1)^n)/(sqrt(n) + (-1)^n))$ 的敛散性。
	]\

	#solution[
		由于 $display(((-1)^n)/(sqrt(n) + (-1)^n) = ((-1)^n (sqrt(n) - (-1)^n))/(n-1) = (-1)^n sqrt(n)/(n-1) - 1/(n-1))$。根据莱布尼茨判别法可知级数 $display(sum_(n=2)^(+oo) (-1)^n sqrt(n)/(n-1))$ 收敛，而调和级数 $display(sum_(n=2)^(+oo) 1/(n-1))$ 发散。故原级数发散。 
	]
]

=== 利用级数绝对收敛的性质

#definition[
	若级数 $ss |a_n|$ 收敛，则称级数 $ss a_n$ #bb[绝对收敛]，若级数 $ss a_n$ 收敛而级数 $ss |a_n|$ 发散，则称级数 $ss a_n$ #bb[条件收敛]。
]

#theorem(name: "级数的绝对收敛准则")[
	若级数 $ss a_n$ 绝对收敛，则级数 $ss a_n$ 必收敛。

	#proof[
		【*法一*】注意到 $0<=a_n+|a_n|<=2|a_n|$，因为 $ss |a_n|$ 收敛，所以 $ss 2|a_n|$ 也收敛，由比较判别法得 $ss (|a_n|+a_n)$ 收敛。而 $a_n=(|a_n|+a_n)-a_n$，由级数性质知 $ss a_n$ 收敛。

		【*法二*】如果级数 $ss a_n$ 绝对收敛，由柯西收敛准则，$forall eps > 0$，$exists N > 0$，当 $n>N$ 时，$forall p in NN_+$ 有
		$ |a_(n+1)| + |a_(n+2)| + dots.c + |a_(n+p)| < eps $
		因此
		$ |a_(n+1) + a_(n+2) + dots.c + a_(n+p)| < |a_(n+1)| + |a_(n+2)| + dots.c + |a_(n+p)| < eps $
		故根据柯西收敛准则，级数 $ss a_n$ 收敛。
	]
]

通过这一性质，我们可将级数 $ss a_n$ 的判别转化为对 $ss |a_n|$ 的判别。 

\

这种方法常常与比值判别法、根治判别法等方法连用，来解决一般级数的敛散性判别问题。

#theorem(name: "绝对值的比值判别法")[
	对于一般级数 $ss a_n$，若 $display(lim_(n->+oo) abs(a_(n+1))/abs(a_n) = l)$ 存在，则：

	(1) $l < 1$ 时，级数绝对收敛；

	(2) $l > 1$（包括 $l = +oo$）时，级数发散；

	(3) $l = 1$ 时，绝对值的比值判别法失效。

	#note[
		第 (1), (3) 条都可以由比值判别法和绝对收敛准则导出。第 (2) 条成立主要是因为 $l>1$ 时，
		$ display(lim_(n->+oo) |a_n| = +oo) != 0 $
		故 $display(lim_(n->+oo) a_n)!=0$ 也成立，级数必不收敛。
	]
]

#theorem(name: "绝对值的根值判别法")[
	对于一般级数 $ss a_n$，若 $display(lim_(n->+oo) root(n,abs(u_n)) = l)$，则：

	(1) $l<1$ 时，级数绝对收敛；

	(2) $l>1$（包括 $l=+oo$ 时），级数发散；

	(3) $l=1$ 时，绝对值的根值判别法失效。
]

#example[
	#problem[
		判断级数的敛散性：$display(sss ((-1)^(n-1))/n x^n)$。
	]
	#solution[
		$
		lim_(n->+oo) abs(u_(n+1)/u_n)
		= lim_(n->+oo) n/(n+1) abs(x) = abs(x)
		$
		可见，$|x|<1$ 时级数（绝对）收敛；$|x|>1$ 时级数发散；

		$x=1$ 时，级数 $display(sss ((-1)^(n-1))/n x^n = sss ((-1)^(n-1))/n)$ 收敛；

		$x=-1$ 时，级数 $display(sss ((-1)^(n-1))/n x^n = sss (-1)/n)$ 发散。

		总之，级数当 $|x|<1$ 时绝对收敛，当 $x=1$ 时条件收敛，$|x|>1$ 或 $x=-1$ 时发散。
	]
]

\

绝对收敛级数具有和普通有限项和数相仿的两个运算性质——交换律和分配律成立，请看下面的两个定理。

#definition[
	把自然数数列 ${1,2,dots.c,n,dots.c}$ 到它自身的一一映射 $f:n->k(n)$ 称为自然数数列的重排。
]

#theorem(name: "绝对收敛的条件下无限个数相加的加法交换律")[
	设级数 $ss a_n$ 绝对收敛，且其和等于 $S$，则任意重排得到的级数 $ss a_n'$ 也绝对收敛，且有相同的和数 $S$。

	#note[
		由条件收敛级数重排得到的新级数可能发散，即使收敛也不一定收敛于原来的和数，甚至可以收敛于任何事先指定的数。（黎曼定理）

		#example[
			如有结论 $ln 2 = display(1-1/2+1/3-1/4+1/5-1/6+dots.c)$。
			
			两边同乘 $display(1/2)$ 得 $dp(1/2 ln 2 = 1/2 - 1/4 + 1/6 - 1/8 + dots.c)$。
			
			两式相加有 $dp(3/2 ln 2 = 1+1/3 - 1/2 + 1/5 + 1/7 - 1/4 + dots.c)$。这是原级数的重排。虽然重拍后的级数仍然收敛，但是其和发生了变化。
		]
	]
]

#theorem(name: "柯西定理")[
	设级数 $ss a_n = A$ 和 $ss b_n = B$ 都绝对收敛，则它们的柯西乘积按任意顺序排列所得到的级数 $ss c_n$ 也绝对收敛，且其和为 $A B$。
	
	#corollary(name: "梅尔腾斯定理*")[
		若级数 $ss a_n = A$ 与 $ss b_n = B$ 中有一个绝对收敛，另一个条件收敛，则它们的柯西乘积（按照对角线顺序取）所组成的级数仍收敛，且其和为 $A B$。
	]
]


// === 阿贝尔判别法与狄利克雷判别法

// #lemma(name: "阿贝尔变换")[
// 	设 ${a_n}$ 与 ${b_n}$ 是两数列，即 $B_n = display(sum_(k=1)^n b_k)$，则 
// 	$ sum_(k=1)^n a_k b_k = a_n B_n + sum_(k=1)^(n-1) (a_k-a_(k+1)) B_k $
// ]

// #corollary(name: "阿贝尔引理")[
// 	若数列 ${a_n}$ 与级数 $ss b_n$ 的部分和数列 ${B_n}$ 满足：

// 	(1) 数列 ${a_n}$ 单调，且 $exists A>0$，$forall n in NN_+$ 均有 $|a_n| <= A$;

// 	(2) $exists eps>0$，$forall n in NN_+$，均有 $|B_n| < eps$；

// 	则 $forall n in NN_+$，有 $display(lr(| sum_(k=1)^n a_k b_k <= 3 A eps |))$。

// 	#proof[
// 		根据阿贝尔变换，
// 		$
// 		lr(|sum_(k=1)^n a_k b_k|)
// 		&= lr(| a_n B_n + sum_(k=1)^(n-1) (a_k - a_(k+1)) B_k |)
// 		&= lr(|a_n B_n|) + sum_(k=1)^(n-1) |a_k - a_(k+1)| dot.c |B_k|
// 		$
// 	]
// ]

== 函数项级数\*

#definition[
	设 $u_1(x),u_2(x),dots.c,u_n(x),dots.c$ 是定义在 $I in RR$ 上的函数，则 
	$ ss u_n(x) = u_1(x)+u_2(x)+dots.c+u_n(x) + dots.c $
	称为定义在区间 $I$ 上的#bb[函数项级数]。
]

#definition[
	如果 $x_0 in I$，数项级数 $ss u_n(x_0)$ 收敛，则称 $x_0$ 为级数 $ss u_n(x)$ 的#bb[收敛点]，否则称为#bb[发散点]。
]

#definition[
函数项级数 $ss u_n(x)$ 的所有收敛点的全体称为#bb[收敛域]，所有发散点的全体称为#bb[发散域]。
]

#definition[
	称
	$ S_n  = u_1(x) + u_2(x) + dots.c + u_n(x) $
	为函数项级数 $ss u_n(x)$ 的（第 $n$ 个）#bb[部分和函数]。若 $dp(lim_(n->+oo) S_n(x) = S(x))$，则称 $S(x)$ 为函数项技术 $ss u(x)$ 的#bb[和函数]。
]

#note[
	在判定函数项级数的敛散性时，常常与比值判别法、根值判别法连用。对于 $l=1$ 的特殊情况，此时 $x$ 一般为确定值，再用数项级数的方法进行判断。
]

== 幂级数

#definition[
	称函数项级数
	$ a_0+a_1 (x-x_0)+dots.c+a_n (x-x_0)^n +dots.c = ssf(0) a_n (x-x_0)^n $
	为关于 $x-x_0$ 的#bb[幂级数]，其中 $a_n$ 称为#bb[幂级数系数]。
	
	特别地，取 $x_0=0$，称
	$ a_0 +a_1 x + dots.c + a_n x^n = ssf(0) a_n x^n $
	为关于 $x$ 的幂级数。

	显然，任何幂级数 $sf(0) a_n x^n$ 在 $x=0$ 处收敛。
]

=== 幂级数的收敛半径与收敛域

#theorem(name: "阿贝尔定理")[

	(1) 如果级数 $sf(0) a_n x^n$ 在 $x=x_1(x_1!=0)$ 处收敛，则它在满足不等式 $|x|<|x_1|$ 的一切 $x$ 处绝对收敛。

	(2) 如果级数 $sf(0) a_n x^n$ 在 $x=x_2$ 处发散，则它在满足不等式 $|x|>|x_2|$ 的一切 $x$ 处发散。
 
	#proof[
		下证 (1)。因为 $sf(0) a_n x_1^n$ 收敛，所以 $dp(lim_(n->+oo) a_n x_1^n=0)$，$exists M>0$，使得 $|a_n x_1^n|<=M sp (n=0,1,2,dots.c)$。

		由于 $|x|<|x_1|$，有 $dp(|x/x_1|<1)$，
		$
		|a_n x^n| = abs(a_n x_1^n dot (x^n)/(x_1^n)) = |a_n x_1^n| dot abs(x/x_1)^n <= M abs(x/x_1)^n
		$
		而等比级数 $dp(ssf(0) M abs(x/x_1)^n)$ 收敛，故 $sf(0) a_n x^n$ 收敛，因此级数 $ss a_n x^n$ 绝对收敛。

		得到 (1) 后通过反证法可证明 (2)。
	]
]

可以发现，幂级数 $ss a_n x^n$ 的收敛域是一个以 $x=0$ 为中心的区间。

#definition[
	设幂级数 $ss a_n x^n$ 的收敛域的长度为 $2R$，则称 $R$ 为幂级数 $ss a_n x^n$ 的#bb[收敛半径]，称 $(-R,R)$ 为该幂级数的#bb[收敛区间]。
]

#theorem[
	设幂级数 $ss a_n x^n$ 的所有系数 $a_n!=0$，且 $dp(lim_(n->+oo) abs(a_(n+1)/a_n)) = rho$ 或 $dp(lim_(n->+oo) root(n,abs(a_n))) = rho$，则幂级数 $ss a_n x^n$ 的收敛半径 $R$ 满足

	(1) 当 $0<rho<+oo$ 时，收敛半径 $R=dp(1/rho)$；

	(2) 当 $p=0$ 时，收敛半径 $R = +oo$；

	(3) 当 $rho=+oo$ 时，收敛半径 $R=0$。

	#note[
		直接计算，就是 $dp(R = lim_(n->+oo) abs(a_n/a_(n+1)))$ 或 $R = dp(lim_(n->+oo) 1/root(n,abs(a_n)))$。

		如果不满足所有系数 $a_n!=0$，则通过修改下面的证明过程来完成。该证明过程需要掌握（期中必考）。
	]

	#proof[
		以 $dp(lim_(n->+oo) abs(a_(n+1)/a_n))=rho$ 的情况举例：如果 $0<rho<+oo$，

		- 当 $abs(x)<dp(1/rho)$ 时，$rho abs(x)<1$，$ss a_n x^n$ 绝对收敛；

		- 当 $abs(x)>dp(1/rho)$ 时，$rho abs(x)>1$，$ss abs(a_n x^n)$ 发散，故 $ss a_n x^n$ 发散。

		故收敛半径 $R = dp(1/rho)$。类似的，可以处理 $rho=0$ 和 $rho=+oo$ 的情况。
	]
]

#tip[
	【求幂级数的收敛域】

	- 先根据上面的做法来确定收敛半径 $R$。（童雯雯老师要求写上：所以，收敛半径为 $(-R,R)$）
	- 检验 $x=-R$ 和 $x=+R$ 时是否收敛，从而确定收敛域。
]

=== 幂级数的运算

#theorem[
	设 $sf(0) a_n x^n$ 和 $sf(0) b_n x^n$ 在 $x=0$ 的某邻域内相等，则它们的同幂次项相等，即
	$ a_n=b_n sp (n=0,1,2,dots.c) $
]

#theorem[
	设 $sf(0) a_n x^n$ 和 $sf(0) b_n x^n$ 的收敛半径分别为 $R_1$ 和 $R_2$，则令 $R=min{R_1,R_2}$，有以下运算成立：

	- 加法：$sf(0) a_n x^n + sf(0) b_n x^n = ss (a_n + b_n) x^n quad (|x|<R)$；

	- 减法：$sf(0) a_n x^n - sf(0) b_n x^n = ss (a_n - b_n) x^n quad (|x|<R)$；

	- 数乘：$lambda sf(0) a_n x^n = sf(0) lambda a_n x^n, sp |x|<R_1$，其中 $lambda$ 是常数；

	- 乘法：$(sf(0) a_n x^n) (sf(0) b_n x^n) = (sf(0) c_n x^n), sp |x|<R$，其中 $c_n=dp(sum_(k=0)^n a_k b_(n-k))$。

	#note[
		可以理解为，在收敛半径内，幂级数符合多项式的若干性质。
	]
]

=== 幂级数的分析性质

#theorem[
	设幂级数 $sf(0) a_n x^n$ 的收敛半径为 $R>0$，且 $S(x) = sf(0) a_n x^n, sp |x|<R$，则

	1. $S(x)$ 在幂级数的收敛区间 $(-R,R)$ 内连续。即
	$ forall x_0 in (-R,R), quad dp(lim_(x->x_0) S(x) = S(x_0)) $

	2. 幂级数 $sf(0) a_n x^n$ 在 $(-R,R)$ 内可以逐项微分、逐项积分，且经过这些运算后所得的幂级数与原幂级数有相同的收敛半径（但是收敛域可能改变）。即
	$ S'(x) = ssf(0) (a_n x^n)' = ssf(0) n a_n x^(n-1), sp |x|<R $
	
	$ int_0^x S(x) dif x = ssf(0) int_0^x a_n x^n dif x = ssf(0) dp(a_n/(n+1) x^(n+1)), sp |x|<R $

	#corollary[
		设 $S(x)$ 是幂级数 $sf(0) a_n x^n$ 在收敛区间 $(-R,R)$ 内的核函数，则 $S(x)$ 在 $(-R,R)$ 内任意阶可导，且可逐项求导，收敛半径仍是 $R$，即
	]

	#corollary[
		若幂级数 $sf(0) a_n x^n$ 在收敛区间的端点 $x=R$ 处收敛，则 $S(x) = sf(0) a_n x^n$ 在 $x=R$ 处左方连续，即 $dp(lim->(R^-) sf(0) a_n x^n = sf(0) a_n R^n)$，或 $dp(lim_(x->R^-) S(x) = S(R))$。对应到另一侧同理。
	]

	#example[
		#problem[
			求幂级数 $sss dp(x^(2n+1)/(2n))$ 的收敛域。
		]

		#solution[
			设 $S(x) = sss dp(x^(2n)/(2n))$，则 $S(0)=0$，$sss dp(x^(2n+1)/(2n)) = x S(x)$。注意到
			$
			S'(x) = (sss (x^(2n))/(2n))'  =sss x^(2n-1) = x/(1-x^2), sp |x|<1\
			=> S(x) = int_0^x S'(x) dif x = int_0^x x/(1-x^2) dif x = -1/2 ln(1-x^2),sp |x|<1
			$
			所以收敛区间为 $(-1,1)$。当 $x=pm 1$ 时，此级数为 $ssf(0) dp(1/(2n))$ 发散，所以收敛域为 $(-1,1)$。
		]
	]
]

=== 将函数展开成幂级数

#theorem[
	如果函数 $f(x)$ 在 $U(x_0, delta)$ 内具有任意阶导数，_且_在 $U(x_0,delta)$ 内能展开成 $(x-x_0)$ 的幂级数，即 $f(x) = sf(0) a_n (x-x_0)^n,space x in (x_0 - delta, x_0 + delta)$，则其系数 $a_n = display(1/(n!) f^((n))(x_0)),space n=1,2,dots.c$，且展开式是唯一的。

	#tip[
		据此，我们可以通过函数的展开式来求函数的 $n$ 阶导数。

		#caution[
			不要忽略阶乘！
		]	
	]
]

==== 函数能展开成泰勒级数的条件

#definition[
	称 $display(f(x) = f(x_0)+f'(x_0)(x-x_0) + (f''(x_0))/2 (x-x_0)^2 + dots.c + (f^((n))(x_0))/(x-x_0)^n + dots.c),space x in (x_0-delta, x_0+delta)$ 为 $f(x)$ 在 $x=x_0$ 处的#def[泰勒级数]。当 $x_0=0$ 时，称这一级数为#def[麦克劳林级数]。
]

#theorem(name: "函数能展开成幂级数的必要条件")[
	设函数 $f(x)$ 在点 $x_0$ 的某一邻域内具有各阶导数，则 $f(x)$ 在该邻域内能展开成泰勒级数的充分必要条件是 $f(x)$ 的泰勒公式中的余项 $R_n (x)=display((f^((n+1))(xi))/((n+1)!) (x-x_0)^(n+1))$ 当 $n->+oo$ 时趋向于 $0$。此时有
	$ f(x) = ssf(0) (f^((n)) (x_0))/(n!) (x-x_0)^n $

	#proof[
		*必要性*：若 $R_n (x)$ 的极限不为 $0$，则幂级数的和函数不能收敛到定值 $f(x)$。

		*充分性*：即证 $display(lim_(n->+oo)) S_n (x) = f(x)$，由泰勒公式知 $f(x) = S_n (x) + R_n (x)$，故 $display(lim_(n->+oo)) S_n (x) = display(lim_(n->+oo)) (f(x) - R(x)) = f(x) - 0 = f(x)$。
	]
]

==== 将函数展开成幂级数的方法

直接求导的方法自不必说。

#example[
	#problem[
		将 $f(x)=arctan x$ 展开成 $x$ 的幂级数。
	]

	#solution[
		$ f'(x) = 1/(1+x^2)=1-x^2+x^4-x^6+dots.c+(-1)^n x^(2n) + dots.c,space abs(x)<1 $
		$ => arctan x = arctan 0 + int_0^x 1/(1+x^2) dif x = x - x^3/3+x^5/5-x^7/7+dots.c+(-1)^n (x^(2n+1))/(2n+1) + dots.c,space abs(x)<1 $
	]
]

#example[
	#problem[
		将 $f(x)=display(x/(1+x-2x^2))$ 展开成 $x$ 的幂级数。
	]

	#solution[
		$ f(x) = x/((1-x)(1+2x)) = 1/3 (1/(1-x) - 1/(1+2x)) $
		其中 $display(1/(1-x) = ssf(0) x^n\,space abs(x)<1)$，$display(1/(1+2x) = ssf(0) (-2)^n x^n \,space abs(2x)<1)$，则
		$ f(x)=1/3 ssf(0) (x^n - (-2)^n x^n) = ssf(0) (1-(-2)^n)/3 x^n, space abs(x)<1/2 $
	]
]

==== 利用幂级数展开求函数积分

利用幂级数展开求解不定积分的情况：

#example[
	#problem[
		求 $display(int (sin x)/x) dif x$
	]

	#solution[
		$
		sin x = ssf(0) (-1)^n (x^(2n+1))/((2n+1)!),space x in (-oo,+oo)
		=> (sin x)/x = ssf(0) (-1)^n (x^(2n))/((2n+1)!),space x in (-oo,+oo)\
		=> "原式" = C + ssf(0) (-1)^n (x^(2n+1))/((2n+1) dot ((2n+1)!)),space x in (-oo,+oo)
		$
	]
]

应用此方法，也可以求函数的定积分：

#example[
	#problem[
		求 $display(int_0^1 e^(-x^2) dif x)$。
	]
	
	#solution[
		$
		e^(-x^2) = ssf(0) ((-1)^n x^(2n))/(n!) ,space x in (-oo,+oo) \
		=> "原式" = lr((ssf(0) ((-1)^n x^(2n+1))/((2n+1) dot n!))|)_0^1
		= ssf(0) ((-1)^n)/((2n+1) dot n!)
		$
	]
]



== 傅里叶级数

=== 三角级数

简谐振动：$y = A sin(omega x + phi) = a cos omega x + b sin omega x$，周期为 $T$。

简谐振动的叠加：$y_k =a_k cos k omega x + b_k sin k omega x$，周期为 $display(T/k)$。则 $ss y_k=ss (a_k cos k omega  + b_k sin k omega x)$ 以 $T$ 为周期。

三角级数可以理解为无数个简谐振动的叠加。

#definition[
	将下式称为#def[三角级数]：
	$
	(a_0)/2 + sss (a_n cos n omega x + b_n sin n omega x)
	" 或 "
	(a_0)/2 + sss (a_n cos (n pi x)/l + b_n sin (n pi x)/l)
	$
	其中，$a_n,b_n$ 称为#def[三角级数的系数]。将
	$
	&1,cos omega x,sin omega x,cos 2 omega x,sin 2 omega x, dots.c,cos n omega,sin n omega x,dots.c\
	" 或 "&
	1,cos (pi x)/l,sin (pi x)/l,cos (2 pi x)/l,sin (2 pi x)/l, dots.c,cos (n pi x)/l,sin (n pi x)/l,dots.c
	$
	称为#def[三角函数系]。
]

#theorem(name: "三角函数系的正交性")[
	三角函数系中的任意两个不同函数的乘积在 $[-l,l]$ 上的积分等于零。
]

#theorem(name: "三角函数的和函数与系数的关系")[
	设在整个数轴上有
	$ f(x) = (a_0)/2 + sss (a_n cos (n pi x)/l + b_n sin (n pi x)/l) $
	并设上式右端逐项可积，且乘以 $display(cos (n pi x)/l)$ 或 $display(sin (n pi x)/l)$ 后仍逐项可积，则
	$
	a_n &= 1/l int_(-l)^l f(x) cos (n pi x)/l dif x, space n=0,1,2,3,dots.c\
	b_n &= 1/l int_(-l)^l f(x) sin (n pi x)/l dif x, space n=1,2,3,dots.c\
	$

	#proof[
		TBD
	]
]

=== 傅里叶级数

#definition(name: "傅里叶级数")[
	设 $f(x)$ 是以 $2l$ 为周期的周期函数，且 $f(x)$ 在 $[-l,l]$ 上可积，称
	$
	a_n &= 1/l int_(-l)^l f(x) cos (n pi x)/l dif x, space n=0,1,2,3,dots.c\
	b_n &= 1/l int_(-l)^l f(x) sin (n pi x)/l dif x, space n=1,2,3,dots.c\
	$
	为 $f(x)$ 的#def[傅里叶系数]，称三角级数
	$
	(a_0)/2 + sss (a_n cos (n pi x)/l + b_n sin (n pi x)/l)
	$
	为 $f(x)$ 的#def[傅里叶级数]。记作
	$
	f(x) sim (a_0)/2 + sss (a_n cos (n pi x)/l + b_n sin (n pi x)/l)
	$

	#warning[
		注意两者之间不能简单的划等号，因为我们并不能保证这一函数项级数收敛。
	]
]

#definition(name: [逐段光滑])[
	称函数 $f(x)$ 是#def[逐段光滑]的，当且仅当 $f(x)$ 对任意有限区间 $[a,b]$，存在有限个点，将区间 $[a,b]$ 分成有限个子区间，使得函数 $f(x)$ 在每个子区间内连续，且有连续的导数 $f'(x)$，而在这些子区间的端点处 $f(x)$ 及 $f'(x)$ 最坏只能是第一类间断点。
]

#theorem(name: "狄利克雷定理")[
	设 $f(x)$ 是以 $2l$ 为周期的周期函数，且 $f(x)$ 在 $[-l,l]$ 上_逐段光滑_，则 $f(x)$ 的傅里叶级数在每一点 $x$ 上都收敛，且和函数满足
	$ S(x) = cases(
		f(x)\, quad & x "是 " f(x) "的连续点" ,
		display((f(x-0)+f(x+0))/2)\, quad& x "是 " f(x) "的第一类间断点",
		display((f(-l+0)+f(l-0))/2)\,quad& x=pm l
	) $
	其中 $display(f(a-0)=lim_(x->a^-) f(x)\,space f(a+0)=lim_(x->a^+) f(x))$。
]

#definition(name: "正弦傅里叶级数")[
	当 $f(x)$ 为奇函数时，它的傅里叶系数为
	$
	a_n &= 0, space n=0,1,2,3,dots.c\
	b_n &= 2/l int_0^l f(x) sin (n pi x)/l dif x, space n=1,2,3,dots.c
	$
	这时 $f(x) sim display(sss b_n sin (n pi x)/l)$ 称为 $f(x)$ 的#def[正弦傅里叶级数]，简称#def[正弦级数]。
]

#definition(name: "余弦傅里叶级数")[
	当 $f(x)$ 为偶函数时，它的傅里叶系数为
	$
	a_n &= 2/l int_0^l f(x) cos (n pi x)/l dif x, space n=0,1,2,3,dots.c\
	b_n &= 0, space n=1,2,3,dots.c
	$
	这时 $f(x) sim display(a_0/2 + sss a_n cos (n pi x)/l)$ 称为 $f(x)$ 的#def[余弦傅里叶级数]，简称#def[余弦级数]。
]


=== 周期延拓

#definition[
	对定义在 $[-l,l]$ 上的函数 $f(x)$ 作#def[周期延拓]得
	$ F(x) = cases(
		f(x)\,quad &x in [-l,l),
		f(x-2k l)\,quad &x in (-oo,-l) union [l,+oo)
	) $
	对其进行傅里叶展开得
	$
	f(x) sim (a_0)/2 + sss (a_n cos (n pi x)/l + b_n sin (n pi x)/l)
	$
]

=== 奇延拓和偶延拓

求解定义在 $[0,l]$ 上的函数 $f(x)$ 的傅里叶级数时，可以将其延拓到 $(-l,l)$ 上，从而求得傅里叶级数。

$
f(x),space x in [0,l]
xarrow("延拓")
F(x) = cases(
	f(x)\,quad& x in [0,l),
	"任意函数" \,quad& x in (-l,0)
)
$

为了计算方便，我们一般将 $f(x)$ 延拓成奇函数或偶函数，这就是奇延拓与偶延拓。

#definition(name: "奇延拓")[
	对定义在 $[0,l]$ 上的函数 $f(x)$ 作#def[奇延拓]得
	$ F(x) = cases(
		f(x)\,quad &x in (0,l),
		0\,quad& x=0,
		-f(-x)\,quad &x in (-l,0)
	) $
	对其进行傅里叶展开得 
	$
	F(x) sim sss b_n sin (n pi x)/l\,space -l<=x<=l
	$
	从而得 $f(x)$ 的#def[正弦傅里叶级数]。
	$
	f(x) sim sss b_n sin (n pi x)/l\,space 0<=x<=l
	$
]

#definition(name: "偶延拓")[
	对定义在 $[0,l]$ 上的函数 $f(x)$ 作#def[偶延拓]得
	$ F(x) = cases(
		f(x)\,quad &x in [0,l),
		f(-x)\,quad &x in (-l,0)
	) $
	对其进行傅里叶展开得 
	$
	F(x) sim a_0/2 + sss a_n cos (n pi x)/l\,space -l<=x<=l
	$
	从而得 $f(x)$ 的#def[余弦傅里叶级数]。
	$
	f(x) sim a_0/2 + sss a_n cos (n pi x)/l\,space 0<=x<=l
	$
]