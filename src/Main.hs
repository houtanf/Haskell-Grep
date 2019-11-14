module Main where

import Reading.Files.GetFiles (getFiles)
import Reading.Files.ReadFiles (fileLines)

import Parsing.ReadUtils (appendName)
import Parsing.Match (matchLines)

import Commands.Arguments ( commandParser, CmdOptions(..) )

import Options.Applicative
import qualified Data.ByteString.Lazy.Char8 as B
import qualified Streaming.Prelude as S

main :: IO ()
main = parseOptions =<< execParser commandParser


parseOptions :: CmdOptions -> IO ()
parseOptions (CmdOption pattern paths recurse _)
  | null paths = undefined
  | otherwise = S.mapM_ (uncurry $ evalFiles pattern) 
                . fileLines 
                . getFiles recurse $ paths
                


evalFiles :: String -> FilePath -> IO [B.ByteString] -> IO ()
evalFiles pattern filename file = file >>= mapM_ B.putStrLn
                                           . appendName filename
                                           . matchLines pattern
                              
            
