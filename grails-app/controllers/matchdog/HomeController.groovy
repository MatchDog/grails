package matchdog

class HomeController {

    def sessionFactory

    def index(){

        def cSession = sessionFactory.currentSession 

        String query = $/
            select
            d.*
            from DOG d
            inner join DONO dn on dn.id = d.dono_id
            left outer join CURTIDA c on (c.dog_alvo_id = d.id and c.dog_id = :dogAtual_id)
            where dn.id <> :dogAtual_dono_id
            and c.id is null
            and dn.sexo = :faro_sexoDono
            and d.sexo =  :faro_sexoDog
            and d.raca_id =  :faro_raca
            and d.cidade_id =  :faro_cidade
            and (d.interessa_passear = :faro_interessaPassear
                    or
                    d.interessa_cruzar = :faro_interessaCruzar)
        /$

        def alvos = cSession
                .createSQLQuery(query)
                        .addEntity(matchdog.Dog)
                        .setLong('dogAtual_dono_id', session['dono_id'])
                        .setLong('dogAtual_id', session['dog_id'])
                        .setString('faro_sexoDono', session['current_faro'].sexoDono)
                        .setString('faro_sexoDog', session['current_faro'].sexoDog)
                        .setLong('faro_raca', session['current_faro'].raca.id)
                        .setLong('faro_cidade', session['current_faro'].cidade.id)
                        .setBoolean('faro_interessaPassear', session['current_faro'].interessaPassear )
                        .setBoolean('faro_interessaCruzar', session['current_faro'].interessaCruzar )
                        .list()
         
        [alvos : alvos ]
    	//[alvos : Dog.find('from Dog where dono_id != :dono_id', [dono_id: session['dono_id']]) ]
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
    	redirect (controller: "home", action: "index")
    }

    def curtir() {
    	def curtida = new Curtida()
    	curtida.dog = Dog.get(session['dog_id'])
    	curtida.dogAlvo = Dog.get(params.id)
    	curtida.curtiu = params.boolean('curtiu')
    	curtida.save(flush:true)
        
        def deuMatch = false 

    	if (curtida.curtiu) {
    		def curtidaCorrespondente = Curtida.find('from Curtida where dog_id = :dog_alvo and dog_alvo_id  = :dog and curtiu is true', [dog_alvo: curtida.dogAlvo.id, dog: curtida.dog.id])
            
 			if (curtidaCorrespondente) {
 				def m = new Match([dog1: curtida.dog, dog2: curtida.dogAlvo, datahora: Calendar.instance.time])
 				m.save(flush: true)
 				deuMatch = true
 			}   		
    	}

        render(contentType: "application/json") {
           [match: deuMatch]
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
