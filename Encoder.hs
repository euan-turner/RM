module Encoder where

import RM (Instr(..), Prog)

-- <x, y>
encPair1 :: Integral a => a -> a -> a 
encPair1 x y = encPair2 x y - 1

-- <<x, y>>
encPair2 :: Integral a => a -> a -> a 
encPair2 x y = (2 ^ x) * (2 * y + 1)

encList :: Integral a => [a] -> a 
encList = foldr encPair2 0

encInstr :: Instr -> Integer
encInstr (Inc i j) = fromIntegral (encPair2 (2 * i) j)
encInstr (Dec i j k) = fromIntegral (encPair2 (2 * i + 1) (encPair1 j k))
encInstr Halt = 0

encProg :: Prog -> Integer 
encProg = encList . (map (encInstr . snd))