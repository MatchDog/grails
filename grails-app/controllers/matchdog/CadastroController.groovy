package matchdog

import java.security.MessageDigest

class CadastroController {

    def fileUploadService

	// Como new é palavra reservada alterei para add
	def add() { } 

    def create() {
    	def dono = new Dono(donoParams(params))

    	//importar foto
        dono.foto = null
        if(params.foto) {
            def file = request.getFile("foto")
            String fileUpload = fileUploadService.upload(file)
            if (fileUpload){
                def foto = new Foto(url:fileUpload,descricao:"Foto do Perfil")
                foto.save(flush: true)
                dono.foto = foto
            }
        }

    	dono.password = MessageDigest.getInstance("MD5").digest(params.password.getBytes("UTF-8")).encodeHex().toString()
    	if(dono.save(flush: true)){
            session['dono_id'] = dono.id    
            flash.sucess = "Cadastro Realizado. Agora cadastre seu Dog"
            redirect(controller: "cadastro", action: "first_dog")
        }
        else{
            flash.error = "Algum erro ao realizar o cadastro."
            redirect(controller: "cadastro", action: "add")
        }
    	
    }

    def first_dog() {
    	[cidades: Cidade.getAll() , racas:  Raca.getAll()]
    }

    def edit() {
    	[dono: Dono.get(session['dono_id'])]
    }

    def update() {
    	def dono = Dono.get(session['dono_id'])
    	dono.nome = params.nome
    	dono.sexo = params.sexo
    	dono.email = params.email

        //importar foto
    	if(params.foto) {
    		def file = request.getFile("foto")
    		String fileUpload = fileUploadService.upload(file)
            if (fileUpload){
        		def foto
        		if(dono.foto) {
                    foto = dono.foto
        		} else {
        			foto = new Foto()
        		}   		
        		foto.url = fileUpload
        		foto.descricao = "Foto do Perfil"
        		foto.save(flush: true)
        		dono.foto = foto
            }
    	}

        //importar demais fotos
        if(params.files) {
            params.files.each {
                file = request.getFile("foto")
                String fileUpload = fileUploadService.upload(file)
                foto = new Foto(url:fileUpload,descricao:"Foto do Perfil")
                foto.save(flush: true)
                dono.addToFoto(foto)
            }
        }

    	if(dono.save(flush: true)){
            session['dono_id'] = dono.id
            flash.info = "Seu Perfil foi Editado com sucesso"
        }
        else{
            dono.errors.allErrors.each { println it }
        }
        redirect(controller: "dogs", action: "index")
    }
	

    def private donoParams(params){
    	[nome: params.nome, sexo: params.sexo, email: params.email, password: params.password]
    }  


}
