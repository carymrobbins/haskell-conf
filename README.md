Conf: Parser for Haskell-based configuration files.
===========

Installation
-----------
You can install this library from Hackage via `cabal install conf`

Description
-----------

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
```

```haskell
-- Application source
import Data.Conf
import Data.Maybe

data Spam = Eggs | Parrot | SomethingEntirelyDifferent
    deriving (Show, Read)

getSpam :: Conf -> Spam
getSpam = fromMaybe SomethingEntirelyDifferent . getConf "spam"

getFoo :: Conf -> Maybe Int
getFoo = getConf "foo"

main = do
    conf <- readConf "my-config.hs"
    print $ getSpam conf -- Output: Eggs
    print $ getFoo conf  -- Output: Nothing
```

Building
--------
```bash
cabal sandbox init  # If you haven't already
cabal install -j --dependencies-only
cabal build
```

Running the Tests
-----------------
```bash
cabal sandbox init  # If you haven't already
cabal install -j --enable-tests --dependencies-only
cabal test
```

