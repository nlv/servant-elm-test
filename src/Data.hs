{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}


module Data (
  TestG(..),
  Test,
  TestPairG(..),
  TestPair
  )  where

import GHC.Generics
import Data.Text
-- import Data.Aeson

data TestG a b = Test { testId :: a, testName :: b} deriving Generic
type Test = TestG Int String
-- instance ToJSON   Test
-- instance FromJSON Test

data TestPairG a b = TestPair { tpTest :: TestG a b, tpInt :: Int } deriving Generic
type TestPair = TestPairG Int String 
-- instance ToJSON   TestPair
-- instance FromJSON TestPair
