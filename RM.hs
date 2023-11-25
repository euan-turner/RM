module RM where

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

execProg :: RM -> Conf 
execProg (RM p regs) = execProg' (0, regs)
  where 
    execProg' :: Conf -> Conf 
    execProg' conf@(l, rs) = case lookup l p of 
      Just i -> if i == Halt then conf else execProg' (execInstr i rs)
      Nothing -> error "ILabel not mapped"

-- function responsible for finding instruction in Prog and passing to executor
-- receives next instruction label