{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Spock.Safe
import Data.Aeson.Types (toJSON)
import Data.Monoid ((<>))
import Helpers (breakTextByDot)
import qualified FizzBuzz as FB

main :: IO ()
main =
  runSpock 3000 $ spockT id $ do

    get "/" $ redirect "default"

    get ("/" <//> var) $ \ftype -> do
      case breakTextByDot ftype of
        (_, ".json") -> json $ toJSON
          $ "{\"answer\": \"" <> FB.fizzBuzzer (1, 100) <> "\"}"
        (_, _) -> text $ FB.fizzBuzzer (1, 100)
