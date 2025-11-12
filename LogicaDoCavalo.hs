module LogicaDoCavalo
  ( gerarMovimentos
  , movimentoValido
  , dentroDosLimites
  ) where

import qualified Data.Set as S

deltas =
  [ ( 2,  1), ( 2, -1), (-2,  1), (-2, -1)
  , ( 1,  2), ( 1, -2), (-1,  2), (-1, -2)
  ]

dentroDosLimites :: Int -> Int -> (Int, Int) -> Bool
dentroDosLimites qtdLinhas qtdColunas (i,j) = i >= 0 && i < qtdLinhas && j >= 0 && j < qtdColunas

movimentoValido :: (Int, Int) -> (Int, Int) -> Bool
movimentoValido (x1,y1) (x2,y2) =
  let dx = abs (x1 - x2)
      dy = abs (y1 - y2)
  in (dx == 1 && dy == 2) || (dx == 2 && dy == 1)

gerarMovimentos :: Int -> Int -> (Int, Int) -> [(Int, Int)]
gerarMovimentos qtdLinhas qtdColunas (x,y) = [
  (nx, ny)
  | (dx,dy) <- deltas
  , let (nx,ny) = (x+dx, y+dy)
  , dentroDosLimites qtdLinhas qtdColunas (nx,ny)
  ]