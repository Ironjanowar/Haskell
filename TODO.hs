putTodo :: (Int, String) -> IO()
putTodo (n, todo) = putStrLn (show n ++ ": " ++ todo)

prompt :: [String] -> IO()
prompt todos = do
