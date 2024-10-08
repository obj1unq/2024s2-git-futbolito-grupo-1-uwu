/** First Wollok example */
import wollok.game.*
import pgmProgram.*
object lionel {
	var property camiseta = "-titular"
	var property position = game.at(3,5)
	var property image = "lionel-titular.png"

	method retroceder() {
		position = game.at(0.max(position.x() - 1), position.y()) 
	}
	
	method avanzar() {
		position = game.at((game.width() - 1).min(position.x() + 1), position.y()) 
	}

	method inicio() {
		//al apretar la tecla *i* la pelota se debe quedar en el origen borde izquierdo (0,5)
		position = game.at(0, 5)
	}
	
	method buscarla(){
		//al apretar la tecla *b* lionel se mueve a donde está la pelota
		position = pelota.position()
	}

	method patear() {
		self.validarPosicion()
		pelota.avanzar(3)
	}

	method validarPosicion() {
	  if(position != pelota.position()) {
		self.error("No estoy sobre la pelota")
	  }
	}

	method levantarla(){
		//**Levantarla** Hacer que la pelota suba por (eje y) 1 posición, y luego de 2 segundos baje nuevamente a dónde estaba. Tip: Usar un scheduler. Validar que la pelota se encuentre en la misma posicion que Lionel.
		self.validarPosicion()
		self.subirla(1)
		game.schedule(2000, {self.bajarla(1)})
	}

	method subirla(num){
		pelota.subir(1)
	}

	method bajarla(num){
		pelota.bajar(1)
	}

	method taquito() {
		keyboard.t().onPressDo({self.patearTaquito()})
	}
	method patearTaquito() {
		self.validarLionelYPelotaJuntos()
		pelota.retroceder()
	}

	method validarLionelYPelotaJuntos() {
		if (not self.hayColision()) {
			self.error("Lionel no está con la pelota")
		}
	}

	method hayColision() {
      const colisiones = game.colliders(self)
      return not(colisiones.isEmpty())
    }

	method alternarCamiseta() {
		//al apretar la tecla *c* lionel cambia su camiseta
		self.validarCamiseta()
		self.alternarVariableCamiseta()
		self.actualizarImagen()
	}

	method validarCamiseta() {
		if (position.x() != 0) {self.error("no estoy en el borde izquierdo")}
	}

	method alternarVariableCamiseta() {
		if (camiseta == "-titular") {self.camiseta("-suplente")}
		else {self.camiseta("-titular")}
	}

	method actualizarImagen() {
		self.image("lionel" + camiseta + ".png")
	}

} 


object pelota {
	const property image="pelota.png"
	var property position = game.at(5,5)	

	method avanzar(cantidad) {
	   position = game.at((game.width() - 1).min(position.x() + cantidad), 5)
	}

	method inicio() {
		//al apretar la tecla *i* la pelota se debe quedar en el origen borde izquierdo (0,5)
		position = game.at(0, 5)
	}

	method subir(num){
		position = game.at(position.x(), position.y() + num)
	}

	method bajar(num){
		position = game.at(position.x(), position.y() - num)
	}

	method retroceder() {
		position = game.at((position.x() - 2).max(0), position.y())
	}
}
