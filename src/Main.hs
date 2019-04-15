module Main where

import Reading.GetFiles (getFiles)
import Reading.ReadFiles (fileLines)

import Parsing.ReadUtils (appendName)
import Parsing.Match (matchLines)

import System.Environment (getArgs)

main :: IO ()
main = do
        (pattern : paths) <- getArgs
        fileNames <- getFiles paths
        fileData <- fileLines fileNames
        let results = appendName
