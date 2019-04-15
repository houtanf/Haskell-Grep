module Reading.GetFiles (getFiles) where

import System.Directory (doesDirectoryExist,
                         doesFileExist,
                         getDirectoryContents)

type Recursive = Bool


getFiles :: Recursive -> [FilePath] -> IO [FilePath]
getFiles rec paths = concat <$> mapM (checkFiles rec) paths


checkFiles :: Recursive -> FilePath -> IO [FilePath]
checkFiles rec path = do
                     isFile <- doesFileExist path
                     if isFile
                      then return [path]
                      else recurse checkFiles rec path
                   
recurse :: (Recursive -> FilePath -> IO [FilePath]) -> Recursive -> FilePath -> IO [FilePath]
recurse func rec path = do
                         dir <- retrieve path
                         if rec
                          then concat <$> mapM (func rec) dir 
                          else getFile dir
                   

retrieve :: FilePath -> IO [FilePath]
retrieve = getDir (`notElem` [".", ".."])


getDir :: (FilePath -> Bool) -> FilePath -> IO [FilePath]
getDir func path = filter func <$> getDirectoryContents path


getFile :: [FilePath] -> IO [FilePath]
getFile paths = mapM doesFileExist paths
                >>= return . map fst . filter snd . zip paths
