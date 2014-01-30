require './Maquina'

class Silo < Maquina
	def initialize
		@desecho = 0
		@ciclos_procesamiento = 0
		@estado = 0
		@capacidad = 400
		@porcentaje_uno = 1
	end
end
