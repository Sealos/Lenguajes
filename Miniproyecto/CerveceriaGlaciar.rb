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
	abort("Faltan argumentos.")
end

numero_ciclos = ARGV[0].to_i
r = Recursos.new(ARGV[1],ARGV[2],ARGV[3],ARGV[4])

tapadora = Tapadora.new
tanquecerveza = TanqueCerveza.new(tapadora)
filtro = Filtro.new(tanquecerveza)
tcc = TCC.new(filtro, r)
enfriador = Enfriador.new(tcc)
tanqueclarificador = TanqueClarificador.new(enfriador)
pailac = PailaCoccion.new(tanqueclarificador, r)
cuba = CubaFiltracion.new(pailac)
pailam = PailaMezcla.new(cuba, r)
molino = Molino.new(pailam)
silo = Silo.new(molino, r)

numero_ciclos.times do |x|
	puts "Inicio Ciclo " + (x + 1).to_s
	silo.ciclo
	molino.ciclo
	pailam.ciclo
	cuba.ciclo
	tanqueclarificador.ciclo
	enfriador.ciclo
	tcc.ciclo
	filtro.ciclo
	tanquecerveza.ciclo
	puts "Fin Ciclo " + (x + 1).to_s, ""
end
r.imprimir_insumos
