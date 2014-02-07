Conf: Haskell-Style Config Parsing
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
import Data.Conf
import Data.Maybe

data Spam = Eggs | Parrot | SomethingEntirelyDifferent
    deriving (Show, Read)

getSpam :: Conf -> Spam
getSpam = fromMaybe SomethingEntirelyDifferent . getConf "spam"

getFoo :: Conf -> Maybe [Int]
getFoo = getConf "foo"

main = do
    conf <- readConf "/path/to/my-config"
    let spam = getSpam conf
    print spam  -- Output: "Eggs"
    let foo = getFoo conf
    print foo   -- Output: "Nothing"
```

