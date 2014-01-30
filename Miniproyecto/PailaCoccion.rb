require './Maquina'

# Paila de coccion
class PailaCoccion < Maquina
	def initialize(prox, recursos)
		@desecho = 0.1
		@ciclos_procesamiento = 3
		@estado = 0
		@capacidad = 70
		@porcentaje_uno = 0.975
		@porcentaje_dos = 0.025
		@nombre_maquina = "Paila de Coccion"
		@nombre_insumo_uno = "Producto Maquina Anterior"
		@insumo_uno = 0
		@nombre_insumo_dos = "Lupulo"
		@insumo_dos = 0
		@proxima_maquina = prox
		@recursos = recursos
	end
end
