module Main where

import RM
import Examples



main :: IO ()
main = do
  let adder = addRM 10 11 
  let multer = multRM 10 11 
  print (execRM adder)
  print (execRM multer)
