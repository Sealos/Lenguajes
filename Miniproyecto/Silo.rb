require './Maquina'

# Clase de la maquina Silo
class Silo < Maquina
	# Inicializamos la clase
	def initialize(prox, recursos)
		@desecho = 0
		@ciclos_procesamiento = 0
		@estado = 0
		@capacidad = 400
		@almacen = 0
		@porcentaje_uno = 1
		@nombre_maquina = "Silo de Cebada"
		@nombre_insumo_uno = "Cebada"
		@insumo_uno = 0
		@proxima_maquina = prox
		@recursos = recursos
	end

	# Cargamos la cebada
	def cargar_insumo;
		@insumo_uno = @recursos.enviar_cebada(@capacidad * @porcentaje_uno)
	end
end
