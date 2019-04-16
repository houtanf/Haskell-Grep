module Reading.ReadFiles where


import qualified Data.ByteString.Lazy.Char8 as L


fileLines :: [FilePath] -> [IO [L.ByteString]]
fileLines = map getLines


getLines :: FilePath -> IO [L.ByteString]
getLines path = L.lines <$> L.readFile path
