require './Maquina'

class Enfriador < Maquina
	def initialize
		@desecho = 0
		@ciclos_procesamiento = 2
		@estado = 0
		@capacidad = 60
		@porcentaje_uno = 1
	end
end
