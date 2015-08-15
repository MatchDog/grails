<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>MatchDog - Grails</title>

</head>
    <body>
        <div class="owl-carousel">
                <!-- aqui era @alvos, variável de instância que não sei como faz no grails -->
                <g:each var="d" in="${alvos}">
            
                    <div id="alvo-${ d.id }" class="alvo">
                        <div class="row-fluid">
                            <g:if test="${d.descricaoPerfil != null}">
                                <div class="col-md-12 desc-alvo">
                                    ${ d.descricaoPerfil }
                                    | Cidade: ${ d.cidade.nome } | Raça: ${ d.raca.nome } | sexo: <%= d.sexo %>
                                </div>
                            </g:if>
                            <div class="col-md-1 bt-left-alvo">
                                
                            </div>
                            <div id="alvo-dog" class="col-md-5 alvo-nome">
                                <!-- só deve ter a classe glyphicon-certificate SE TIVER PEDIGREE-->
                                <g:if test="${d.temPedigree}">
                                    <span class="glyphicon glyphicon-certificate"></span>
                                </g:if>
                                <span class="alvo-nome">${ d.nome }</span>
                                 <a href="/album/dog/${ d.id }" class="fancybox fancybox.ajax">
                                    <div id="foto-alvo-dog" class="foto-alvo inclina1">
                                        <span class="glyphicon glyphicon-camera"></span>
                                        <g:if test="${d.foto != null && !d.foto.isEmpty()}">
                                            <img src="/${d.foto.url}">  
                                        </g:if>
                                        <g:else>  
                                            <asset:image src="dog_default_image.png"/>  
                                        </g:else>  
                                    </div>
                                </a>
                            </div>
                            <div id="alvo-dono" class="col-md-5 alvo-nome">
                                <span class="">${ d.dono.nome }</span>
                                <a href="/album/dono/${ d.dono.id }" class="fancybox fancybox.ajax">
                                    <div id="foto-alvo-dono" class="foto-alvo inclina2">
                                        <span class="glyphicon glyphicon-camera"></span>
                                        <g:if test="${d.dono.foto}">
                                            <img src="/${ d.dono.foto.url }">  
                                        </g:if>
                                        <g:else>
                                            <asset:image src="dono_default_image.png"/>      
                                        </g:else>  
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-1 bt-right-alvo">

                                <a><asset:image src="bt-uau.png" class="bt-uau-alvo bt"/> </a>
                                <a><asset:image src="bt-nops.png" class="bt-nops-alvo bt"/> </a>
                            </div>
                        </div>
                    </div>
                </g:each>
            
            
            <div id="sem-alvo" class="alvo">
                <div class="row-fluid">
                    <div class="col-md-12">
                        <center>
                            <br><br>
                            <asset:image src="dog_not_found.png"/>  
                            <br><br>
                            Nesse mato não tem cachorro!
                        </center>
                    </div>
                </div>
          </div>
         
        </div>
        <script>
        $(document).ready(function() {
            var owl = $(".owl-carousel");
            owl.owlCarousel({
                items : 2,
                singleItem : true,
                navigation : false,
                navigationText : ["voltar","uau!"],
                rewindNav : false,
                scrollPerPage : false,
                pagination : false,
                mouseDrag : false,
                
                    //Callbacks
            beforeUpdate : false,
            afterUpdate : false,
            beforeInit: false, 
            afterInit: false, 
            beforeMove: false, 
            afterMove: false,
            afterAction: false,
            startDragging : false,
            afterLazyLoad : false
                
            });
            
            /* ações de Uau e Nops */
            $(".bt-uau-alvo").click(function(){
                var alvo_id = $(this).parents('[id^="alvo-"]').attr('id').split('-')[1]
                $.ajax({
                    url: "curtir",
                    type: "POST",
                    data: {id: alvo_id, curtiu: true},
                    success: function (data) {
                        if(data.match){
                            $("#flash-message").append("<div id='flash-sucess' class='alert alert-success'> <a href='/matches'> DEU MATCH !!! </a></div>");
                            $("#flash-message").children().delay(3000).slideUp(500);
                        }
                        owl.trigger('owl.next');
                    }
                });
            });
            $(".bt-nops-alvo").click(function(){
                var alvo_id = $(this).parents('[id^="alvo-"]').attr('id').split('-')[1]
                $.ajax({
                    url: "curtir",
                    type: "POST",
                    data: {id: alvo_id, curtiu: false},
                    success: function (data) {
                        owl.trigger('owl.next');
                    }
                });
            });
            
            $(".bt-voltar-alvo").click(function(){
                owl.trigger('owl.prev');
            });
            
            $('.foto-alvo').mouseover(function() {
                $( this ).find( ".glyphicon-camera" ).show();
            });
            
            $('.foto-alvo').mouseout(function() {
                $( this ).find( ".glyphicon-camera" ).hide();
            });
        });
        </script>

   </body>
</html>
