#!/usr/bin/env python3
""" Script provides variety of functions and examples demonstrating loops, list comprehesnions and set comprehesnions

"""



def hello_1 (x):
    for j in range(x):
        if j % 3 ==0:
            print('hello')
    print('')

hello_1(12)
# range of numbers from 0 to 11. itll print only los q son dividibles por 3.



def hello_2(x):
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')

hello_2(12)


def hello_3(x,y):
    for i in range(x,y):
        print('hello')
    print('')
hello_3(3,17)


def hello_4(x):
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')

hello_4(0)


def hello_5(x):
    while x < 100:
        if x==31:
            for k in range(7):
                print('hello')
        elif x== 18:
            print ('hello')
        x = x+1
    print ('')

hello_5(12)



def hello_6(x,y):
    while x: 
        print("hello!" + str(y))
        y+= 1 
        if y == 6:
            break
    print ('')
hello_6 (True,0)




x = [i for i in range(10)]
print(x)

#estos dos son lo mismo (arriba y abajo)

x = []
for i in range(10):
    x.append(i)
print(x)

rint(x)
#y tambien estos dos son iguales 
x=["LIST","COMPREHENSIONS","ARE","COOL"]
x_new=[]
for i in x:
    x_new.append(i.lower())
print(x_new)

x=[i.lower() for i in ["LIST", "COMPREHENSIONS", "ARE","COOL"]]
print(x)
#y tambien estos dos son iguales 
x=["LIST","COMPREHENSIONS","ARE","COOL"]
x_new=[]
for i in x:
    x_new.append(i.lower())
print(x_new)


#nested loop
matrix=[[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix=[]
#matrix
for row in matrix: #goes thru each row
    for n in row: #goes thru each column
        flattened_matrix.append(n)
print(flattened_matrix)

matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix = [n for row in matrix for n in row]
print(flattened_matrix)


flatten_matrix = [n #append
                  for row in matrix
                  for n in row]


words = ["these", "are", "some", "words"]
first_letters= set()
for w in words:
    first_letters.add(w[0])
print(first_letters)
type(first_letters)


words=["these", "are", "some", "words"]
first_letters = {w[0] for w in words}
print(first_letters)
type(first_letters)
