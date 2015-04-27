{-# LANGUAGE OverloadedStrings #-}

module FizzBuzz
  (fizzBuzzer
  )
where

import Prelude hiding (unlines)
import Data.Text (Text, pack, unlines)

fizzBuzzer :: (Int, Int) -> Text
fizzBuzzer (x, y) = unlines $ map fizzer [x..y]

fizzer :: Int -> Text
fizzer x
  | mod x 3 == 0 && mod x 5 == 0 = "FizzBuzz"
  | mod x 3 == 0                 = "Fizz"
  | mod x 5 == 0                 = "Buzz"
  | otherwise                    = pack $ show x
