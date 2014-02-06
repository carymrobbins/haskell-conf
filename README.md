Fig: Haskell-Style Config Parsing
===

This package is designed to allow you to create configuration files
with declarative Haskell and parse the values back into Haskell code.
The benefit here is to have a configuration file in Haskell that does
not have to be recompiled - it is interpreted/parsed at runtime in a 
type-safe manner.

```haskell
-- Example configuration "my-config"
foo = ["bar", "baz"]
spam = Eggs
```

```haskell
-- Example application
import Fig

import Data.Maybe

data Spam = Eggs | Parrot | SomethingEntirelyDifferent
    deriving (Show, Read)

getSpam :: FigMap -> Spam
getSpam = fromMaybe SomethingEntirelyDifferent . readFig "spam"

getFoo :: FigMap -> Maybe [Int]
getFoo = readFig "foo"

main = do
    fig <- pickFig "/path/to/my-config"
    let spam = getSpam fig
    print spam  -- Output: "Eggs"
    let foo = getFoo fig
    print foo   -- Output: "Nothing"
```

