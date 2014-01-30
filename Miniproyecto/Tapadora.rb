require './Maquina'

# Llenadora y tapadora
class Tapadora < Maquina
	def initialize
		@desecho = 0
		@ciclos_procesamiento = 2
		@estado = 0
		@capacidad = 50
		@porcentaje_uno = 1
	end
end
