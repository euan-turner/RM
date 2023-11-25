module Examples where

import RM
    ( RLabel,
      Reg,
      Instr(Halt, Dec, Inc),
      Prog,
      RM(..),
      updateReg,
      toProg,
      toRM )

addP :: Prog 
addP = toProg  [ Dec 1 1 2
              , Inc 0 0
              , Dec 2 3 4
              , Inc 0 2
              , Halt
              ]
 
multP :: Prog 
multP = toProg [ Dec 1 1 6
                  , Dec 2 2 4
                  , Inc 0 3
                  , Inc 3 1
                  , Dec 3 5 0
                  , Inc 2 4
                  , Halt
                  ]

addRM :: Reg -> Reg -> RM 
addRM x y = toRM addP [(1, x), (2, y)]

multRM :: Reg -> Reg -> RM 
multRM x y = toRM multP [(1, x), (2, y)]