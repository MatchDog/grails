package matchdog

import java.security.MessageDigest

class LoginController {

    def index() { }

    def create() {
    	def dono = Dono.withCriteria(uniqueResult: true) {
    		eq('email', params.email)
    		eq('password',MessageDigest.getInstance("MD5").digest(params.password.getBytes("UTF-8")).encodeHex().toString())
    	}
    	if (dono) {
    		session['dono_id'] = dono.id
    		if (!dono.dogs){
                redirect(controller: "cadastro",action: "first_dog")
    		}
            else if (dono.dogs.size() == 1){
                redirect(controller: "dogs",action: "show", id: dono.dogs.first().id)
            }
            else{
                redirect(controller: "dogs",action: "index")    
            }
    	} else {
    		flash.error = "Login ou Senha Inválidos"
			redirect(controller: "login",action: "index")
    	}
    }

    def destroy() {
        session.invalidate()
        flash.info = "Você saiu"
        redirect(controller: "login",action: "index")
    }
    
}
