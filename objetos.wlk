/** First Wollok example */
import wollok.game.*

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
}
