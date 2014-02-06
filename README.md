This package is designed to allow you to create configuration files
with declarative Haskell and parse the values back into Haskell code.
The benefit here is to have a configuration file in Haskell that does
not have to be recompiled - it is interpreted/parsed at runtime in a 
type-safe manner.

Example usage:

```haskell
-- /path/to/my-config.hs
foo = ["bar", "baz"]
spam = Eggs

-- Application source
import Fig

import Data.Maybe

data Spam = Eggs | Parrot | SomethingEntirelyDifferent
    deriving (Show, Read)

getSpam :: FigMap -> Spam
getSpam = fromMaybe SomethingEntirelyDifferent . readFig "spam"

main = do
    fig <- pickFig "my-config.hs"
    let spam = getSpam fig
    print spam
    let foo = getFoo fig
    print foo
```

