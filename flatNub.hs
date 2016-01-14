member :: Eq t => [t] -> [[t]] -> Bool
member y (x:xs)
  | y == []   = False
  | y == x    = True
  | otherwise = member y xs

--flatNub (x:xs) = [y ++ x | x]
