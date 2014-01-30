require './Maquina'

# Paila de mezla
class PailaMezcla < Maquina
	def initialize(prox, recursos)
		@desecho = 0
		@ciclos_procesamiento = 2
		@estado = 0
		@capacidad = 150
		@porcentaje_uno = 0.6
		@porcentaje_dos = 0.4
		@nombre_maquina = "Paila de Mezcla"
		@nombre_insumo_uno = "Producto Maquina Anterior"
		@insumo_uno = 0
		@nombre_insumo_dos = "Mezcla de Arroz/Maiz"
		@insumo_dos = 0
		@proxima_maquina = prox
		@recursos = recursos
	end
end
