require './Maquina'

# Paila de mezla
class PailaMezcla < Maquina
	def initialize
		@desecho = 0
		@ciclos_procesamiento = 2
		@estado = 0
		@capacidad = 150
		@porcentaje_uno = 0.6
		@porcentaje_dos = 0.4
	end
end
