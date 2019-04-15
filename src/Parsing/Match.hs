module Parsing.Match (matchLines) where

import Text.Regex.Posix ((=~))
import Data.List (foldl')


matchLines :: String -> [String] -> [String]
matchLines pat = foldr (collect pat) []


collect :: String -> String -> [String] -> [String]
collect pat text lines
  | null result = lines
  | otherwise = result : lines
  where result = match pat text False


match :: String -> String -> Bool -> String
match pat text ok
  | matched = front ++ highlight found ++ match pat rest True
  | ok = front
  | otherwise = ""
  where (front, found, rest) = text =~ pat :: (String, String, String)
        matched = not . null $ found


highlight :: String -> String
highlight text = "\ESC[1m\ESC[91m" ++ text ++ "\ESC[0m"
