module Main where

import System.Environment (getArgs)
import System.Environment (withArgs) -- para rodar withArgs ["input.txt"] main no ghci depois de :load Main.hs
import System.Exit (die)
import InputParser (readLinesFromFile, printResult)
import LogicaDoCavalo (gerarMovimentos, movimentoValido, dentroDosLimites)
import PasseioCavalo (passeioCavalo)

main :: IO ()
main = do
  args <- getArgs
  file <- case args of
            [f] -> pure f
            _   -> die ""

  cases <- readLinesFromFile file
  mapM_ run cases -- map para função de IO.
  where
    run (rows, cols, start) = do
      if dentroDosLimites rows cols start
        then do
          let total   = rows * cols
              next    = gerarMovimentos rows cols
              result  = passeioCavalo total next movimentoValido start
          printResult result
        else die "Erro: Posição inicial fora dos limites do tabuleiro."