num = int(input("Enter Num : "))

print("Square Star Pattern") 

for i in range(num):
    Y = ''
    for j in range(num):
        if j == 0 or j == num-1 or i == j:
            Y += 'X '
        else:
            Y += 'O '
    print(Y)