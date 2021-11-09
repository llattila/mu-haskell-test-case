module Main where

import Definitions
import Data.Text as T
import Proto3.Wire.Decode (decodeWire)

main :: IO ()
main = do
   areEquals (OneOfFour 1 (A (T.pack "Some string")))
   areEquals (OneOfFour 1 (B False))
   areEquals (OneOfFour 1 (C 1))
   areEquals (OneOfFour 1 (D 1.0))
   print "Different parsings"
   print $ decodeWire $ toByteString (OneOfFour 1 (A (T.pack "Some string")))
   print $ decodeWire $ toByteString (OneOfFour 1 (B False))
   print $ decodeWire $ toByteString (OneOfFour 1 (C 1))
   print $ decodeWire $ toByteString (OneOfFour 1 (D 1.0))


areEquals :: OneOfFour -> IO ()
areEquals oneOfFour =
  case fromByteString $ toByteString oneOfFour of
    Left error -> print $ show error
    Right oof ->
      if oneOfFour /= oof
        then print $ show oneOfFour <> " is different from " <> show oof
        else print $ show oneOfFour <> " is identical"