require './Maquina'

class Molino < Maquina
	def initialize
		@desecho = 0.02
		@ciclos_procesamiento = 1
		@estado = 0
		@capacidad = 100
		@porcentaje_uno = 1
	end
end
