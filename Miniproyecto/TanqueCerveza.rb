require './Maquina'

# Tanque para cerveza filtrada
class TanqueCerveza < Maquina
	def initialize
		@desecho = 0
		@ciclos_procesamiento = 0
		@estado = 0
		@capacidad = 100
		@porcentaje_uno = 1
	end
end
