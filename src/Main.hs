module Main where

import Reading.GetFiles (getFiles)
import Reading.ReadFiles (fileLines)

import Parsing.ReadUtils (appendName)
import Parsing.Match (matchLines)

import System.Environment (getArgs)
import qualified Data.ByteString.Lazy.Char8 as B

main :: IO ()
main = do
        (pattern : paths) <- getArgs
        fileNames <- getFiles True paths
        let fileData = zip fileNames $ fileLines fileNames
        mapM_ (uncurry $ eval pattern) fileData


eval :: String -> FilePath -> IO [B.ByteString] -> IO ()
eval pattern filename file = do
                              text <- file
                              let result = matchLines pattern text
                              let output = appendName filename $ result
                              mapM_ B.putStrLn output
            
