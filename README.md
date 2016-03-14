###################################

Environment:

Ruby - 2.1.5

###################################

Problem: (Expectation)
 
1. For the solution, we would want you to use Ruby.
2. We are interested in the DESIGN ASPECT of your solution and would like to evaluate your OBJECT ORIENTED PROGRAMMING SKILLS.
3. You may use external libraries or tools for building or testing purposes.
4. Optionally, you may also include a brief explanation of your design and assumptions along with your code.
5. Kindly note that we are NOT expecting a web-based application or a comprehensive UI. Rather, we are expecting a simple, console based application and interested in your source code.
6. Along with solution please mention the steps involved to setup and run your code. Also mention the environment your code is expected to run into(versions etc).
 
==========
 
1 RESTAURANT PUZZLE:
 
Because it is the Internet Age, but also it is a recession, the Comptroller of the town of Jurgensville has decided to publish the prices of every item on every menu of every restaurant in town, all in a single CSV file (Jurgensville is not quite up to date with modern data serialization methods).  In addition, the restaurants of Jurgensville also offer Value Meals, which are groups of several items, at a discounted price.  The Comptroller has also included these Value Meals in the file.  The file's format is:
 
for lines that define a price for a single item:
restaurant ID, price, item label                                    
 
for lines that define the price for a Value Meal (there can be any number of items in a value meal)
restaurant ID, price, item 1 label, item 2 label, ...                
 
All restaurant IDs are integers, all item labels are lower case letters and underscores, and the price is a decimal number.
 
 
Because you are an expert software engineer, you decide to write a program that accepts the town's price file, and a list of item labels that someone wants to eat for dinner, and outputs the restaurant they should go to, and the total price it will cost them.  It is okay to purchase extra items, as long as the total cost is minimized.
 
Here are some sample data sets, program inputs, and the expected result:
 
----------------------------
Data File data.csv
1, 4.00, burger
1, 8.00, tofu_log
2, 5.00, burger
2, 6.50, tofu_log
 
Program Input
> program data.csv burger tofu_log
 
Expected Output
=> 2, 11.5
---------------------------
 
 
----------------------------
Data File data.csv
3, 4.00, chef_salad
3, 8.00, steak_salad_sandwich
4, 5.00, steak_salad_sandwich
4, 2.50, wine_spritzer
 
Program Input
> program data.csv chef_salad wine_spritzer
 
Expected Output
=> nil  (or null or false or something to indicate that no matching restaurant could be found)
---------------------------
 
 
----------------------------
Data File data.csv
5, 4.00, extreme_fajita
5, 8.00, fancy_european_water
6, 5.00, fancy_european_water
6, 6.00, extreme_fajita, jalapeno_poppers, extra_salsa
 
Program Input
> program data.csv fancy_european_water extreme_fajita
 
Expected Output
=> 6, 11.0
---------------------------
 
 
 
Other inputs outputs:
 
#Input CSV file:
 
1, 1, i1
 
1, 2, i2
 
1, 3, i3
 
1, 4, i4
 
1, 4, i2,i3
 
1, 4.5, i1,i2,i3
 
1, 6.5, i1,i3,i4
 
2, 1, i1
 
2, 1.9, i2
 
2, 3, i3
 
2, 4, i4
 
2, 4.25, i2,i3
 
2, 4.75, i1,i2,i3
 
2, 6.55, i1,i3,i4
 
 
 
#Command line arguments and expected results:
 
## i1 => 1,1
 
## i2 => 2,1.9
 
## i2 i3 => 1,4
 
## i1 i4 => 1,5
 
## i2 i4 => 2,5.9
 
## i3 i4 => 1,6.5
 
## i2 i3 i4 => 1,8
 
## i1 i2 i3 i4 => 2,8.45
 
## i1 i2 i2 i2 i3 i3 i3 => 1,12.5
 
## i1 i1 i1 i1 i1 i2 i3 i3 i3 i4 i4  => 1,19.5
 
## i1 i1 i1 i3 i4 i1 i3 i4 i4 i3 i4 i4 i4 i2 i3 i2 i3 i1 i2 i3 i1 i2 i3 i2 i2 => 53
 
 
 
#Second input file:
 
1, 3, i1
 
1, 5, i2
 
1, 7, i3
 
1, 10, i1, i2, x1
 
1, 18, i1, i2, i3, x2
 
1, 10, i2, i3, x3
 
#Test cases for the above
#i1 i2 => 8
 
#i1 i3 i2 i3 i2 i3 i1 i2 => 38
 
#Other Cases:
 
# Unformatted csv (invalid numbers  spaces  empty lines  and standard qa)
 
###################################
 

Output:

Command to run the code: 

1. Open this folder restaurant_puzzle_code_assignment in the terminal and execute the following

ruby process.rb <data_file_name> <arguments>

Eg: ruby process.rb data3.csv fancy_european_water extreme_fajita

###################################

Files:

1. restaurant_finder.rb - Finds the minimum price retaurant
2. restaurant.rb - Defines the restaurant with id, dishes, total price for dishes
3. dish.rb - Describes the dish name and price
4. process.rb - Used to call the restaurant_finder
5. Some input data files - data.csv , data2.csv , data3.csv 
6. Temp file process.csv

###################################

Logic:

1. First check whether the given csv file is a valid csv, if not return "Unformatted CSV"
2. If it is a valid one, collect the matching food items list as hash Eg: {'burger' => [1,1,burger], 'tofu_log' => [2,2,'tofu_log']}
3. Then find all restaurants which has all the ordered food items
4. For those restaurants add the dishes 
5. Find the checkout sum for all the restaurants
6. Get the cheapest restaurant

Note: 

I haven't done the logic for value meal combo's so results will be partial.
I have the logic to find the cheapest restaurant with combo meal - biz intelligence logic

Algorithm to use: Sequential grouping (Need some time to implement this algorithm)

Eg:

test case

needed : i1,i2,i2,i2,i3,i3

restaraunt combos:
i1 - 5
i2 - 5
i3 - 5
i1 i2 - 5
i1 i2 i3 - 4

So basically all combinations with a minimum of 1 i1, 3 i2 and 2 i3 from the combos. Advantage in this method is wouldnt have position duplicates. As in while doing our permutation with input method we will have:
(i1 i2 i3)(i2 i3)(i2)
(i2)(i1 i2 i3)(i2 i3)
(i2 i3)(i2)(i1 i2 i3) and so on for the same combos (i2) (i1 i2 i3) and (i2 i3)

whereas in this method we will have only one result. The position doesn't matter.
so the above n2-1 complexity becomes n+1 


Right now if we have this data

1, 1, i1
1, 2, i2
1, 3, i3
1, 4, i2,i3

and need i2 i3

My code logic will find cheapest of i2 and cheapest of i3 and sum it up, result would be - 5 instead of the combo price - 4



