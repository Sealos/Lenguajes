class Recursos
	def initialize(cebada, lupulo, levadura, arroz)
		@cebada = cebada
		@lupulo = lupulo
		@levadura = levadura
		@arroz = arroz
	end

	def imprimir_insumos
		puts "Cebada Sobrante: " + @cebada
		puts "Lupulo Sobrante: " + @lupulo
		puts "Levadura Sobrante: " + @levadura
		puts "Mezcla Arroz Maiz Sobrante: " + @arroz
	end

	def enviar_cebada(monto)
		if @cebada > monto
			@cebada = @cebada - monto
			return monto
		else
			@cebada = 0
			return cebada
		end
	end

	def enviar_lupulo(monto)
		if @lupulo > monto
			@lupulo = @lupulo - monto
			return monto
		else
			@lupulo = 0
			return lupulo
		end
	end

	def enviar_levadura(monto)
		if @levadura > monto
			@levadura = @levadura - monto
			return monto
		else
			@levadura = 0
			return levadura
		end
	end

	def enviar_arroz(monto)
		if @arroz > monto
			@arroz = @arroz - monto
			return monto
		else
			@arroz = 0
			return arroz
		end
	end
end
