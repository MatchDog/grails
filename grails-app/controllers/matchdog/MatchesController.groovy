package matchdog

class MatchesController {

    def index() {
        
        def matches =  Match.findAll('from Match where dog1_id = :dog_id OR dog2_id = :dog_id AND (DATAHORA_DOG1DESISTIU is null and DATAHORA_DOG2DESISTIU is null)  )', [dog_id: session['dog_id']])
        
        matches.each {
    		switch(session['dog_id']) {
    			case it.dog1.id:
    				it.datahoraDog1Viu = Calendar.instance.time
    				break
    			case it.dog2.id:
    				it.datahoraDog2Viu = Calendar.instance.time
    				break
    		}
    		it.save(flush:true)
    	}

        [matches: matches]

    }

    def naorolamais() { 
    	def m = Match.get(params.id)
    	switch(session['dog_id']) {
    		case m.dog1.id:
    			m.datahoraDog1Desistiu = Calendar.instance.time
    			break
    		case m.dog2.id:
    			m.datahoraDog2Desistiu = Calendar.instance.time
    	}
    	m.save(flush:true)
    	redirect(controller: "matches")
    }

}
