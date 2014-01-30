require './Maquina'

# Tanque pre-clarificador
class TanqueClarificador < Maquina
	def initialize(prox)
		@desecho = 0.01
		@ciclos_procesamiento = 1
		@estado = 0
		@capacidad = 35
		@porcentaje_uno = 1
		@nombre_maquina = "Tanque Pre-Clarificador"
		@nombre_insumo_uno = "Producto Maquina Anterior"
		@insumo_uno = 0
		@proxima_maquina = prox
		@almacen = 0
	end
end
