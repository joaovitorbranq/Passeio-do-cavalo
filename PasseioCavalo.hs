{-# LANGUAGE BangPatterns #-}
module PasseioCavalo
  ( passeioCavalo
  ) where

import qualified Data.Set as S
import Data.List (sortOn)

passeioCavalo
  :: Int
  -> ((Int, Int) -> [(Int, Int)])
  -> ((Int, Int) -> (Int, Int) -> Bool)
  -> (Int, Int)
  -> Maybe [(Int, Int)]
passeioCavalo total nextMoves isClose start =
  dfs S.empty [start]
  where
    -- calcula o numero de movimentos possíveis a partir de v, considerando os visitados.
    -- Recebe um conjunto de posições já visitadas e uma posição v, retorna o número de movimentos possíveis a partir de v que ainda não foram visitados (grau de v).
    degree :: S.Set (Int, Int) -> (Int, Int) -> Int
    degree visited v =
      length (filter (`S.notMember` visited) (nextMoves v)) -- calcula os movimentos possiveis a partir de v e filtra para apenas aqueles que ja nao foram visitados

    -- degree para ordem de warnsdorff superior a 1: como é possivel voltar ao quadrado de origem precisamos marcá-lo como visitado. Não necessário para grau 1 porque esse movimento é impossível pela lógica do cavalo.
    -- degree :: S.Set (Int, Int) -> (Int, Int) -> Int
    -- degree visited v =
    --   let visitedGrau2 = S.insert v visited
    --   in length (filter (`S.notMember` visitedGrau2) (nextMoves v))

    -- ordena caminhos pelo menor grau (considerando visitados)
    orderedNext :: S.Set (Int, Int) -> (Int, Int) -> [(Int, Int)]
    orderedNext visited p =
      let notVisited x = S.notMember x visited -- cria função notVisited que testa se uma posição x ainda não foi visitada para ser usada no filtro embaixo.
          legal = filter notVisited (nextMoves p) -- aplica filter para manter apenas os movimentos de nextMoves p (função que diz os proximos movimentos a partir de uma posicao p) que ainda não foram visitados
      in sortOn (\v -> degree visited v) legal -- ordena os movimentos legais pelo grau (número de movimentos possíveis a partir daquela posição). (\v -> degree visited v): Crie uma função que recebe um valor v e retorna o resultado de degree visited v, usado pelo sortOn para a ordenação

    dfs :: S.Set (Int, Int) -> [(Int, Int)] -> Maybe [(Int, Int)]
    dfs visited caminho =
      let atual = head caminho -- pega a posição atual do caminho
          try [] = Nothing
          try (nxt:rest) =
            case dfs (S.insert atual visited) (nxt:caminho) of
              Just sol -> Just sol
              Nothing  -> try rest
      in
        if S.size visited == total - 1 then
          let first = last caminho
              lastP = atual
          in if not (isClose lastP first)  -- Verifica se o último movimento não fecha o ciclo com a posição inicial
              then Just (reverse caminho) -- necessário botar Just sempre que for Maybe
              else Nothing -- Equivalente a Null em outras linguagens
        else
          try (orderedNext (S.insert atual visited) atual)

