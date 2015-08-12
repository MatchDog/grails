package matchdog

class FotosController {

    def fileUploadService


    def create() {    	
    	def file = request.getFile("file")
    	String fileUpload = fileUploadService.upload(file)
        if (fileUpload){
            def foto = new Foto(url:fileUpload,descricao:"Foto do Perfil")
            foto.save(flush: true)            
            def classe = params.classe
            if (classe == 'dog'){
                def dog = Dog.get(params.id)
                dog.addToFotos(foto)
                dog.save(flush: true)
            }
            else if (classe == 'dono'){
                def dono = Dono.get(params.id)
                dono.addToFotos(foto)
                dono.save(flush: true)
            }
            render(contentType: "text/json") {
                foto = foto
            }
        }
        
        render(status: 503, text: 'Não possível adicionar a foto')

    }

    def destroy() {
    	def foto = Foto.get(params.id)
        foto.dogs.clear()
        foto.donos.clear()
        foto.delete(flush: true)
    	render(contentType: "application/json") {
           [head: "No Content"]
        }
    }

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
