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
-- distancia :: Modelo -> Modelo -> Rational
-- distancia a b = toRational $ sqrt $ foldl + 0 (obtenerValores a b)

obtenerValores :: Modelo -> Modelo -> [Int]
obtenerValores a b = [0]

valor :: Modelo -> [Evento] -> Int
valor m k = if ((fst(head k)) == 0) then 0 else Map.findWithDefault 0 k m

{-
concatAll s = foldr (++) [] s
contador s = map (\x->(head x, length x)) . group . sort $ s
contadorAll s = map contador s

prob0 s [] = []
prob0 s [x] = [(fromIntegral (snd x)) / (fromIntegral s)]
prob0 s (x:xs) = (fromIntegral (snd x)) / (fromIntegral s): prob0 s xs

pares [] = []
pares xs = zip xs (tail xs)
-}

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
buscar' dir = do
seqfns <- loadMusicXmls dir
	let seqfns_ordenados = unzip $ sortBy (compare ‘on‘ snd) $ zip seqfns
	-- ...-}

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
	putStrLn $ show $ head (fst a)
	putStrLn $ show (generarModelo (head(fst a)))
