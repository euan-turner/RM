module RM (
  execRM,
  toProg,
  toRM,
  Prog,
  RM,
  Conf,
  Instr(..)
) where

import Data.Maybe ( mapMaybe ) 

type ILabel = Int 
type RLabel = Int 
type Reg = Integer 
data Instr = Inc RLabel ILabel | Dec RLabel ILabel ILabel | Halt 
  deriving (Show, Eq)
type Prog = [(ILabel, Instr)]
type Regs = [(RLabel, Reg)]
data RM = RM Prog Regs
  deriving (Show)
type Conf = (ILabel, Regs)

updateReg :: RLabel -> (Reg -> Reg) -> Regs -> (Bool, Regs)
updateReg _ _ [] = error "RLabel not mapped"
updateReg r f ((r', v):rs)
  | r == r' = if v' < 0 then (False, (r', v):rs) else (True, (r', v'):rs)
  | otherwise =  (suc, (r', v):rs')
  where 
    v' = f v 
    (suc, rs') = updateReg r f rs

-- function responsible for enacting instr on registers, and returning next ILabel
execInstr :: Instr -> Regs -> Conf
execInstr (Inc r l) rs = (l, rs')
  where 
    (_, rs') = updateReg r succ rs
execInstr (Dec r l l') rs
  | suc       = (l, rs')
  | otherwise = (l', rs')
  where 
    (suc, rs') = updateReg r pred rs
execInstr (Halt) rs = error "exec called on HALT"

execRM :: RM -> Conf 
execRM (RM p regs) = execRM' (0, regs)
  where 
    execRM' :: Conf -> Conf 
    execRM' conf@(l, rs) = case lookup l p of 
      Just i -> if i == Halt then conf else execRM' (execInstr i rs)
      Nothing -> error "ILabel not mapped"

toProg :: [Instr] -> Prog 
toProg = zip [0..]

setRMParam :: RM -> RLabel -> Reg -> RM 
setRMParam (RM p rs) r reg = RM p rs' 
  where 
    (_, rs') = updateReg r (\_ -> reg) rs 

setParam :: Regs -> RLabel -> Reg -> Regs
setParam rs r v = rs' 
  where 
    (_, rs') = updateReg r (\_ -> v) rs

-- Finds all registers used and maps them to zero initially, unless mapped in regs
toRM :: Prog -> Regs -> RM
toRM p params = RM p (foldr (\(r, v) rs -> setParam rs r v) zs params)
  where 
    m = maximum (mapMaybe (instrReg. snd) p)
    zs = zip [0..m] (repeat 0)

    instrReg :: Instr -> Maybe RLabel 
    instrReg (Inc r _) = Just r 
    instrReg (Dec r _ _) = Just r 
    instrReg Halt = Nothing