package matchdog

class HomeController {

    def index(){
    	[alvos : Dog.find('from Dog where dono_id != :dono_id', [dono_id: session['dono_id']]) ]
    }

    def farejar(){
    	def faro = new Faro(faroParams(params))
        faro.datahora = Calendar.instance.time
    	faro.dog = Dog.get(session['dog_id'])
    	if(faro.save(flush: true)){
            session['current_faro'] = faro
        }else{
            faro.errors.allErrors.each { println it }
        }
    	redirect(uri:"/")
    }

    def curtir() {
    	def curtida = new Curtida()
    	curtida.dog = Dog.get(session['dono_id'])
    	curtida.dogAlvo = Dog.get(params.id)
    	curtida.curtiu = params.boolean('curtiu')
    	curtida.save(flush:true)

    	def deumatch = false
        
    	if (curtida.curtiu) {
    		def curtidaCorrespondente = Curtida.find('from Curtida where dog_id = :dog_alvo and dog_alvo_id  = :dog and curtiu is true', [dog_alvo: session['dog_id'], dog: curtida.dog.id])
            
 			if (curtidaCorrespondente) {
 				deumatch = true
 				def m = new Match([dog1: curtidaCorrespondente.dogAlvo,dog2: curtida.dog, datahora: Calendar.instance.time])
 				m.save(flush: true)
 				flash.message = "MATCH!!!"
				flash.args = ["error"]
 			}   		
    	}
        render(contentType: "application/json") {
           [head: "No Content"]
        }
    }

    private faroParams(params){
        [
            sexoDono: params.sexoDono,
            sexoDog: params.sexoDog,
            raca: Raca.get(params.raca),
            cidade: Cidade.get(params.cidade),
            interessaCruzar: params.interessaCruzar? true: false,
            interessaPassear: params.interessaPassear? true: false
        ]
    }

}
