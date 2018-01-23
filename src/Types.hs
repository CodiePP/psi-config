
module Types
where

import qualified Data.ByteString.Char8 as BS

type Filepath = BS.ByteString
type Filename = BS.ByteString
type Fileext = BS.ByteString
type Filemode = BS.ByteString

{-
type Filepath = String
type Filename = String
type Fileext = String
type Filemode = String
-}

