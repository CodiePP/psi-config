
module Expression
where

import Types
import CCommands


data ComparisonFp =
     FpEq Filepath Filepath
  |  FpNeq Filepath Filepath
  |  FpStartsWith Filepath Filepath
  |  FpEndsWith Filepath Filepath
  |  FpDirIs Filepath Filepath
  |  FpFileIs Filepath Filename
  |  FpExtIs Filepath Fileext
  deriving (Show, Read)

--  |  FpFileModeIs Filepath Filemode
--  |  FpFileOwnerIs Filepath String
--  |  FpFileUIDIs Filepath Int
--  |  FpFileGIDIs Filepath Int

data ComparisonStr =
     Seq String String
  |  Sneq String String
  deriving (Show, Read)

data ComparisonInt =
     Ieq Int Int
  |  Ineq Int Int
  |  Igeq Int Int
  |  Igt Int Int
  |  Ileq Int Int
  |  Ilt Int Int
  deriving (Show, Read)

data Expression =
    Ipred ComparisonInt
  | Spred ComparisonStr
  | Fpred ComparisonFp
  | Eand Expression Expression
  | Eor  Expression Expression
  | Enot Expression
  deriving (Show, Read)


