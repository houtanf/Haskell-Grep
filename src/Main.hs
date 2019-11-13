module Main where

import Reading.GetFiles (getFiles)
import Reading.ReadFiles (fileLines)

import Parsing.ReadUtils (appendName)
import Parsing.Match (matchLines)

import Commands.Arguments (
                            commandParser
                            , spattern
                            , source
                            , recursive
                          )

import Options.Applicative
import qualified Data.ByteString.Lazy.Char8 as B
import qualified Streaming.Prelude as S

main :: IO ()
main = do
        args <- execParser commandParser
        let pattern = spattern args
        let paths = source args
        let recurse = recursive args

        let fileNames = getFiles recurse paths
        let fileData = fileLines fileNames
        S.mapM_ (uncurry $ eval pattern) fileData


eval :: String -> FilePath -> IO [B.ByteString] -> IO ()
eval pattern filename file = do
                              text <- file
                              let result = matchLines pattern text
                              let output = appendName filename result
                              mapM_ B.putStrLn output
            
