def buggyfunc(x):
    y = x
    for i in range(x):
        try:
            y = y - 1
                    #import ipdb; ipdb.set.track
            z = x/y
        except ZeroDivisionError:
            print(f" The result of dividing a number by zero is undefined")
        except:
            print(f"this didn't work; {x= }; {y = }")
        else:
            print(f"OK; {x =}, {y = }, {z = }")
    return z

buggyfunc(20)
