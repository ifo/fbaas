{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Spock.Safe
import Data.Aeson.Types (toJSON)
import Data.Monoid ((<>))
import qualified Data.Text  as T
import qualified FizzBuzz   as FB

main :: IO ()
main =
  runSpock 3000 $ spockT id $ do

    get "/" $
      json $ toJSON $ "{\"answer\": \"" <> FB.fizzBuzzer (1, 100) <> "\"}"
