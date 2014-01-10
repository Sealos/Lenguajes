module Main where
import Prelude hiding (init)
import Input
import Euterpea hiding (Event)
import Data.List as List
import Data.Function
import qualified Data.Map as Map
import System.Random

type Modelo = Map.Map [Evento] Int
type ModeloD = Map.Map [Evento] Float

{-
	Genera un modelo de contexto partiendo de una secuencia
	@param Secuencia
	@return Modelo de orden 1 de la secuencia
-}
generarModelo :: [Evento] -> Modelo
generarModelo x = Map.union (generarModeloCero x) (generarModeloUno x)

{-
	Devuelve las 10 distancias mas cercanas a la consulta dada.
	@param Consulta
	@param Lista de nombres de archivos xml
	@param Lista de Modelos
	@return Lista de Strings con formato: nro Secuencia + nombre de archivo + distancia a consulta
-}
distancia10 :: Int -> [String] -> [Modelo] -> [String]
distancia10 e y x= map (parsearTupla) (take 10 $ sortBy (compare `on` snd) ( zip (zip [0..] (map (drop 6) y)) (map (distancia ((!!) x e)) x)))

{-
	Funcion para parsear una tupla y convertirla a String.
	@param Tupla ((nro Secuencia, nombre archivo xml), distancia)
	@return String con formato: nro Secuencia+ nombre archivo xml + distancia
-}
parsearTupla :: ((Int, String), Float) -> String
parsearTupla x = ((((show (fst (fst x)) ++ "  ") ++ "  ") ++ (snd (fst x))) ++ "   ") ++ show (snd x)

{-
	Genera el modelo de orden cero para una secuencia
	@param Secuencia
	@return Modelo orden 0 de la secuencia
-}
generarModeloCero :: [Evento] -> Modelo
generarModeloCero x = foldl agregar neutro x
	where
		agregar m e = Map.insertWith (\x y -> y + 1) [e] 1 m
		neutro = Map.fromList [([(0, 0)], length x)]

{-
	Genera el modelo de orden uno para una secuencia, sin el modelo
	orden cero
	@param Secuencia
	@return Modelo orden 1 de la secuencia sin el modelo orden cero
-}
generarModeloUno :: [Evento] -> Modelo
generarModeloUno x = foldl agregar Map.empty lista
	where
		agregar m e = Map.insertWith (\x y -> y + 1) e 1 m
		lista = zipWith (:) x (map (\y -> [y]) (tail x))

{-
	Da la lista de eventos de la union entre 2 modelos
	@param Modelo 1
	@param Modelo 2
	@return Lista de eventos de union entre 2 modelos
-}
unionEventos :: Modelo -> Modelo -> [[Evento]]
unionEventos a b = union (Map.keys a) (Map.keys b)

{-
	Une dos modelos de contexto sumando los pares
	@param Modelo 1
	@param Modelo 2
	@return Union de Modelo 1 y Modelo 2 tal que el valor guardado de un
	evento es igual a la suma del lookup del evento en ambos modelos
-}
unirModelos :: Modelo -> Modelo -> Modelo
unirModelos a b = Map.unionWith (+) a b

{-
	Devuelve la distancia entre 2 modelos
	@param Modelo 1
	@param Modelo 2
	@return Distancia entre Modelo 1 y Modelo 2
-}
distancia :: Modelo -> Modelo -> Float
distancia a b = sqrt $ fromIntegral $ obtenerValores a b 

{-
	Funcion auxiliar de la distancia
	@param Modelo 1
	@param Modelo 2
	@return Entero de la sumas cuadradas de las frecuencias de cada
	evento
-}
obtenerValores :: Modelo -> Modelo -> Int
obtenerValores a b = foldl (+) 0 $ zipWith (\x y-> (y - x)*(y - x)) (map (valor b) eventos) (map (valor a) eventos)
	where
		eventos = unionEventos a b

{-
	Funcion auxiliar de la distancia, devuelve el valor relativo para
	calcular la distancia entre modelos
	@param Modelo
	@param Evento
	@return Frecuencia del evento cuando evento != (0,0)
-}
valor :: Modelo -> [Evento] -> Int
valor m k = if ((fst(head k)) == 0) then 0 else Map.findWithDefault 0 k m

{-
	Directorio predeterminado
	@return Directorio predeterminado
-}
directorio :: String
directorio = "./xml/"

{-
	Longitud de secuencia generada
	@return Longitud de secuencia generada
-}
longitud :: Int
longitud = 50

{-
	Genera la lista de probabilidad normalizada en base a un evento
	previo
	@param Modelo
	@param Evento previo
	@return Lista de probabilidades
-}
listaProb :: Modelo -> Evento -> [([Evento], Double)]
listaProb m (0,0) = normalizar $ map (\x -> (fst x, calcularProbabilidad m (head(fst x)) (0,0))) lista
	where lista = filter (\x -> (length (fst x) == 1) && (fst x) /= [(0,0)]) $ Map.toList m
listaProb m ev = normalizar $ map (\x -> (fst x, calcularProbabilidad m (head (tail(fst x))) ev)) lista
	where lista = filter (\x -> (length (fst x) == 2) && ((head (fst x)) == ev)) $ Map.toList m

{-
	Funcion auxiliar de listaPro, calcula la probabilidad de B|A
	@param Modelo
	@param Evento
	@param Evento previo
	@return Probabilidad B|A
-}
calcularProbabilidad :: Modelo -> Evento -> Evento -> Double
calcularProbabilidad m ev (0,0) = (0.3)*(fromIntegral (Map.findWithDefault 0 [ev] m))/(fromIntegral(Map.findWithDefault 0 [(0,0)] m))
calcularProbabilidad m ev evv = calcularProbabilidad m ev (0,0) + 0.7*(fromIntegral (Map.findWithDefault 0 [evv, ev] m))/(fromIntegral (Map.findWithDefault 0 [evv] m))

{-
	Normaliza una lista a [0..1)
	@param Lista a normalizar
	@return Lista normalizada
-}
normalizar :: [(a, Double)] -> [(a, Double)]
normalizar l = map (\(x, y)-> (x, (y/ modulo l)^2)) l
	where
		modulo l = sqrt (sum (map (\x->(snd x)^2) l))

{-
	Selecciona el evento de una recta de [0..1]
	@param Probabilidad
	@param Lista de probabilidades normalizada
	@return Evento seleccionado
-}
seleccionEvento :: Double -> [([Evento], Double)] -> Evento
seleccionEvento rand [x] = last (fst x)
seleccionEvento rand (x:xs) = if ((rand - (snd x)) > 0) then seleccionEvento (rand - (snd x)) xs else last (fst x)

{-
	Genera la secuencia partiendo de un modelo y una lista de numeros
	aleatorios
	@param Secuencia de numeros aleatorios
	@param Modelo de contexto
	@return Secuencia
-}
generarSecuencia :: [Double] -> Modelo -> [Evento]
generarSecuencia rands m = reverse $ foldl (unirSecuencia m) [] rands

{-
	Funcion auxiliar de generarSecuencia que usa los valores anteriores
	para generar los proximo valores de la secuencia
	@param Modelo de contexto
	@param Lista invertida de la secuencia generada
	@param Probabilidad del evento
	@return Lista de eventos invertida
-}
unirSecuencia :: Modelo -> [Evento] -> Double -> [Evento]
unirSecuencia mod [] rand = (seleccionEvento rand (listaProb mod (0,0))):[]
unirSecuencia mod ev rand = (seleccionEvento rand (listaProb mod (head ev))):ev

{-
	Induce un modelo de contexto a partir de la colección musical
	en el directorio por defecto, genera una secuencia musical
	nueva a partir de este modelo, la imprime por pantalla y la
	reproduce.
-}
componer :: IO ()
componer = componer' directorio
componer' :: String -> IO ()
componer' dir = do
	(seqs, filenames) <- loadMusicXmls directorio
	r <- getStdGen
	let listRandom = take longitud (randoms r :: [Double])
	let modelo = foldl (\x y -> unirModelos x (generarModelo y)) Map.empty seqs
	let composicion = generarSecuencia listRandom modelo
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
	@param Posicion en la lista de secuencias
	@return Imprime las 10 secuencias con menor distancia a la
	seleccionada
-}
buscar :: Int -> IO ()
buscar = buscar' directorio
buscar' :: String -> Int -> IO ()
buscar' dir n = do
	seqfns <- loadMusicXmls dir
	let (seqs, filenames) = unzip $ sortBy (compare `on` snd) $ (uncurry zip) seqfns
	let modelos = map (generarModelo) seqs
	if (n > 0) && (n <= length seqs) then
		putStrLn $ (unlines (distancia10 n filenames modelos)) 
	else
		putStrLn "Indice fuera de rango"

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

{-
	Funcion principal
-}
main :: IO ()
main = componer
