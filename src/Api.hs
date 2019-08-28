{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api (
  TestApi
  )  where

import Data.Text
import Servant
import Data

type TestApi = 
    "test" :> Capture "code" Text :> QueryParam "locale" Text :> Get '[JSON] TestPair

