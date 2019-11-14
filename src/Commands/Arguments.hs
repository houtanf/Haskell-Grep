module Commands.Arguments where 

import Options.Applicative
import Data.Semigroup ((<>))

data CmdOptions = CmdOption {
    spattern   :: String
  , source    :: [String]
  , recursive :: Bool
  , caps     :: Bool
}


commandParser :: ParserInfo CmdOptions
commandParser = info ( commands <**> helper ) (
                  fullDesc
                  <> progDesc "Print lines that match patterns"
                  <> header "HaskellGrep - A Haskell implementation of Grep"
                )


commands :: Parser CmdOptions
commands = CmdOption
            <$> patternArg
            <*> sourceArg
            <*> recursiveFlag
            <*> characterCaseFlag


patternArg :: Parser String
patternArg = argument str (
              metavar "PATTERN"
             )


sourceArg :: Parser [String]
sourceArg = many $ argument str (
              metavar "FILES/DIRECTORIES..."
            )


recursiveFlag :: Parser Bool
recursiveFlag = switch (
                  long "recursive"
                  <> short 'r'
                  <> help "Recursively search files down a directory tree"
                )


characterCaseFlag :: Parser Bool
characterCaseFlag = switch (
                      long "ignore-case"
                      <> short 'i'
                      <> help "Ignore case when matching pattern"
                    )