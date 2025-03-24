def solve_for_1(n:int):
    print("n", n)
    if n == 1:
        print("success")
        return "Successfully solved for 1"

    elif (n % 2) == 0:
        print("even number found", n)
        solve_for_1(n/2)
    
    else:
        print("odd number found", n)
        solve_for_1((n * 3) + 1)

result = solve_for_1(3)
print(result)