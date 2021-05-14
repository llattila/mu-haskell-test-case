{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE PolyKinds             #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE TypeOperators         #-}
{-# language TypeApplications      #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}


module Definitions where

import Data.Int
import GHC.Generics (Generic)
import Mu.Schema
import Data.Hashable
import Data.Int
import Mu.Quasi.GRpc
import Mu.Schema
import Mu.Adapter.ProtoBuf
import Proto3.Wire.Decode as DEC
import Proto3.Wire.Encode as ENC
import Data.Text as T
import Data.Time.Clock
import Data.ByteString
import Data.ByteString.Lazy (toStrict)

grpc "TheSchema" id "protofile.proto"

data OneOfFourValue = A T.Text | B Bool | C Int32 | D Double
  deriving (Eq, Show, Generic)

data OneOfFour
    = OneOfFour { unixTime :: Int64, value :: OneOfFourValue }
     deriving (Eq, Show, Generic, ToSchema TheSchema "OneOfFour", FromSchema TheSchema "OneOfFour")

toByteString :: OneOfFour -> ByteString
toByteString oof = toStrict (ENC.toLazyByteString (toProtoViaSchema @_ @_ @TheSchema oof))

fromByteString :: ByteString -> Either ParseError OneOfFour
fromByteString = DEC.parse (fromProtoViaSchema @_ @_ @TheSchema)
