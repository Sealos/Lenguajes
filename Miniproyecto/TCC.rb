require './Maquina'

# TCC
class TCC < Maquina
	def initialize(prox)
		@desecho = 0.1
		@ciclos_procesamiento = 10
		@estado = 0
		@capacidad = 200
		@porcentaje_uno = 0.99
		@porcentaje_dos = 0.01
		@nombre_maquina = "TCC"
		@nombre_insumo_uno = "Producto Maquina Anterior"
		@nombre_insumo_dos = "Levadura"
		@insumo_uno = 0
		@insumo_dos = 0
		@proxima_maquina = prox
	end
end
