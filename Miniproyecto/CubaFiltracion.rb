require './Maquina'

# Cuba de filtracion
class CubaFiltracion < Maquina
	def initialize(prox)
		@desecho = 0.35
		@ciclos_procesamiento = 2
		@estado = 0
		@capacidad = 135
		@porcentaje_uno = 1
		@nombre_maquina = "Cuba de Filtracion"
		@nombre_insumo_uno = "Producto Maquina Anterior"
		@insumo_uno = 0
		@proxima_maquina = prox
		@almacen = 0
	end
end
