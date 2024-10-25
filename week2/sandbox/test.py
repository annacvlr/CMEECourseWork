

for i in range (x):
    if i > 3:
        print(i)

x=11


my_iterable = [1,2,3]

type(my_iterable)

my_iterator = iter(my_iterable)

type(my_iterator)
next(my_iterator) # same as my_iterator.__next__()
next(my_iterator)
next(my_iterator)
next(my_iterator)


#functions
def foo(x):
    x*= x 
    print(x)
    return (x)

%whos

foo(2)

def foo(x):
    x *= x 
    print(x)
   return x
y= foo(2)

y
type(y)

#conditionals
#if <expr> :
   # <statement>


x=0; y= 2
if x < y : 
    print ('yes')

if x:
    print('yes')

if x==0:
    print('yes')

if y:
    print ('yes')

if y== 2:
    print('yes')

x = True

if x: 
    print ('yes')

if x == True :
    print ('yes')



#variable scope
i= 1
x=0
for i in range (10):
    x+=1
print(i)
print(x)


i = 1
x = 0
def a_function(y):
    x = 0
    for i in range(y):
        x += 1
    return x
a_function(10)
print(i)
print(x)

i = 1
x = 0
def a_function(y):
    x = 0
    for i in range(y):
        x += 1
    return x

%whos

a_function(10)
x


_a_global=10
if _a_global>=5:
    _b_global = _a_global +5 

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)
print("Before calling a_function, outside the function, the value of _b_global is", _b_global)


def a_function():
    _a_global = 4
    if _a_global>=4:
        _b_global = _a_global + 5

    _a_local =3
    
     
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)
    
a_function()

print("After calling a_function, outside the function, the value of _a_global is (still)", _a_global)
print("After calling a_function, outside the function, the value of _b_global is (still)", _b_global)
print("After calling a_function, outside the function, the value of _a_local is ", _a_local)




######
_a_global = 10

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():
    global _a_global
    _a_global = 5
    _a_local = 4
    
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value _a_local is", _a_local)
    
a_function()

print("After calling a_function, outside the function, the value of _a_global now is", _a_global)



def a_function():
    _a_global = 10

    def _a_function2():
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()
    
    print("After calling a_function2, value of _a_global is", _a_global)
    
a_function()

print("The value of a_global in main workspace / namespace now is", _a_global)

def modify_list_1(some_list):
    print('got', some_list)
    some_list = [1,2,3,4]
    print('set to', some_list)

my_list = [1,2,3]
print('before, my_list=',my_list)

modify_list_1(my_list)

print('after, my_list =', my_list)

def modify_list_2(some_list):
    print ('got', some_list)
    some_list = [1,2,3,4]
    print('set to', some_list)
    return some_list

my_list = modify_list_2(my_list)

print('after, my list=', my_list)

#the list changes because i explicitly replaces --- return is important

def modify_list_3 (some_list):
    print('got', some_list)
    some_list.append(4) #modifying the list
    print('changed to', some_list)

my_list = [1,2,3]

print('before, my_list', my_list)

modify_list_3(my_list)

print('after, my list', my_list)