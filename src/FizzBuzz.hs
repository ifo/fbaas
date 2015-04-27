{-# LANGUAGE OverloadedStrings #-}

module FizzBuzz
  (fizzBuzzer
  ,fizzerBuzzer
  )
where

import Prelude hiding (unlines, null)
import Data.Text (Text, pack, unpack, unlines, null)
import Data.Monoid ((<>))
import Helpers (commas, semicolons)
import Safe (readDef)

fizzerBuzzer :: Text -> (Int, Int) -> Text
fizzerBuzzer t (x, y) = unlines $ map (sodaFizzer pop) [x..y]
  where
    pop = processOptions t

fizzBuzzer :: (Int, Int) -> Text
fizzBuzzer (x, y) = unlines $ map fizzer [x..y]

processOptions :: Text -> [Soda]
processOptions t =
  case generateSoda t of
    [] -> defaultSoda
    pop -> pop

defaultSoda :: [Soda]
defaultSoda = [(3, "Fizz"), (5, "Buzz")]

fizzer :: Int -> Text
fizzer = sodaFizzer defaultSoda

sodaFizzer :: [Soda] -> Int -> Text
sodaFizzer pop = tupleAdjust . vFizzer pop

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

-- given text: "3,Fizz;5,Buzz" it will make [(3, "Fizz"), (5, "Buzz")]
-- if text is garbled, it will return as many pairs as possible
-- e.g. "3,Fizz;5,;7,Bazz" -> [(2, "Fizz"), (7, "Bazz")]
generateSoda :: Text -> [Soda]
generateSoda ls = sodaList . map (makeSoda . commas) $ semicolons ls
  where
    sodaList :: [Maybe Soda] -> [Soda]
    sodaList [] = []
    sodaList (Nothing:pop) = sodaList pop
    sodaList (Just s:pop) = s : sodaList pop

    makeSoda :: [Text] -> Maybe Soda
    makeSoda [] = Nothing
    makeSoda [x] = Nothing
    makeSoda (x:t:_)
      | null t || null x = Nothing
      | num /= 0         = Just (num, t)
      | otherwise        = Nothing
      where
        num :: Int
        num = readDef 0 (unpack x)
