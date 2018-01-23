{-# LANGUAGE OverloadedStrings #-}

module HostConfiguration
  (
    check_fopen
  , check_open
  , check_link
  , check_unlink
  )
where

import System.IO
import Hash

check_fopen :: String -> String -> IO Int
check_fopen fp mode = do
  h <- file2hash "/bin/more"
  putStrLn $ "hash = " ++ (show h)
  putStrLn $ "fp = " ++ fp
  putStrLn $ "mode = " ++ mode
  putChar 'z'
  putChar '\n'
  return 1

check_open :: String -> Int -> Int -> IO Int
check_open fp flags mode = do
  putStrLn $ "fp = " ++ fp
  putStrLn $ "flags = " ++ (show flags)
  putStrLn $ "mode = " ++ (show mode)
  return 1

check_link :: String -> String -> IO Int
check_link oldp newp = do
  putStrLn $ "oldp = " ++ oldp
  putStrLn $ "newp = " ++ newp
  return 1

check_unlink :: String -> IO Int
check_unlink oldp = do
  putStrLn $ "oldp = " ++ oldp
  return 1

