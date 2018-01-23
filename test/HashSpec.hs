{-# LANGUAGE OverloadedStrings #-}

module HashSpec
  (
  spec
  )
where

import Test.Hspec
import qualified Hash as H


spec :: Spec
spec = do
  describe "direct hash" $ do

    it "compute digest of string" $ do
      (show $ H.str2hash "hello world.") `shouldBe` "7ddb227315f423250fc67f3be69c544628dffe41752af91c50ae0a9c49faeb87"

  describe "file hash" $ do

    it "compute hash on file" $ do
      H.file2hash "/usr/bin/more" `shouldReturn` "e2aa05bc9f64d2c12250939b7f203dfbb79e40850296d38608eaade3f377d4fc"

