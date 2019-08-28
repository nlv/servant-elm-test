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

deriveBoth defaultOptions ''Test

deriveBoth defaultOptions ''TestPair



-- instance ElmType PetitionId 
-- where
--     toElmType (PetitionId x) = ElmPrimitive EInt _
-- instance ElmType Petition
-- instance ElmType SignerForm
-- instance ElmType Test


-- elmopts = Options { fieldLabelModifier = replace "_" "" }

-- elmOpts :: ElmOptions
-- elmOpts = defElmOptions { urlPrefix = Dynamic }

-- spec :: Spec
-- spec = Spec ["Generated", "Api"]
--             (defElmImports
--             --  : toElmTypeSourceWith    elmopts (Proxy :: Proxy Petition)
--             --  : toElmDecoderSourceWith elmopts (Proxy :: Proxy Petition)
--             --  : toElmTypeSourceWith    elmopts (Proxy :: Proxy SignerForm)
--             --  : toElmDecoderSourceWith elmopts (Proxy :: Proxy SignerForm)
--             --  : toElmEncoderSourceWith elmopts (Proxy :: Proxy SignerForm)
--               : toElmTypeSourceWith    elmopts (Proxy :: Proxy Test)
--              : toElmDecoderSourceWith elmopts (Proxy :: Proxy Test)
--              : generateElmForAPIWith elmOpts  (Proxy :: Proxy TestApi))
--             --  : generateElmForAPIWith elmOpts  (Proxy :: Proxy RestApi))



-- main :: IO ()
-- main = specsToDir [spec] "../client/src"

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
    (Proxy :: Proxy TestApi)
