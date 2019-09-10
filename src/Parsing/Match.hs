module Parsing.Match where

import Text.Regex.Posix ((=~))
import Data.List (foldl')
import qualified Data.ByteString.Lazy.Char8 as B


matchLines :: String -> [B.ByteString] -> [B.ByteString]
matchLines pat = foldr (collect pat) []


collect :: String -> B.ByteString -> [B.ByteString] -> [B.ByteString]
collect pat text lines
  | B.null result = lines
  | otherwise = result : lines
  where result = match pat text False


match :: String -> B.ByteString -> Bool -> B.ByteString
match pat text ok
  | matched = front `B.append` highlight found `B.append` match pat rest True
  | ok = front
  | otherwise = B.empty
  where (front, found, rest) = text =~ pat :: (B.ByteString, B.ByteString, B.ByteString)
        matched = not . B.null $ found


highlight :: B.ByteString -> B.ByteString
highlight text = front `B.append` text `B.append` end
                 where front = B.pack "\ESC[1m\ESC[91m"
                       end = B.pack "\ESC[0m"
