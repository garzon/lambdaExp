
czero=lambda f: lambda x: x

succ=lambda y: lambda f: lambda x: f(y(f)(x))

plus=lambda y: lambda z: lambda f: lambda x: y(f)(z(f)(x))

mul=lambda y: lambda z: lambda f: y(z(f))

power=lambda y: lambda z: z(y)

def cnum(num):
	res=czero
	for i in range(num):
		res=succ(res)
	return res

def inc(x):
	return x+1

def printNum(cnum):
	print (cnum(inc))(0)

printNum(plus(cnum(5))(cnum(6)))
printNum(mul(cnum(5))(cnum(6)))
printNum(power(cnum(2))(cnum(10)))