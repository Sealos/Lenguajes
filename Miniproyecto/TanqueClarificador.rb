require './Maquina'

# Tanque pre-clarificador
class TanqueClarificador < Maquina
	def initialize
		@desecho = 0.01
		@ciclos_procesamiento = 1
		@estado = 0
		@capacidad = 35
		@porcentaje_uno = 1
	end
end
