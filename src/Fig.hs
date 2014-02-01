module Fig where

import Control.Monad
import Language.Haskell.Parser
import Language.Haskell.Pretty
import Language.Haskell.Syntax


getModule :: ParseResult HsModule -> HsModule
getModule (ParseOk x) = x

getDecl :: HsModule -> [HsDecl]
getDecl (HsModule _ _ _ _ ds) = ds

getPair (HsPatBind _ (HsPVar (HsIdent name)) (HsUnGuardedRhs value) _) =
    (name, value)

getFig = getDecl . getModule . parseModule

final = liftM (map (fmap prettyPrint . getPair) . getFig)
            $ readFile "src/example.hs"

display = liftM (unlines . map (\(k, v) -> k ++ " = " ++ v)) final
            >>= putStrLn

