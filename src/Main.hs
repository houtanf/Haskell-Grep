module Main where

import Reading.GetFiles (getFiles)
import Reading.ReadFiles (fileLines)

import Parsing.ReadUtils (appendName)
import Parsing.Match (matchLines)

import System.Environment (getArgs)
import qualified Data.ByteString.Char8 as B

main :: IO ()
main = do
        (pattern : paths) <- getArgs
        fileNames <- getFiles True paths
        fileData <- fileLines fileNames
        let results = matchLines pattern <$> fileData
        let output = concat $ (uncurry appendName) <$> zip fileNames results
        mapM_ B.putStrLn output
