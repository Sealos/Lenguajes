require './Maquina'

# Tanque para cerveza filtrada
class TanqueCerveza < Maquina
	def initialize(prox)
		@desecho = 0
		@ciclos_procesamiento = 0
		@estado = 0
		@capacidad = 100
		@porcentaje_uno = 1
		@nombre_maquina = "Tanques Para Cerveza Filtrada"
		@nombre_insumo_uno = "Producto Maquina Anterior"
		@insumo_uno = 0
		@proxima_maquina = prox
	end
end
