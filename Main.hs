module Main where

import RM ( execRM )
import Examples ( addRM, multRM )


main :: IO ()
main = do
  let adder = addRM 10 11 
  let multer = multRM 10 11 
  print (execRM adder)
  print (execRM multer)
