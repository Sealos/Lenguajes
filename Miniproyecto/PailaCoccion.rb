require './Maquina'

# Paila de coccion
class PailaCoccion < Maquina
	def initialize
		@desecho = 0.1
		@ciclos_procesamiento = 3
		@estado = 0
		@capacidad = 70
		@porcentaje_uno = 0.975
		@porcentaje_dos = 0.025
	end
end
