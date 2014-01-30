class Maquina

	def initialize
		@desecho = 0
		@ciclos_procesamiento = 0
		@ciclo_actual = 0
		@estado = 0
		@capacidad = 0
		@insumo_uno = 0
		@insumo_dos = 0
		@porcentaje_uno = 0
		@porcentaje_dos = 0
		@proxima_maquina = nil
		@nombre_maquina = "Default"
		@nombre_insumo_uno = "Default"
		@nombre_insumo_dos = "Default"
	end

	def estado
		@estado
	end

	def procesar
		if @ciclo_actual == 0
			@estado == @estado + 1
		else
			@ciclo_actual = @ciclo_actual - 1
		end
	end

	def imprimir_estado
		puts "Maquina: " + @nombre_maquina + "\n"
		case @estado
		when 0
			@s =  "Inactiva\n"
		when 1
			@s = "Llena\n"
		when 2
			@s = "Procesando\n"
		when 3
			@s = "En espera\n"
		end
		puts "Estado: " + @s
		if @estado  == 0 || @estado == 3
			puts "Insumos:"
			@s = @nombre_insumo_uno + " " + @insumo_uno.to_s
			puts @s
			unless @insumo_dos.nil?
				puts @nombre_insumo_dos + " " + @insumo_dos.to_s
			end
		end
	end

	def ciclo
		self.imprimir_estado
		case @estado
		# Inactiva, cargando insumos
		when 0
			self.cargar_insumo

		# Llena
		when 1
		# Procesando
		when 2
			self.procesar

		# En espera pasar los insumos a la siguiente maquina
		when 3
			self.verificar_proxima_maquina
		end
	end

	def cargar_insumo

	end


	def verificar_proxima_maquina
		if @proxima_maquina.estado == 0
			proxima_maquina.recibir_insumo
			@estado = 0
		end
	end

end
