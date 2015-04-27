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
        (t, ".json") -> json $ toJSON
          $ "{\"answer\": \"" <> FB.fizzerBuzzer t (1, 100) <> "\"}"
        (t, _) -> text $ FB.fizzerBuzzer t (1, 100)
