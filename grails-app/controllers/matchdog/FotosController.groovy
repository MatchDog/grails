package matchdog

import grails.transaction.Transactional

@Transactional(readOnly = true)
class FotosController {

    def fileUploadService

    @Transactional
    def create() {    	
    	def file = request.getFile("file")
    	String fileUpload = fileUploadService.upload(file)
        if (fileUpload){
            def foto = new Foto(url:fileUpload,descricao:"Foto do Perfil")
            foto.save(flush: true)            
            def classe = params.classe
            if (classe == 'dog'){
                def dog = Dog.get(params.id)
                dog.save(flush: true)
                dog.addToFotos(foto)
            }
            else if (classe == 'dono'){
                def dono = Dono.get(params.id)
                dono.save(flush: true)
                dono.addToFotos(foto)
            }
            render(contentType: "text/json") {
                foto = foto
            }
        }
        
        render(status: 503, text: 'Não possível adicionar a foto')

    }
    @Transactional
    def destroy() {
    	def foto = Foto.get(params.id)
        foto.dogs.clear()
        foto.donos.clear()
        foto.delete(flush: true)
    	render(contentType: "application/json") {
           [head: "No Content"]
        }
    }

    @Transactional
    def update() {
    	def foto = Foto.get(params.pk)
    	foto.descricao = params.value
    	foto.save(flush: true)
    	render(contentType: "application/json") {
           [head: "No Content"]
        }
    }


    def album() { 
        if (params.classe == 'dog')
            [album: Dog.get(params.id)]
        else if (params.classe == 'dono')
            [album  : Dono.get(params.id)]
    }
    
}
