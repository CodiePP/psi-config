{-# LANGUAGE OverloadedStrings #-}

module EvaluationSpec
  (
  spec
  )
where

import Test.Hspec
import qualified Expression as X
import qualified Evaluation as E


spec :: Spec
spec = do
  describe "eval simple integer comparison" $ do

    it "two ints are equal" $ do
      E.eval (X.Ipred ( 42 `X.Ieq` 42 )) `shouldBe` True
      E.eval (X.Ipred ( 42 `X.Ieq` (-42) )) `shouldBe` False

    it "two ints are not equal" $ do
      E.eval (X.Ipred ( 42 `X.Ineq` 42 )) `shouldBe` False
      E.eval (X.Ipred ( 42 `X.Ineq` (-42) )) `shouldBe` True

    it "ints: greater than, greater or equal than" $ do
      E.eval (X.Ipred ( 42 `X.Igt` 42 )) `shouldBe` False
      E.eval (X.Ipred ( 42 `X.Igeq` (-42) )) `shouldBe` True
      E.eval (X.Ipred ( 42 `X.Igeq` 42 )) `shouldBe` True

    it "ints: less than, less or equal than" $ do
      E.eval (X.Ipred ( 42 `X.Ilt` 42 )) `shouldBe` False
      E.eval (X.Ipred ( (-42) `X.Ileq` 42 )) `shouldBe` True
      E.eval (X.Ipred ( 42 `X.Ileq` 42 )) `shouldBe` True

  describe "eval file path comparison" $ do

    it "two file paths are equal" $ do
      E.eval (X.Fpred ( "/data/dir1/dir2/file.ext" `X.FpEq` "/data/dir1/dir2/file.ext" )) `shouldBe` True
      E.eval (X.Fpred ( "/data/dir1/dir2/file.ext" `X.FpEq` "/data/dir0/dir1/file.ext" )) `shouldBe` False
      E.eval (X.Fpred ( "/data/dir1/dir2/file.ext" `X.FpNeq` "/data/dir1/dir2/file.ext" )) `shouldBe` False
      E.eval (X.Fpred ( "/data/dir1/dir2/file.ext" `X.FpNeq` "/data/dir0/dir1/file.ext" )) `shouldBe` True

    it "recognize file extension" $ do
      E.eval (X.Fpred ( "/data/dir1/dir2/file.ext" `X.FpExtIs` "ext" )) `shouldBe` True
      E.eval (X.Fpred ( "/data/dir1/dir2/file.x" `X.FpExtIs` "ext" )) `shouldBe` False

    it "recognize file part" $ do
      E.eval (X.Fpred ( "/data/dir1/dir2/file.ext" `X.FpFileIs` "file.ext" )) `shouldBe` True
      E.eval (X.Fpred ( "/data/dir1/dir2/file.ext" `X.FpFileIs` "somefile.ext" )) `shouldBe` False
      E.eval (X.Fpred ( "/mnt/dir1/dir2/file.x" `X.FpFileIs` "/mnt/dir1/dir2/file.x" )) `shouldBe` True

    it "recognize directory part" $ do
      E.eval (X.Fpred ( "/data/dir1/dir2/file.ext" `X.FpDirIs` "/data/dir1/dir2" )) `shouldBe` True
      E.eval (X.Fpred ( "/mnt/dir1/dir2/file.x" `X.FpDirIs` "/data/dir1/dir2" )) `shouldBe` False

  describe "eval expression with logical AND" $ do

    it "comparing integers" $ do
      E.eval ( X.Ipred ( 42 `X.Ieq` 42 ) `X.Eand` X.Ipred ( 42 `X.Ieq` (-42) )) `shouldBe` False
      E.eval ( X.Ipred ( 42 `X.Ieq` 42 ) `X.Eand` X.Ipred ( 42 `X.Ineq` (-42) )) `shouldBe` True

  describe "eval expression with logical OR" $ do

    it "comparing integers" $ do
      E.eval ( X.Ipred ( 42 `X.Ieq` 42 ) `X.Eor` X.Ipred ( 42 `X.Ieq` (-42) )) `shouldBe` True
      E.eval ( X.Ipred ( 42 `X.Ieq` 42 ) `X.Eor` X.Ipred ( 42 `X.Ineq` (-42) )) `shouldBe` True

  describe "eval negation of expression" $ do

    it "comparing integers" $ do
      E.eval ( X.Enot $ X.Ipred ( 42 `X.Ieq` 42 ) `X.Eor` X.Ipred ( 42 `X.Ieq` (-42) )) `shouldBe` False
      E.eval ( X.Enot $ X.Ipred ( 42 `X.Ieq` 42 ) `X.Eor` X.Ipred ( 42 `X.Ineq` (-42) )) `shouldBe` False

