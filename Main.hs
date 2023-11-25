module Main where

import RM
import Data.Maybe ( mapMaybe ) 
import Data.List ( nub )

toProg :: [Instr] -> Prog 
toProg = zip [0..]

-- Finds all registers used and maps them to zero initially
toRM :: Prog -> RM
toRM p = RM p (zip [0..m] (repeat 0))
  where 
    m = maximum (mapMaybe (instrReg. snd) p)
    
    instrReg :: Instr -> Maybe RLabel 
    instrReg (Inc r _) = Just r 
    instrReg (Dec r _ _) = Just r 
    instrReg Halt = Nothing

setRMParam :: RM -> RLabel -> Reg -> RM 
setRMParam (RM p rs) r reg = RM p rs' 
  where 
    (_, rs') = updateReg r (\_ -> reg) rs 

add :: Prog 
add = toProg  [ Dec 1 1 2
              , Inc 0 0
              , Dec 2 3 4
              , Inc 0 2
              , Halt
              ]
 
multiply :: Prog 
multiply = toProg [ Dec 1 1 6
                  , Dec 2 2 4
                  , Inc 0 3
                  , Inc 3 1
                  , Dec 3 5 0
                  , Inc 2 4
                  , Halt
                  ]

main :: IO ()
main = do
  let rm = toRM multiply 
  let rm' = setRMParam rm 1 10
  let rm'' = setRMParam rm' 2 11
  print rm''
  print (execProg rm'')
