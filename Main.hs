module Main where

import System.Environment (getArgs)
import System.Environment (withArgs) -- para rodar withArgs ["input.txt"] main no ghci depois de :load Main.hs
import System.Exit (die)
import InputParser (readLinesFromFile, printResult)
import LogicaDoCavalo (gerarMovimentos, movimentoValido)
import KnightSolver (knightTourOpenWith)

main :: IO ()
main = do
  args <- getArgs
  file <- case args of
            [f] -> pure f
            _   -> die "Uso: ./passeio_cavalo <arquivo.txt>"

  cases <- readLinesFromFile file
  mapM_ run cases
  where
    run (rows, cols, start) =
      let total   = rows * cols
          next    = gerarMovimentos rows cols
          result  = knightTourOpenWith total next movimentoValido start
      in printResult result
