# Elias Magdaleno
# 02/08/2023
#
# Translate 
# int a = 1
# int b = 2
# int d = 3
# int c = a + b + d
li  $3, 1 	        # a --> $3
li  $4, 2 	        # b --> $4
li  $5, 3		# d --> $5
add $6,$3,$4  	# c --> $5
add $7,$6,$5	# 