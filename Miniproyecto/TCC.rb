require './Maquina'

# TCC
class TCC < Maquina
	# Constructor
	def initialize(prox, recursos)
		@desecho = 0.1
		@ciclos_procesamiento = 10
		@estado = 0
		@capacidad = 200
		@porcentaje_uno = 0.99
		@porcentaje_dos = 0.01
		@nombre_maquina = "TCC"
		@nombre_insumo_uno = "Producto Maquina Anterior"
		@nombre_insumo_dos = "Levadura"
		@insumo_uno = 0
		@insumo_dos = 0
		@proxima_maquina = prox
		@recursos = recursos
		@almacen = 0
	end

	# Cargamos la levadura necesaria
	def cargar_insumo;
		@insumo_dos = @recursos.enviar_levadura(@capacidad * @porcentaje_dos)
	end
end
