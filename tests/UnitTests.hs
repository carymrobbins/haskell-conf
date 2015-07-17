{-# LANGUAGE TemplateHaskell #-}
module Main where

import Test.Framework
import Test.Framework.TH
import Test.Framework.Providers.HUnit
import Test.HUnit hiding (test)

import Data.Conf
import Data.Maybe

myConfig = unlines
    [ "foo = [\"bar\", \"baz\"]"
    , "spam = Eggs"
    ]

data Spam = Eggs | Parrot | SomethingEntirelyDifferent
    deriving (Show, Read, Eq)

getSpam :: Conf -> Spam
getSpam = fromMaybe SomethingEntirelyDifferent . getConf "spam"

getFoo :: Conf -> Maybe Int
getFoo = getConf "foo"

case_example_usage = do
    let conf = parseConf myConfig
    getSpam conf @=? Eggs
    getFoo conf @=? Nothing

main = $(defaultMainGenerator)
