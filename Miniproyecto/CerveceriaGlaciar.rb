require './TanqueCerveza'
require './Tapadora'
require './Silo'
require './PailaCoccion'
require './TCC'
require './Enfirador'
require './Molino'
require './CubaFiltracion'
require './Filtro'
require './TanqueClarificador'
require './PailaMezla'
require './Recursos'

ARGV.each do|a|
  puts "Argument: #{a}"
end

unless ARGV.count == 5
	puts "Faltan argumentos."
end

numero_ciclos = ARGV[0].to_i
r = Recursos.new(ARGV[1],ARGV[2],ARGV[3],ARGV[4])

numero_ciclos.times do |x|
	puts "Inicio Ciclo " + (x + 1).to_s
	#procesar
	puts "Fin Ciclo " + (x + 1).to_s
end
