module Reading.GetFiles where

import Control.Monad
import System.FilePath ((</>))
import System.Directory (doesDirectoryExist,
                         doesFileExist,
                         listDirectory)

import Streaming  
import qualified Streaming.Prelude as S
import Streaming.Prelude (each, yield)


type Recursive = Bool


getFiles :: Recursive -> [FilePath] -> Stream (Of FilePath) IO ()
getFiles rec = foldr ((>>) . checkFile rec) (return ())


checkFile :: Recursive -> FilePath -> Stream (Of FilePath) IO ()
checkFile rec path = do
                      isDir <- lift $ doesDirectoryExist path
                      case (isDir, rec) of
                        (False, _) -> yield path
                        (True, True) -> getRecursiveContents path
                        (_, _) -> return ()


getRecursiveContents :: FilePath -> Stream (Of FilePath) IO ()
getRecursiveContents dir = do
                            contents <- lift $ listDirectory dir
                            forM_ contents $ \path -> do
                              let fullPath = dir </> path
                              isDir <- lift $ doesDirectoryExist fullPath
                              if isDir
                                then getRecursiveContents fullPath
                                else yield fullPath
