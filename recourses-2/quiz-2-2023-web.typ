#import "../template.typ": *
#import "./exam-template.typ": *

#show: project.with(
  course: "Calculus II",
  course_fullname: "Calculus (A) II",
  course_code: "821T0160",
  title: "Quiz #2 (Spring-Summer 2024, Wednesday)",
  authors: (
    (
      name: "memset0",
      email: "https://mem.ac/",
      id: [_memset0\@outlook.com_],
    ),
  ),
  semester: "Spring-Summer 2024",
  date: "May 22, 2024",
)

#prob[
  若函数 $f(x,y)$ 在点 $P(0,1)$ 处连续，且满足
  $
    f(x,y) = 5 + x - y + x^2 + 4x(y-1) + (y-1)^2 + o(x^2 + (y-1)^2). quad (x->0,y->1)
  $
  则下列结论中正确的是

  #options(
    [$f'_x (0,1) = 1$],
    [$atpos(dif f, (0,1), "") = dx - dy$],
    [$f(x,y)$ 在 $(0,1)$ 处有极值],
    [曲面 $z=f(x,y)$ 在点 $(0,1,f(0,1))$ 处的切平面为 $z=x-y+5$],
    [若其他选项都没选，则选此项],
  )
]

#prob[
  设平面区域 $D$ 是由曲线 $y=sin pi/2 x$ 与直线 $y=1,x=-1$ 所围成，则二重积分 $int.double_D (3x^2 cos y + x^3 tan y) dif sigma=$

  #options(
    columns: 3,
    $0$,
    $1$,
    $2 sin 1$,
    $(sin 1) / 3$,
    [若其他选项都没选，则选此项],
  )
]

#pagebreak()
#prob[
  设函数 $u(x,y)$ 在有界闭区域 $D$ 上具有二阶连续偏导数，且满足 $display((diff^2 u)/(diff x diff y) != 0\, space (diff^2 u)/(diff x^2) + (diff^2 u)/(diff y^2) = 0)$，则：下列陈述正确的是

  #options(
    [函数 $u(x,y)$ 的最大值与最小值点必在 $D$ 的内部],
    [函数 $u(x,y)$ 的最大值与最小值点必在 $D$ 的边界上],
    [函数 $u(x,y)$ 的最小值点在 $D$ 的内部，最大值点在 $D$ 的边界上],
    [函数 $u(x,y)$ 的最大值点在 $D$ 的内部，最小值点在 $D$ 的边界上],
    [若其他选项都没选，则选此项],
  )
]

#prob[
  已知 $D = {(x,y) | x^2 + y^2 <= 1}$，则 $int.double_D (2x^2 - 3 x y + 4y^2) dif x dif y =$

  #options(
    columns: 3,
    $pi$,
    $2pi$,
    $3pi$,
    $3 / 2 pi$,
    [若其他选项都没选，则选此项],
  )
]

#prob[
  已知 $f(x,y)$ 在 $RR$ 上具有连续偏导数，且 $f(1,1) =1$，$f'_x (1,1) = 1$，$f'_y (1,1) = 2$，记 $phi(x) = f(x,f(x, x^2))$，则 $phi' (1) =$

  #options(
    columns: 3,
    $5$,
    $7$,
    $9$,
    $11$,
    [若其他选项都没选，则选此项],
  )
]

#pagebreak()
#prob[
  设 $f(x,y) = display(cases(
		display((x y)/sqrt(x^2 + y^2)quad &(x,y)!= (0,0)),
		0 quad& (x,y) = (0,0)
	))$，则下列陈述正确的是

  #options(
    [函数 $f(x,y)$ 在点 $(0,0)$ 处可微],
    [函数 $f(x,y)$ 在点 $(0,0)$ 处偏导数存在但不可微],
    [函数 $f(x,y)$ 在点 $(0,0)$ 处连续且偏导数存在],
    [函数 $f(x,y)$ 在点 $(0,0)$ 处沿任何方向的方向导数均存在],
    [若其他选项都没选，则选此项],
  )
]

#prob[
  设函数 $z=f(x,y)$ 在 $(1,2)$ 处有一阶连续偏导数，且 $arrow(u) = (3,4)$，$arrow(v) = (4,-3)$ 的方向导数为 $display((diff f)/(diff arrow(u)) = 18)$，$display((diff f)/(diff arrow(v)) = -1)$，则曲面 $Sigma: z = f(x,y)$ 在点 $(1,2,-1)$ 处的切平面为

  #options(
    columns: 3,
    $10x+15y-z-41=0$,
    $18+2y-z-23=0$,
    $15x+10y-z-36=0$,
    $69x+75y-25z-244=0$,
    [若其他选项都没选，则选此项],
  )
]

#prob[
  设 $D={(x,y) | 0<=x<=pi,space 0<=y<=pi}$，则：$iint.double_D sin (min{x,y}) dif x dif y =$

  #options(
    columns: 3,
    $pi$,
    $2pi$,
    $3pi$,
    $4pi$,
    [若其他选项都没选，则选此项],
  )
]

#pagebreak()
#prob[
  曲线 $C:display(cases(x^2 + y^2 + z^2 = 6, 2z = x y))$ 在点 $(1,2,1)$ 处的切线方程为

  #options(
    $display((x-1)/5 = (y-2)/4 = (z-1)/3)$,
    $display((x-1)/5 = (y-2)/(-4) = (z-1)/3)$,
    $display(cases(x+2y+z=6,x+2y-2z-3=0))$,
    $display(cases(x+2y+z=6,2x-y-2z+2=0))$,
    [若其他选项都没选，则选此项],
  )
]

#prob[
  函数 $u=sqrt(x^2 + 2 y^2 + 3 z^2)$ 在点 $M (-2,1,-1)$ 处的梯度为

  #options(
    $-2i + 2j - 3k$,
    $1 / 3 (-2i + 2j - 3k)$,
    $sqrt(17)$,
    $1 / 3 sqrt(17)$,
    [若其他选项都没选，则选此项],
  )
]