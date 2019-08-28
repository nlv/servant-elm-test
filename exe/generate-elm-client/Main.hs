{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TemplateHaskell   #-}

module Main where

import Elm.Derive
import Elm.Module  
import Data.Proxy
import Servant.Elm (Proxy (Proxy), defElmImports, generateElmModuleWith, generateElmForAPIWith, urlPrefix, ElmOptions, defElmOptions, UrlPrefix(..))
import Data
import Data.Text
import Api

-- deriveElmDef defaultOptions ''Test
-- deriveElmDef defaultOptions ''TestPair

deriveElmDef defaultOptions ''TestG
deriveElmDef defaultOptions ''TestPairG

-- deriveBoth defaultOptions ''Test
-- deriveBoth defaultOptions ''TestPair


main :: IO ()
main =
  generateElmModuleWith
    defElmOptions
    [ "Generated"
    , "Api"
    ]
    defElmImports
    "client/src"
    [ DefineElm (Proxy :: Proxy Test)
    , DefineElm (Proxy :: Proxy TestPair)
    ]
    -- [ DefineElm (Proxy :: Proxy (TestG Int String))
    -- , DefineElm (Proxy :: Proxy (TestPairG Int String))
    -- ]
    (Proxy :: Proxy TestApi)
