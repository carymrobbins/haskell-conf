module Fig (FigMap, pickFig, readFig) where

import Control.Monad
import Text.Read
import Fig.Parser

readFig :: Read a => String -> FigMap -> Maybe a
readFig key fig = lookup key fig >>= readMaybe

pickFig :: String -> IO [(String, String)]
pickFig = liftM parseFig . readFile

