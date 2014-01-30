class Recursos
	def initialize(cebada, lupulo, levadura, arroz)
		@cebada = cebada.to_i
		@lupulo = lupulo.to_i
		@levadura = levadura.to_i
		@arroz = arroz.to_i
	end

	def imprimir_insumos
		puts "Cebada Sobrante: " + @cebada.to_s
		puts "Lupulo Sobrante: " + @lupulo.to_s
		puts "Levadura Sobrante: " + @levadura.to_s
		puts "Mezcla de Arroz/Maiz Sobrante: " + @arroz.to_s
	end

	def enviar_cebada(monto)
		if @cebada > monto
			@cebada = @cebada - monto
			return monto
		else
			monto = @cebada
			@cebada = 0
			return monto
		end
	end

	def enviar_lupulo(monto)
		if @lupulo > monto
			@lupulo = @lupulo - monto
			return monto
		else
			monto = @lupulo
			@lupulo = 0
			return monto
		end
	end

	def enviar_levadura(monto)
		if @levadura > monto
			@levadura = @levadura - monto
			return monto
		else
			monto = @levadura
			@levadura = 0
			return monto
		end
	end

	def enviar_arroz(monto)
		if @arroz > monto
			@arroz = @arroz - monto
			return monto
		else
			monto = @arroz
			@arroz = 0
			return monto
		end
	end
end
