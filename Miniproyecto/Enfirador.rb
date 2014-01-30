require './Maquina'

class Enfriador < Maquina
	def initialize(prox)
		@desecho = 0
		@ciclos_procesamiento = 2
		@estado = 0
		@capacidad = 60
		@porcentaje_uno = 1
		@nombre_maquina = "Enfriador"
		@nombre_insumo_uno = "Producto Maquina Anterior"
		@insumo_uno = 0
		@proxima_maquina = prox
		@almacen = 0
	end
end
