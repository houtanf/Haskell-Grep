module Reading.ReadFiles where


import qualified Data.ByteString.Char8 as L


fileLines :: [FilePath] -> IO [[L.ByteString]]
fileLines = mapM getLines


getLines :: FilePath -> IO [L.ByteString]
getLines path = L.lines <$> L.readFile path
