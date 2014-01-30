require './Maquina'

class Molino < Maquina
	def initialize(prox)
		@desecho = 0.02
		@ciclos_procesamiento = 1
		@estado = 0
		@capacidad = 100
		@porcentaje_uno = 1
		@nombre_maquina = "Molino"
		@nombre_insumo_uno = "Producto Maquina Anterior"
		@insumo_uno = 0
		@proxima_maquina = prox
	end
end
