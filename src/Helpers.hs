module Helpers
  (breakTextByDot
  ,commas
  ,semicolons
  )
where

import Prelude hiding (break)
import Data.Text (Text, break, split)

breakText :: (Char -> Bool) -> Text -> (Text, Text)
breakText = break

breakTextByDot :: Text -> (Text, Text)
breakTextByDot = breakText (=='.')

commas :: Text -> [Text]
commas = split (==',')

semicolons :: Text -> [Text]
semicolons = split (==';')
