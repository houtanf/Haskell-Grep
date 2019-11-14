module Reading.Files.ReadFiles where


import qualified Data.ByteString.Lazy.Char8 as L
import qualified Streaming.Prelude as S
import Streaming


fileLines :: Stream (Of FilePath) IO () -> Stream (Of (FilePath, IO [L.ByteString])) IO ()
fileLines paths = S.zip paths . S.map getLines $ paths


getLines :: FilePath -> IO [L.ByteString]
getLines path = L.lines <$> L.readFile path
