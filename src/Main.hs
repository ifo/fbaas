{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Spock.Safe
import Data.Aeson (object, (.=))
import Data.Monoid ((<>))
import Data.Maybe (fromMaybe)
import Helpers (breakTextByDot)
import System.Environment (lookupEnv)
import qualified FizzBuzz as FB

main :: IO ()
main = do
  maybePort <- lookupEnv "PORT"
  let port = read $ fromMaybe "3000" maybePort

  runSpock port $ spockT id $ do

    get "/" $ redirect "3,Fizz;5,Buzz"

    get ("/" <//> var) $ \ftype -> do
      case breakTextByDot ftype of
        (t, ".json") -> json $ object ["answer" .= FB.fizzerBuzzer t (1, 100)]
        (t, _) -> text $ FB.fizzerBuzzer t (1, 100)
