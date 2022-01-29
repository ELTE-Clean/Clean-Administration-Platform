module test
import StdEnv 

 

/*
1- Given two real numbers decide whether  the sum of the two numbers after the decimal points  of the two numbers is Even or not
assume there is only one number after the decimal point  
Hint : You can use (toInt) function.
*/

 

IsEvenDecimal :: Real Real -> Bool
IsEvenDecimal a b = isEven((toInt(a*10.0 )) rem 10 +(toInt(b*10.0 )) rem 10)



// 2-  Write a function that will take a digit (Int)
// and return the respective word for it (String).
// For example input of 1 should output One; input of 0 should output Zero; input of 5 should output Five.
// Anything that is not the digit (0-9) should output "Not a digit"


addInt :: [Int] -> [Int]
addInt a  = a

subInt :: Int Int -> Int
subInt a b = a - b

