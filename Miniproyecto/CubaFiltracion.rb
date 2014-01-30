require './Maquina'

# Cuba de filtracion
class CubaFiltracion < Maquina
	def initialize
		@desecho = 0.35
		@ciclos_procesamiento = 2
		@estado = 0
		@capacidad = 135
		@porcentaje_uno = 1
	end
end
