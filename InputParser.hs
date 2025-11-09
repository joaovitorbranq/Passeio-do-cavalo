

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
readIntSafe :: String -> Maybe Int
readIntSafe w =
  case reads w of
    [(x, "")] -> Just x
    _         -> Nothing