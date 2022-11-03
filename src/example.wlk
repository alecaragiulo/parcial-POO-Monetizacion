

class Contenido {
	
	var property titulo
	var property cantidadDeVistas
	var property esContenidoOfensivo = false
	var tags = []
	var property formaDeMonetizacion
	var property precioDeVentaPorDescarga = 5
	var property precioDeVentaPorAlquiler = 1
	
	method formaDeMonetizacion(nuevaMonetizacion) { 
		
		if (!nuevaMonetizacion.sePuedeAplicarA(self))
			self.error("el contenido no soporta esta forma de monetizacion")
			
		formaDeMonetizacion = nuevaMonetizacion
	}
	
	method initialize(){
		
		if (!formaDeMonetizacion.sePuedeAplicarA(self))
			self.error("el contenido no soporta esta forma de monetizacion")
			
	}
	
	method recaudacion() {
		formaDeMonetizacion.generarIngresos(self)	
	}
	
	method esPopular()
	
	method recaudacionMaximaPublicidad()
	
	method precioDeVentaPorDescarga() = precioDeVentaPorDescarga.max(5)  
	
	method precioDeVentaPorAlquiler() = precioDeVentaPorAlquiler.max(1)
	
}

class Video inherits Contenido {
	
	override method esPopular() = cantidadDeVistas > 10000
	
	override method recaudacionMaximaPublicidad() = 10000
	
	method puedeAlquilarse() = true	
}


class Imagen inherits Contenido {
	var property tagsDeModa
	
	override method esPopular() = tags == tagsDeModa // tengo q usar all
	
	override method recaudacionMaximaPublicidad() = 4000
}


object publicidad {
	
	method generarIngresos(contenido) {
		if(!contenido.esContenidoOfensivo()) (((0.05 * contenido.cantidadDeVistas())) + if (contenido.esPopular()) 2000 else 0).min(contenido.recaudacionMaximaPublicidad())
		else 0 
	}
	
	method sePuedeAplicarA(contenido) = !contenido.esContenidoOfensivo()
}


class Donacion {
	var montoADonar
	 
	method generarIngresos(contenido) = montoADonar
	
	method sePuedeAplicarA(contenido) = true
}


class Descarga{
	
	method generarIngresos(contenido) = if (contenido.esPopular()) contenido.cantidadDeVistas() * contenido.precioDeVentaPorDescarga() else 0
	
	method sePuedeAplicarA(contenido) = contenido.esPopular()	
}


class Alquiler { //a mi criterio no vale la pena que herede de Descarga, porque cambia todo, capaz si abstraía un poco mas el generarIngresos de descarga tendria mas valor
	
	method generarIngresos(contenido) = contenido.cantidadDeVistas() * contenido.precioDeVentaPorDescarga()
	
	method sePuedeAplicarA(contenido) = contenido.puedeAlquilarse()
	
}



object usuarios {
	var usuarios = []
	
	method cienUsuariosVerificadosConMayorSaldo() =	usuarios.sortedBy({uno,otro => uno.saldoTotal() > otro.saldoTotal()}).take(100) //medio incompleto pero joga
	
	method cantidadDeSuperUsuarios() = usuarios.count({contenido => contenido.esSuperUsuario()}) //delegar es bien
}

class Usuario {
	var nombre = "user"
	var email 
	var verificado = false
	var contenidoSubido = []
	
	method saldoTotal() = contenidoSubido.sum({contenido => contenido.recaudacion()})
	
	method esSuperUsuario() = contenidoSubido.count({contenido => contenido.esPopular() > 9})
	
	method publicarContenido(contenidoAPublicar) {
		contenidoSubido.add(contenidoAPublicar)
	}
	
}
	
	//const nuevosHabitantes = ejercito.miembros().sortedBy{uno,otro => uno.potencialOfensivo() > otro.potencialOfensivo()}.take(10) 
	



