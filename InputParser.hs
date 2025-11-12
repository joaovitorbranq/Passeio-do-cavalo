
-- função que checa se um caractere é espaço em branco
import Data.Char (isSpace)


type Pos = (Int, Int)

-- remove espaços à esquerda e à direita (evitando composição/point-free)
trim :: String -> String
trim s = trimDireita (trimEsquerda s)
  where
    trimEsquerda :: String -> String
    trimEsquerda [] = []
    trimEsquerda (cabeca:cauda)
      | isSpace cabeca = trimEsquerda cauda
      | otherwise = cabeca:cauda

    trimDireita :: String -> String
    trimDireita = reverse . trimEsquerda . reverse


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



readLinesFromFile :: FilePath -> IO [(Int, Int, Pos)]
readLinesFromFile file = do
  content <- readFile file
  let ls = map trim (lines content) -- aplica trim e quebra o arquivo em linhas
  let nonEmpty = discardEmptyLines ls
  return (collectCases nonEmpty [])
  where
    discardEmptyLines :: [String] -> [String]
    discardEmptyLines [] = []
    discardEmptyLines (cabeca:cauda)
      | cabeca == ""   = discardEmptyLines cauda --
      | otherwise = cabeca : discardEmptyLines cauda

    collectCases :: [String] -> [(Int,Int,Pos)] -> [(Int,Int,Pos)]
    collectCases [] acc = reverse acc -- caso base. devolve invertido pois adicionamos pelo começo
    collectCases (cabeca:cauda) acc =
      case parseLine cabeca of
        Just c  -> collectCases cauda (c:acc) -- adiciona no inicio da lista acumuladora
        Nothing -> collectCases cauda acc -- faz nada e continua com or resto da lista



-- imprimir em tela:

printResult :: Maybe [Pos] -> IO ()
printResult Nothing     = putStrLn "NAO"
printResult (Just path) = do
  putStrLn "SIM"
  putStrLn (formatKnightPath path)



formatKnightPath :: [Pos] -> String
formatKnightPath xs = go xs True ""
  where
    go :: [Pos] -> Bool -> String -> String
    go [] _ acc = acc
    go ((i,j):rest) first acc =
      let pairStr = "(" ++ show (i+1) ++ "," ++ show (j+1) ++ ")"
          sep = if first then "" else " -> " -- primeiro nao mostra
          acc2 = acc ++ sep ++ pairStr
      in go rest False acc2