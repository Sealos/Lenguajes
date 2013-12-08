module Main where
import Prelude hiding (init)
import Input
import Euterpea hiding (Event)
import Data.List as List
import Data.Function
import qualified Data.Map as Map


type Modelo = Map.Map [Evento] Int

generarModelo :: [Evento] -> Modelo
generarModelo x = Map.union (generarModeloCero x) (generarModeloUno x)

generarListaModelos :: [[Evento]] -> [Modelo]
generarListaModelos x= map (generarModelo) x

distancia10 :: Int->[String]->[Modelo]->[String]
distancia10 e y x= map (parsearTupla) (take 10 $ sortBy (compare `on` snd) ( zip (zip [0..] (map (drop 6) y)) (map (distancia ((!!) x e)) x)))

parsearTupla :: ((Int,String),Float) -> String
parsearTupla x=   ((((show (fst (fst x)) ++ "  ") ++ "  ") ++ (snd (fst x))) ++ "   ") ++ show (snd x)


--agregar :: Map.Map Evento Int -> Evento -> Map.Map Evento Int
generarModeloCero :: [Evento] -> Modelo
generarModeloCero x = foldl agregar neutro x
	where
		agregar m e = Map.insertWith (\x y -> y + 1) [e] 1 m
		neutro = Map.fromList [([(0, 0)], length x)]

-- Orden 1
generarModeloUno :: [Evento] -> Modelo
generarModeloUno x = foldl agregar Map.empty lista
	where
		agregar m e = Map.insertWith (\x y -> y + 1) e 1 m
		lista = zipWith (:) x (map (\y -> [y]) (tail x))

-- Da la lista de eventos de la union entre 2 modelos
unionEventos :: Modelo -> Modelo -> [[Evento]]
unionEventos a b = union (Map.keys a) (Map.keys b)

-- Distancia entre modelos
distancia :: Modelo -> Modelo -> Float
distancia a b = sqrt $ fromIntegral $ obtenerValores a b 

obtenerValores :: Modelo -> Modelo -> Int
obtenerValores a b = foldl (+) 0 $ zipWith (\x y-> (y - x)*(y - x)) (map (valor b) eventos) (map (valor a) eventos)
	where
		eventos = unionEventos a b

valor :: Modelo -> [Evento] -> Int
valor m k = if ((fst(head k)) == 0) then 0 else Map.findWithDefault 0 k m

-- Directorio predeterminado
directorio :: String
directorio = "./xml/"

-- Longitud de las secuencias musicales generadas
longitud :: Int
longitud = 50

{-
	Induce un modelo de contexto a partir de la colección musical
	en el directorio por defecto, genera una secuencia musical
	nueva a partir de este modelo, la imprime por pantalla y la
	reproduce.
-}
{-
componer :: IO ()
componer = componer' directorio

componer' :: String -> IO ()
componer' dir = do
	(seqs, filenames) <- loadMusicXmls dir
	-- let modelo = ...
	-- let composicion = ...
	putStrLn $ show composicion
	play $ sequenceToMusic composicion
-}
{-
	Recupera las diez secuencias más similares a la k-ésima secuencia
	de la colección musical en el directorio por defecto, donde la
	colección musical ha sido ordenada en orden alfabético por el
	nombre de archivo. Imprime una lista ordenada de las diez
	secuencias más similares. En cada fila de la lista se debe indicar
	el número de la secuencia (relativo al orden alfabético de la
	colección), el nombre de archivo y la distancia a la consulta.
-}
{-
buscar :: Int -> IO ()
buscar = buscar' directorio
  
buscar' :: String -> Int -> IO ()
buscar' dir n = do
  seqfns <- loadMusicXmls dir
  let (seqs, filenames) = unzip $ sortBy (compare `on` snd) $ (uncurry zip) seqfns
  if (n > 0) && (n <= length seqs) then
    -- ...
    else
      putStrLn "Indice fuera de rango"-}

tocar :: Int -> IO ()
tocar n = do
	seqfns <- loadMusicXmls directorio
	let (seqs, filenames) = unzip $ sortBy (compare `on` snd) $ (uncurry zip) seqfns
	if (n > 0) && (n <= length seqs) then
		putStrLn (filenames !! (n-1)) >>
		play (sequenceToMusic (seqs !! (n-1)))
	else
		putStrLn "Indice fuera de rango"

eventToNote :: Evento -> Music Note1
eventToNote e = note
	where
	d = (fromIntegral $ snd e) / 16
	p = Euterpea.pitch $ fst e
	note = Prim (Note d (p,[]))

sequenceToMusic :: [Evento] -> Music Note1
sequenceToMusic es = line $ map eventToNote es

geteventos:: ([[Evento]], [String]) -> [[Evento]]
geteventos (a, _) = a

main = do
	a <- loadMusicXmls directorio
	let b = fst a
	let c = head b
	let d = head (tail b)
	let x= generarListaModelos b
	let y= snd a
	--putStrLn $ show a
	putStrLn $ show "Modelo 1"
	putStrLn $ show (generarModelo c)
	putStrLn $ show "Modelo 2"
	putStrLn $ show (generarModelo d)
	putStrLn $ show "Union de claves"
	putStrLn $ show (unionEventos (generarModelo c) (generarModelo d))
	putStrLn $ show "Distancia"
	putStrLn $ show (distancia (generarModelo c) (generarModelo d))
	putStrLn $ show "Modelo normalizado c"
	putStrLn $ show "Introduzca numero de secuencia a comparar"
	s<-getLine
	putStrLn $ (unlines (distancia10 (read s) y x) )
	putStrLn $ show "Distancias"	
	-- componer
