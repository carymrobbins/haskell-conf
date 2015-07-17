#!/usr/bin/env runghc

import Control.Arrow
import Data.Function
import Data.List
import Data.Maybe
import System.Environment

title = "Conf"
cabalFileName = "conf.cabal"
outputFileName = "README.md"

header synopsis = unlines
    [ title `applySynopsis` synopsis
    , "==========="
    , ""
    , "Installation"
    , "-----------"
    , "You can install this library from Hackage via `cabal install conf`"
    , ""
    , "Description"
    , "-----------"
    ]

footer = unlines
    [ "Building"
    , "--------"
    , "```bash"
    , "cabal sandbox init  # If you haven't already"
    , "cabal install -j --dependencies-only"
    , "cabal build"
    , "```"
    , ""
    , "Running the Tests"
    , "-----------------"
    , "```bash"
    , "cabal sandbox init  # If you haven't already"
    , "cabal install -j --enable-tests --dependencies-only"
    , "cabal test"
    , "```"
    ]

main = do
    args <- getArgs
    cabal <- readFile cabalFileName
    let synopsis = parseSynopsis cabal
    let readme = unlines [header synopsis, parseBody cabal, footer]
    handleArgs args readme

handleArgs args
    | "--stdout" `elem` args = putStrLn
    | otherwise = writeFile outputFileName

applySynopsis title synopsis  = intercalate ": " . filter (not . null) $ xs
  where
    xs = [title, synopsis]

parseSynopsis =
    lines >>>
    filter ("synopsis:" `isPrefixOf`) >>>
    head >>>
    break (== ':') >>>
    snd >>>
    dropWhile (`elem` [':', ' '])

parseBody =
    lines >>>
    parseDescription >>>
    parseNewlines >>>
    parseCode >>>
    unlines

parseDescription =
    dropWhile (/= "description:") >>>
    drop 1 >>>
    takeWhile ((== " ") . take 1) >>>
    map (dropWhile ((== ' ')))

parseNewlines = map f
  where
    f "." = ""
    f x = x

parseCode :: [String] -> [String]
parseCode =
    groupBy ((==) `on` take 1) >>>
    map applyCodeBlocks >>>
    concat

applyCodeBlocks :: [String] -> [String]
applyCodeBlocks xs
    | isCode xs = [ "```haskell" ] ++ map (drop 2) xs ++ [ "```" ]
    | otherwise = xs

isCode :: [String] -> Bool
isCode xs = (take 1 xs >>= take 1) == ">"
