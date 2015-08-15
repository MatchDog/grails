package matchdog

class LatidasController {

    def domatch() {
    	def match = Match.get(params.id)
    	def latidas = Latida.withCriteria {
    		eq 'match', match
            and {
                order('enviadaEm')
            }
    	}
    	def foto_dono1 = match.dog1.dono.foto != null ? match.dog1.dono.foto.url : null
    	def foto_dono2 = match.dog2.dono.foto != null ? match.dog2.dono.foto.url : null
    	Latida.executeUpdate(
    		"update Latida set lida_em = :data " +
    		"where lida_em is null AND para_dog_id = :para AND match_id = :match",
    		[para: session['dog_id'],match: match.id, data: Calendar.instance.time]
    	)  
    	render(contentType: "application/json") {
 		   [match: match,
 		   latidas: latidas,
 		   foto_dono1: foto_dono1,
 		   foto_dono2: foto_dono2
           ]
		}
    }

    def enviar() {
    	def match = Match.get(params.match_id)

    	def latida = new Latida()
    	latida.match = match
    	latida.deDog = Dog.get(session['dog_id'])    	
    	latida.paraDog = (latida.deDog == match.dog1) ? match.dog2 : match.dog1
    	latida.enviadaEm = Calendar.instance.time
    	latida.mensagem = params.mensagem
    	latida.save(flush: true)
        render(contentType: "application/json") {
          [result: 1 ]
        }
    }

}
