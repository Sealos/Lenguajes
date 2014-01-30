require './Maquina'

# TCC
class TCC < Maquina
	def initialize
		@desecho = 0.1
		@ciclos_procesamiento = 10
		@estado = 0
		@capacidad = 200
		@porcentaje_uno = 0.99
		@porcentaje_dos = 0.01
	end
end
