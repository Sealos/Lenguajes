require './Maquina'

# Llenadora y tapadora
class Tapadora < Maquina
	# Constructor
	def initialize
		@desecho = 0
		@ciclos_procesamiento = 2
		@estado = 0
		@capacidad = 50
		@porcentaje_uno = 1
		@nombre_maquina = "Llenadora y Tapadora"
		@nombre_insumo_uno = "Producto Maquina Anterior"
		@insumo_uno = 0
		@almacen = 0
	end

	# Obtenemos el resultado
	def resultado
		temp = @almacen
		@almacen = 0
		return temp
	end

	# Dado que esta maquina no tiene que esperar por ninguna otra para
	# que reciba su producto, no tiene ciclo de espera
	def procesar
		if @ciclo_actual == 0
			# Si esta aqui, almacen = 0
			@almacen = @insumo_uno
			unless @nombre_insumo_dos.nil?
				@almacen += @insumo_dos
			end
			# Le restamos el descho
			@almacen = @almacen * (1 - @desecho)
			@almacen *= 4
			puts "Cervezas salientes: " + @almacen.to_s
			@insumo_uno = 0
			@insumo_dos = 0
			@estado = 0
		else
			@ciclo_actual = @ciclo_actual - 1
		end
	end
end
