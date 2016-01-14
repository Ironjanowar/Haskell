import Data.Maybe

doubleMe :: Num a => a -> a
doubleMe x = x * 2

doubleUs :: Num a => a -> a -> a
doubleUs x y = doubleMe x + doubleMe y

squareMe :: Num a => a -> a
squareMe x = x ^ 2

elevado :: (Num a, Integral b) => a -> b -> a
elevado x y = x ^ y

doubleSmallNumber :: (Ord a, Num a) => a -> a
doubleSmallNumber x = if x < 100 then
                        x*2
                      else
                        x

holaQueAse :: [Char]
holaQueAse = "Well hello que ase!"

list :: [Integer]
list = [3, 4, 6, 13]

----------------------------------------------------------------------------------

boomBang :: Integral a => [a] -> [[Char]]
boomBang y = [ if x < 10 then
                 "BOOM!"
               else
                 "BANG!"
             | x <- y, odd x]

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

------------------------------------------------------------------------------

lucky :: Integral a => a -> String
lucky 1 = "One"
lucky 2 = "Two"
lucky 3 = "Three"
lucky 4 = "Four"
lucky 5 = "Five"
lucky 6 = "Six"
lucky 7 = "Seven"
lucky 8 = "Eight"
lucky 9 = "Nine"
lucky x = "Doberu eracky"

------------------------------------------------------------------------------

plusplus :: (Integral a) => a -> String
plusplus x = lucky (x+1)

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial x = x * factorial (x - 1)

--sayName :: Char -> String

myLast :: [a] -> a
myLast [] = error "Can't get the last of an empty list"
myLast (x:[]) = x
myLast (_:xs) = myLast xs
                
--myLast monadico (myLast'), devuelve algo o nada. De esta manera evitamos romper la ejecucion del programa con el "error" de myLast
                
myLast' :: [a] -> Maybe a
myLast' [] = Nothing
myLast' (x:[]) = Just x
myLast' (_:xs) = myLast' xs

---------------------------------

myFirst :: [a] -> a 
myFirst [] = error ("[] es una lista vacia")
myFirst (x:_) = x

--------------------------------------------------------------------
                
myButLast :: [a] -> a
myButLast (x:y:[]) = x
myButLast (x:xs) = myButLast xs

--------------------------------------------------------

elementAt ::  Int -> [a] -> a
elementAt y (x:xs) = if y == 1 then
                       x
                     else
                       elementAt (y-1) xs

------------------------------------------------------

max' :: (Ord a) => a -> a -> a
max' x y
  | x < y = y
  | otherwise = x

-----------------------------------------------------

myLength :: [a] -> Int
myLength (x:[]) = 1  --Esta lina podria ser tambien: myLength [] = 0
myLength (x:xs) = 1 + myLength xs

------------------------------------------------------

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

-----------------------------------------------------

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome x = myReverse x == x

----------------------------------------------------

addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

----------------------------------------------------

--On triples

first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

-----------------------------------------------------

startsWith :: Eq a => [a] -> a -> Bool
startsWith x y = head x == y

-----------------------------------------------------

sumTuples :: Num a => [(a, a)] -> [a]
sumTuples [] = []
sumTuples (x:xs) = [y+z | (y,z) <- [x]] ++ sumTuples xs

-----------------------------------------------------

--Remove first list y in xs
removeSubList :: Eq a => a -> [a] -> [a]
removeSubList y (x:xs) = if y == x then
                           xs
                         else
                           [x] ++ removeSubList y xs

-----------------------------------------------------

--Remove all lists y in xs
removeAllSubList :: Eq t => t -> [t] -> [t]
removeAllSubList _ [] = []
removeAllSubList y (x:xs) = if y == x then
                              removeAllSubList y xs
                            else
                              [x] ++ removeAllSubList y xs

-----------------------------------------------------

myFlatten :: [[a]] -> [a]
myFlatten = foldr (++) []

----------------------------------------------------
            
myCompare :: Ord a => a -> a -> Ordering
myCompare a b
  | a > b = GT
  | a == b = EQ
  | otherwise = LT

----------------------------------------------------
                
--4 * (let a = 9 in a + 1) + 2

----------------------------------------------------

funct :: Int -> [a] -> [a]
funct x xs = take (x + 1)  xs ++ drop x xs

----------------------------------------------------

e4 :: (t, t1) -> t
e4 (x, y) = x

---------------------------------------------------

e6 :: Num a => a -> a -> a
e6 x y = x * y

----------------------------------------------------

e9 :: [t] -> (t, Bool)
e9 [x, y] = (x, True)

-----------------------------------------------------

e10 :: (t, t) -> [t]
e10 (x, y) = [x, y]

----------------------------------------------------------

elevaAN :: (Enum t, Integral b, Num t) => b -> [t]
elevaAN n = [x^n | x <- [1..5]]

------------------------------------------------------

coolConcat xss = [x | xs <- xss, x <- xs]

-------------------------------------------------------

myReplicate :: (Eq a, Num a) => a -> t -> [t]
myReplicate 1 x = [x]
myReplicate n x = [x] ++ myReplicate (n-1) x

--------------------------------------------------------

selectFromList :: (Eq a, Num a) => a -> [t] -> [t]
selectFromList 0 (x:xs) = [x]
selectFromList n (x:xs) = selectFromList (n-1) xs

-------------------------------------------------------

isOnList :: Eq a => a -> [a] -> Bool
isOnList y [] = False
isOnList y (x:xs)
  | y == x = True
  | y /= x = isOnList y xs

-------------------------------------------------------

gameOfThrees :: Integral a => a -> a
gameOfThrees n
  | n == 1 = n
  | n `mod` 3 == 0 = gameOfThrees (n `div` 3)
  | otherwise = gameOfThrees (n+1)
