module Reading.ReadFiles where


import qualified Data.ByteString.Lazy.Char8 as L


fileLines :: [FilePath] -> [(FilePath, IO [L.ByteString])]
fileLines paths = zip paths . map getLines $ paths


getLines :: FilePath -> IO [L.ByteString]
getLines path = L.lines <$> L.readFile path
