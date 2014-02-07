module Data.Conf.Parser (Conf, parseConf) where

import Language.Haskell.Parser
import Language.Haskell.Pretty
import Language.Haskell.Syntax

type Conf = [(String, String)]

getModule :: ParseResult HsModule -> HsModule
getModule (ParseOk x) = x

getDecl :: HsModule -> [HsDecl]
getDecl (HsModule _ _ _ _ ds) = ds

getPair :: HsDecl -> (String, HsExp)
getPair (HsPatBind _ (HsPVar (HsIdent name)) (HsUnGuardedRhs value) _) =
    (name, value)

parseDecls :: String -> [HsDecl]
parseDecls = getDecl . getModule . parseModule

parseConf :: String -> Conf
parseConf = map (fmap prettyPrint . getPair) . parseDecls

