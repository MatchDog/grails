package matchdog

class DogsController {

    def fileUploadService

    def add() {
    	[cidades: Cidade.getAll() , racas:  Raca.getAll()]
    }

    def create() {
    	def dog = new Dog(dogParams(params))
        dog.raca = Raca.get(params.raca)
        dog.cidade = Cidade.get(params.cidade)
        dog.dono = Dono.get(session['dono_id'])

    	//importar foto
    	if(params.foto) {
    		def file = request.getFile("foto")
    		String fileUpload = fileUploadService.upload(file)
            if (fileUpload){
                def foto = new Foto(url:fileUpload,descricao:"Foto do Perfil")
                foto.save(flush: true)
                dog.foto = foto    
            }
    	}

    	if(dog.save(flush: true)){
            flash.message = "O Dog ${dog.nome} foi Editado com sucesso."
            flash.args = ["notice"]
            session['dog_id'] = dog.id
            session['current_faro'] = createInitialFaro()
        }
        else{
             dog.errors.allErrors.each { println it }
        }
        redirect(controller: "dogs",action: "index")
    }

    def update() {
    	def dog = Dog.get(params.id)
    	dog.properties = dogParams(params)
        dog.raca = Raca.get(params.raca)
        dog.cidade = Cidade.get(params.cidade)

    	if(params.foto) {
    		def file = request.getFile("foto")
    		String fileUpload = fileUploadService.upload(file)
            if (fileUpload) {
                def foto
                if(!dog.foto) {
                    foto = new Foto()
                } else {
                    foto = dog.foto
                }           
                foto.url = fileUpload
                foto.descricao = "Foto do Perfil"
                foto.save(flush: true)
                dog.foto = foto
            }
    	}

    	dog.save(flush:true)
    	flash.message = "${dog.nome} foi Editado com sucesso"
		flash.args = ["notice"]
		redirect(controller: "dogs",action: "index")
    }

    def edit() {
    	[dog: Dog.get(params.id) , cidades: Cidade.getAll() , racas:  Raca.getAll()]
    }

    def destroy() {
    	def dog = Dog.get(params.id)
    	if (dog.dono.id == session['dono_id']) {
    		dog.datahoraExcluido = Calendar.instance.time
    		dog.save(flush: true)
    		session['dog_id'] == null
    		flash.message = "${dog.nome} foi Excluído com sucesso"
			flash.args = ["notice"]
    	}
    	redirect (controller: "dogs", action: "index")
    }
    
    def index() {
    	[dogs: Dog.findAll('from Dog where datahoraExcluido is null and dono_id  = :dono_id', [dono_id: session['dono_id']])]
    }

    def show() {
    	def dog = Dog.get(params.id)
    	if (dog.dono.id == session['dono_id']){
    		session['dog_id'] = dog.id            
            session['current_faro'] = getLastFaro() ?: createInitialFaro()
    		flash.message = "${dog.nome} foi Selecionado com sucesso"
			flash.args = ["notice"]
			redirect (uri: "/")
    	} else {
    		flash.message = "${dognome} não pode ser selecionado"
			flash.args = ["warning"]
    		redirect (controller: "dogs", action: "index")
    	}
    }

    def private dogParams(params) {
    	[
    		nome: params.nome,
            sexo: params.sexo,
    		temPedigree: params.temPedigree,
    		interessaCruzar: params.interessaCruzar,
    		interessaPassear: params.interessaPassear
    	]
    }

    def private createInitialFaro() {
        def current_dog = Dog.get(session['dog_id'])
        def faro = new Faro()
        faro.sexoDono          = current_dog.dono.sexo == 'M' ? 'F' : 'M'
        faro.sexoDog           = current_dog.sexo == 'M' ? 'F' : 'M'
        faro.raca              = current_dog.raca
        faro.cidade            = current_dog.cidade
        faro.interessaPassear  = current_dog.interessaPassear
        faro.interessaCruzar   = current_dog.interessaCruzar
        faro
    }

    def private getLastFaro() {
        def lastFaro =  Faro.find("from Faro where dog_id = :dog_id order by datahora desc", [dog_id: session['dog_id']])
        if (lastFaro){
            def faro = new Faro()
            faro.sexoDono          = lastFaro.sexoDono
            faro.sexoDog           = lastFaro.sexoDog
            faro.raca              = lastFaro.raca
            faro.cidade            = lastFaro.cidade
            faro.interessaPassear  = lastFaro.interessaPassear
            faro.interessaCruzar   = lastFaro.interessaCruzar
            faro
        }else{
            null
        }
        
    }
}
