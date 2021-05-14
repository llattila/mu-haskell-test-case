{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

module OneOfFourSpec where

import Test.Hspec (Spec, expectationFailure, it, shouldBe)
import Definitions
import Test.Validity

spec :: Spec
spec = it "Round trips to and from Protobuf bytestring" $
    forAllValid $ \oneOfFour ->
      case fromByteString (toByteString oneOfFour) of
        Left errorMsg -> expectationFailure $ show errorMsg
        Right oneOfFour' -> oneOfFour' `shouldBe` oneOfFour