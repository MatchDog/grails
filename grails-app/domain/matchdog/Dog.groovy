package matchdog

class Dog {
	String nome
	String sexo
	String descricaoPerfil
	Boolean temPedigree
	Boolean interessaCruzar
	Boolean interessaPassear
	Date datahoraExcluido

	Dono dono
	Raca raca
	Cidade cidade
	Foto foto


	static belongsTo = [Dono, Raca, Cidade, Foto]

	static hasMany = [fotos: Foto]

    static constraints = {
    	nome size: 3..50, nullable: false, blank: false
    	sexo maxSize: 1, nullable: false, blank: false
    	descricaoPerfil maxSize: 1000, nullable: true
		datahoraExcluido nullable: true
		foto nullable: true
    }

    static mapping = {
        foto column: "foto_perfil_id"
    }

    def get_count_matches(){
    	def consulta = Match.executeQuery("select count(distinct m.id) from Match m "+ 
            "where (:dog in (m.dog1.id, m.dog2.id) "+
            "AND (m.datahoraDog1Desistiu IS NULL AND m.datahoraDog2Desistiu IS NULL))", [dog: this.id])
    	consulta[0]
    }
    def get_count_latidas(){
    	def consulta = Latida.executeQuery("select count(distinct l.id) from Latida l "+
            "where (paraDog.id = :dog AND lidaEm IS NULL)", [dog: this.id])
    	consulta[0]
    }

}
