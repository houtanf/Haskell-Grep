module Parsing.ReadUtils where

import qualified Data.ByteString.Lazy.Char8 as B


appendName :: FilePath -> [B.ByteString] -> [B.ByteString]
appendName name = map label
                  where label = B.append id
                        id = B.pack $ "\ESC[1m\ESC[45m" ++ name ++ "\ESC[0m:  "

