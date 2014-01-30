require './TanqueCerveza'
require './Tapadora'
require './Silo'
require './PailaCoccion'
require './TCC'
require './Enfriador'
require './Molino'
require './CubaFiltracion'
require './Filtro'
require './TanqueClarificador'
require './PailaMezcla'
require './Recursos'

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
total = 0

numero_ciclos.times do |x|
	puts "Inicio Ciclo " + (x + 1).to_s
	silo.ciclo
	molino.ciclo
	pailam.ciclo
	cuba.ciclo
	pailac.ciclo
	tanqueclarificador.ciclo
	enfriador.ciclo
	tcc.ciclo
	filtro.ciclo
	tanquecerveza.ciclo
	tapadora.ciclo
	total += tapadora.resultado
	puts "Fin Ciclo " + (x + 1).to_s, ""
end
puts "Cerveza Total: " + total.to_s
r.imprimir_insumos

