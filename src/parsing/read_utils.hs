module ReadUtils where


appendName :: FilePath -> [String] -> [String]
appendName name = map label
                  where label = (++) ("\ESC[1m\ESC[45m" ++ name)

