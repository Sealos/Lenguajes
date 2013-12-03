module Main where
import Prelude hiding (init)
import Euterpea
import Input
import Data.Function
import qualified Data.Map as Map

data Modelo = Map

-- Directorio predeterminado
directorio :: String
directorio = "./xml"

-- Longitud de las secuencias musicales generadas
longitud :: Int
longitud = 50

concatAll s = foldr (++) [] s
contador s = map (\x->(head x, length x)) . group . sort $ s
contadorAll s = map contador s

prob0 s [] = []
prob0 s [x] = [(fromIntegral (snd x)) / (fromIntegral s)]
prob0 s (x:xs) = (fromIntegral (snd x)) / (fromIntegral s): prob0 s xs

pares [] = []
pares xs = zip xs (tail xs)

{-
	Induce un modelo de contexto a partir de la colección musical 
	en el directorio por defecto, genera una secuencia musical 
	nueva a partir de este modelo, la imprime por pantalla y la 
	reproduce.
-}
componer :: IO ()
componer = componer' directorio

componer' :: String -> IO ()
componer dir = do
	(seqs, filenames) = loadMusicXmls dir
	-- let modelo = ...
	-- let composicion = ...
	putStrLn $ show composicion
	play $ sequenceToMusic composicion

{-
	Recupera las diez secuencias más similares a la k-ésima secuencia 
	de la colección musical en el directorio por defecto, donde la 
	colección musical ha sido ordenada en orden alfabético por el 
	nombre de archivo. Imprime una lista ordenada de las diez 
	secuencias más similares. En cada fila de la lista se debe indicar 
	el número de la secuencia (relativo al orden alfabético de la 
	colección), el nombre de archivo y la distancia a la consulta.
-}
buscar :: Int -> IO ()
buscar = buscar' directorio

buscar' :: String -> Int -> IO ()
buscar' dir = do
	seqfns <- loadMusicXmls dir
	let seqfns_ordenados = unzip $ sortBy (compare `on` snd) $ zip seqfns
	-- ...

tocar :: Int -> IO ()
tocar n = do
	seqfns <- loadMusicXmls dir
	let (seqs, filenames) = unzip $ sortBy (compare `on` snd) $ zip seqfns
	if (n > 0) && (n <= length seqs) then
		putStrLn (filenames !! (n-1)) >>
		play (sequenceToMusic (seqs !! (n-1)))
	else
		putStrLn "Indice fuera de rango"

eventToNote :: Event -> Music Note1
eventToNote e = note
	where
	d = (fromIntegral $ snd e) / 16
	p = Euterpea.pitch $ fst e
	note = Prim (Note d (p,[]))

sequenceToMusic :: [Evento] -> Music Note1
sequenceToMusic es = line $ map eventToNote es