{-# LANGUAGE OverloadedStrings #-}

module Hash
    (
      file2hash
    , str2hash
    )
where

import qualified Crypto.Hash.SHA256 as SHA256
import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.Base16 as B16
import System.IO
import Data.Char (toLower)
import Data.Hex (hex)
import Data.String (IsString, fromString)

import qualified Types
import qualified CSupport

data Hash256 = H256 BS.ByteString

instance Eq Hash256 where
  (H256 bs1) == (H256 bs2) = bs1 == bs2

instance Show Hash256 where
  show (H256 bs) = map (toLower) $ hex $ BS.unpack bs

instance IsString Hash256 where
  fromString s = H256 $ fst $ B16.decode $ BS.pack s


file2hash :: Types.Filepath -> IO Hash256
file2hash fp = do
  CSupport.disable_intercept
  fhandle <- openFile (BS.unpack fp) ReadMode
  fhash <- readFromFile fhandle SHA256.init
  --CSupport.enable_intercept
  return $ H256 fhash
  where
    readFromFile :: Handle -> SHA256.Ctx -> IO BS.ByteString
    readFromFile handle context = do
      iseof <- hIsEOF handle
      if iseof
         then return $ SHA256.finalize context
         else do
             bytes <- BS.hGet handle 32768
             readFromFile handle $ SHA256.update context bytes

str2hash :: BS.ByteString -> Hash256
str2hash = H256 . SHA256.hash

