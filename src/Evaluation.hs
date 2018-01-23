{-# LANGUAGE OverloadedStrings #-}

module Evaluation
where

import Types
import Expression
import qualified Data.ByteString.Char8 as BS


compI :: ComparisonInt -> Bool
compI c = case c of
            Ieq a b -> (a == b)
            Ineq a b -> (a /= b)
            Igeq a b -> (a >= b)
            Ileq a b -> (a <= b)
            Igt a b -> (a > b)
            Ilt a b -> (a < b)

compS :: ComparisonStr -> Bool
compS c = case c of
            Seq a b -> (a == b)
            Sneq a b -> (a /= b)

compF :: ComparisonFp -> Bool
compF c = case c of
            FpEq fp1 fp2 -> (fp1 == fp2)
            FpNeq fp1 fp2 -> (fp1 /= fp2)
            FpStartsWith fp s -> BS.isPrefixOf s fp
            FpEndsWith fp s -> BS.isSuffixOf s fp
            FpDirIs fp d -> (BS.append d "/") `BS.isPrefixOf` fp
            FpFileIs fp f -> BS.isSuffixOf f fp
            FpExtIs fp x -> (BS.append "." x) `BS.isSuffixOf` fp

eval :: Expression -> Bool
eval e = case e of
           Ipred c -> compI c
           Spred c -> compS c
           Fpred c -> compF c
           Eand e1 e2 -> (eval e1) && (eval e2)
           Eor e1 e2 -> (eval e1) || (eval e2)
           Enot e -> not $ eval e

