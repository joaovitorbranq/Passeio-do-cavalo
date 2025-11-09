

-- função que checa se um caractere é espaço em branco
import Data.Char (isSpace)


type Pos = (Int, Int)

-- remove espaços à esquerda e à direita (evitando composição/point-free)
trim :: String -> String
trim s = trimRight (trimLeft s)
  where
    trimLeft :: String -> String
    trimLeft [] = []
    trimLeft (cabeca:cauda)
      | isSpace cabeca = trimLeft cauda
      | otherwise = cabeca:cauda

    trimRight :: String -> String
    trimRight = reverse . trimLeft . reverse


-- converte string para int de forma segura
strToInt :: String -> Maybe Int
strToInt w =
  case reads w of
    [(x, "")] -> Just x
    _         -> Nothing


-- usa lib 'words' para quebrar linha por espaços
splitWords :: String -> [String]
splitWords = words


-- lê UMA linha no formato:
-- <linhas> <colunas> <linhaInicial> <colunaInicial>
parseLine :: String -> Maybe (Int, Int, Pos)
parseLine s =
  let ws = splitWords s
  in case ws of 
       [a,b,c,d] -> -- exige exatamente 4 itens de splitWords, senão Nothing
         case strToInt a of
           Nothing -> Nothing
           Just rows ->
             case strToInt b of
               Nothing -> Nothing
               Just cols ->
                 case strToInt c of
                   Nothing -> Nothing
                   Just sr ->
                     case strToInt d of
                       Nothing -> Nothing
                       Just sc ->
                         Just (rows, cols, (sr - 1, sc - 1)) -- converte para 0-based para Pos
       _ -> Nothing