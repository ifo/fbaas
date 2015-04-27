{-# LANGUAGE OverloadedStrings #-}

module FizzBuzz
  (fizzBuzzer
  )
where

import Prelude hiding (unlines)
import Data.Text (Text, pack, unlines)
import Data.Monoid ((<>))

fizzBuzzer :: (Int, Int) -> Text
fizzBuzzer (x, y) = unlines $ map fizzer [x..y]

fizzer :: Int -> Text
fizzer = tupleAdjust . vFizzer [(3, "Fizz"), (5, "Buzz")]

type Soda = (Int, Text)

tupleAdjust :: (Int, Text) -> Text
tupleAdjust (x,"") = pack $ show x
tupleAdjust (_, t) = t

vFizzer :: [Soda] -> Int -> (Int, Text)
vFizzer ls x = foldl foldFun (x, "") ls
  where
    iter :: Soda -> Int -> Text
    iter (y, t) z
      | mod z y == 0 = t
      | otherwise    = ""

    foldFun :: (Int, Text) -> Soda -> (Int, Text)
    foldFun (y, b) a = (y, b <> iter a y)
