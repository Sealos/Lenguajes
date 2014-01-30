require './Maquina'

# Filtro de Cerveza
class Filtro < Maquina
	def initialize(prox)
		@desecho = 0
		@ciclos_procesamiento = 1
		@estado = 0
		@capacidad = 100
		@porcentaje_uno = 1
		@nombre_maquina = "Filtro de Cerveza"
		@nombre_insumo_uno = "Producto Maquina Anterior"
		@insumo_uno = 0
		@proxima_maquina = prox
		@almacen = 0
	end
end
