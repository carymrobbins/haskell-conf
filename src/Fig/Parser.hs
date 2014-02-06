module Fig.Parser where

import Language.Haskell.Parser
import Language.Haskell.Pretty
import Language.Haskell.Syntax

type FigMap = [(String, String)]

getModule :: ParseResult HsModule -> HsModule
getModule (ParseOk x) = x

getDecl :: HsModule -> [HsDecl]
getDecl (HsModule _ _ _ _ ds) = ds

getPair :: HsDecl -> (String, HsExp)
getPair (HsPatBind _ (HsPVar (HsIdent name)) (HsUnGuardedRhs value) _) =
    (name, value)

getFig :: String -> [HsDecl]
getFig = getDecl . getModule . parseModule

parseFig :: String -> FigMap
parseFig = map (fmap prettyPrint . getPair) . getFig

