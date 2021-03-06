# Clase principal, encargada de los ciclos y el manejo de cada maquina
# asi como tambien la interaccion con las otras maquinas
class Maquina
	# Constructor
	def initialize
		@desecho = 0
		@ciclos_procesamiento = 0
		@ciclo_actual = 0
		@estado = 0
		@capacidad = 0
		@almacen = 0
		@insumo_uno = 0
		@insumo_dos = 0
		@porcentaje_uno = 0
		@porcentaje_dos = 0
		@proxima_maquina = nil
		@nombre_maquina = "Default"
		@nombre_insumo_uno = "Default"
		@nombre_insumo_dos = "Default"
	end

	# Getter del estado de la maquina
	def estado
		@estado
	end

	# Simula un ciclo de procesamiento
	def procesar
		if @ciclo_actual == 0
			# Si esta aqui, almacen = 0
			@almacen = @insumo_uno
			unless @nombre_insumo_dos.nil?
				@almacen += @insumo_dos
			end
			# Le restamos el descho
			@almacen = @almacen * (1 - @desecho)
			#puts "--- Termine de procesar, genere " + @almacen.to_s
			@insumo_uno = 0
			@insumo_dos = 0
			@estado = @estado + 1
		else
			@ciclo_actual = @ciclo_actual - 1
		end
	end

	# Imprime el reporte de la maquina
	def imprimir_estado
		puts "\tMaquina: " + @nombre_maquina + "\n"
		case @estado
		when 0
			@s =  "Inactiva"
		when 1
			@s = "Llena"
		when 2
			@s = "Procesando"
		when 3
			@s = "En espera"
		end
		puts "\t\tEstado: " + @s
		if @estado  == 0 || @estado == 3
			puts "\t\tInsumos:"
			@s = "\t\t\t" + @nombre_insumo_uno + ": " + @insumo_uno.to_s
			puts @s
			unless @nombre_insumo_dos.nil?
				puts "\t\t\t" + @nombre_insumo_dos + ": " + @insumo_dos.to_s
			end
			if @estado == 3
				puts "\t\tProducto almacenado: " + @almacen.to_s
			end
		end
		puts ""
	end

	# Simula el ciclo, y dependiendo del estado de la maquina hace lo
	# siguiente:
	# -0: Carga insumos basicos y espera por los productos de las otras
	# -1: La maquina esta llena, coloca los ciclos de procesamiento al
	#	  predeterminado de la maquina
	# -2: Procesa los insumos
	# -3: Envia los insumos, y si los envio por completo, pasa al estado
	#	  inactivo
	def ciclo
		self.imprimir_estado
		case @estado
		# Inactiva, cargando insumos
		when 0
			suma = @insumo_uno
			unless @insumo_dos.nil?
				suma = suma + @insumo_dos
			end
			if suma == @capacidad
				@estado = 1
			else
				self.cargar_insumo
			end

		# Llena
		when 1
			@estado = 2
			@ciclo_actual = @ciclos_procesamiento
		# Procesando
		when 2
			self.procesar

		# En espera pasar los insumos a la siguiente maquina
		when 3
			self.verificar_proxima_maquina
		end
	end

	# Por las maquinas que no usan insumos
	def cargar_insumo;
		
	end

	# Verifica si la proxima maquina en la cadena esta disponible para
	# recibir los productos
	def verificar_proxima_maquina
		if @proxima_maquina.estado == 0
			#puts "--- Intentando enviar " + @almacen.to_s
			recibido = @proxima_maquina.recibir_insumo(@almacen)
			#puts "--- Envie " + recibido.to_s
			if recibido == @almacen
				@estado = 0
			end
			@almacen = @almacen - recibido
		end
	end

	# Recibe los insumos de la maquina anterior
	def recibir_insumo(cantidad)
		if (@insumo_uno + cantidad) > (@capacidad * @porcentaje_uno)
			temp = @capacidad * @porcentaje_uno - @insumo_uno
			@insumo_uno = @capacidad * @porcentaje_uno
			return temp
		else
			@insumo_uno = @insumo_uno + cantidad
			return cantidad
		end
	end
end
