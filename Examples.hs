module Examples where

import RM
    ( toProg,
      toRM,
      Prog,
      RM,
      Instr(..) )
import Gadget 
    ( remapProg
    , Gadget
    , RegMap
    , InstrMap)

-- Programs
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

addRM :: Integer -> Integer -> RM 
addRM x y = toRM addP [(1, x), (2, y)]

multRM :: Integer -> Integer -> RM 
multRM x y = toRM multP [(1, x), (2, y)]

-- Gadgets

-- move R1 to R0
-- params: R1 (source)
-- results: R0 (dest)
-- scratch: none
-- exits: 2 - done
move :: Gadget
move = (moveProg, [], [2])

moveProg :: Prog 
moveProg = toProg instrs 
  where 
    instrs = [  Dec 1 1 2
              , Inc 0 0]

-- copy R1 to R0
-- params: R1 (source)
-- results: R0 (dest)
-- scratch: R2
-- exits: [done]
copy :: Gadget 
copy = (copyProg, [2], [5])

copyProg :: Prog 
copyProg = toProg instrs 
  where 
    instrs =  [ Dec 1 1 3
              , Inc 0 2
              , Inc 2 0
              , Dec 2 4 5
              , Inc 1 3]

-- push R1 to R0
-- params: R1 (head), R0 (tail)
-- results: R0 (head:tail)
-- scratch: R2
-- exits: [done]
-- info: Given R1 = x, R0 = l, R2 = 0,
--       returns R1 = 0, R0 = <<x, l>>, R2 = 0
push :: Gadget 
push = (pushProg, [2], [6])

pushProg :: Prog 
pushProg = toProg instrs 
  where 
    instrs =  [ Inc 2 1
              , Dec 0 2 3
              , Inc 2 0
              , Dec 2 4 5
              , Inc 0 3
              , Dec 1 1 6]

-- pop R1 to R0
-- params: R1 (source)
-- results: R0 (head), R1 (tail)
-- scratch: R2
-- exits: [done, empty]
-- info: If R1 = 0, then returns R0 = 0 in empty
--       If R1 = <<x, l>>, then returns R0 = x, R1 = l in done
pop :: Gadget
pop = (popProg, [2], [8,9]) 

popProg :: Prog 
popProg = toProg instrs 
  where 
    instrs =  [ Dec 0 0 1
              , Dec 1 2 9 -- 9 is empty
              , Inc 1 3
              , Dec 1 4 5
              , Inc 2 3
              , Dec 2 6 3
              , Dec 2 7 8 -- 8 is done
              , Inc 1 5] 