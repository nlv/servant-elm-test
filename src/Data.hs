{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}


module Data (
  Test(..),
  TestPair(..)
  )  where

import GHC.Generics
import Data.Text

data Test = Test { testId :: Int, testName :: Text} deriving Generic

data TestPair = TestPair { tpTest :: Test, tpInt :: Int } deriving Generic
