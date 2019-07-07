module Main where

import Reading.GetFiles (getFiles)
import Reading.ReadFiles (fileLines)

import Parsing.ReadUtils (appendName)
import Parsing.Match (matchLines)

import Control.Monad (liftM)
import System.Environment (getArgs)
import qualified Data.ByteString.Lazy.Char8 as B

main :: IO ()
main = do
        (pattern : paths) <- getArgs
        --let fileNames = getFiles True paths
        --fileData <- (liftM fileLines) $ fileNames
        fileNames <- getFiles True paths
        mapM_ putStrLn fileNames
        let fileData = fileLines fileNames
        mapM_ (uncurry $ eval pattern) fileData


eval :: String -> FilePath -> IO [B.ByteString] -> IO ()
eval pattern filename file = do
                              text <- file
                              let result = matchLines pattern text
                              let output = appendName filename $ result
                              mapM_ B.putStrLn output
            
