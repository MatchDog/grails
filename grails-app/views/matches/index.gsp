<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>MatchDog - Grails</title>
	</head>
    <body>

		<div class="row-fluid">
		    <div id="side-matches" class="col-md-6">
		        <span class="title-session glyphicon glyphicon-fire"></span><span class="title-session">Matches de <g:getCurrentDogNome/> ;)</span>
		        <hr> 
		        <div id="matches">
		        
		        <g:if test="${ ! matches }">
					<span class="title-date">
	             	Seu cãozinho não tem nenhum match :(
	             	</span> 
				</g:if>

		        <g:each var="m" in="${matches}">
		        
		         
		        <div id="match-${ m.id }" class="one-match">
		            
		            
		             <span class="title-date glyphicon glyphicon-fire"></span><span class="title-date">
		             Match em <g:formatDate format="dd-MM-yyy 'às' HH'h'mm'm'" date="${ m.datahora}"/></span> 

		            <div class="row-fluid">
		                <div class="col-sm-3 foto-me-and-dog">  
		                    <g:ifCurrentDonoHasFoto>
			                    <img src="/<g:getCurrentDonoFotoUrl/>" class="mini-me"> 
			                </g:ifCurrentDonoHasFoto>
			                <g:ifCurrentDonoHasNotFoto>  
			                    <asset:image src="dono_default_image.png" class="mini-me"/>
			                </g:ifCurrentDonoHasNotFoto>

		                    <g:ifCurrentDogHasFoto>
			                    <img src="/<g:getCurrentDogFotoUrl/>" class="mini-dog"> 
			                </g:ifCurrentDogHasFoto>
			                <g:ifCurrentDogHasNotFoto>
			                    <asset:image src="dog_default_image.png" class="mini-dog"/>
			                </g:ifCurrentDogHasNotFoto>
		                </div>
		                <div class="col-sm-1 versus">
		                    <span class="title-session">X</span>
		                </div>

		                <g:if test="${m.dog1.id != session.dog_id}"> %{-- dog1 é o "outro" --}% 
		                	<div class="col-sm-2 foto-alvo-mini match-dog">
			                    <a href="/album/dog/${m.dog1.id}" class="fancybox fancybox.ajax">
			                        <span class="glyphicon glyphicon-camera"></span>
									<g:if test="${ m.dog1.foto != null}">
						            	<img src="/${m.dog1.foto.url}">  
						          	</g:if>
						          	<g:else>
							            <asset:image src="dog_default_image.png"/>
							        </g:else>
			                    </a>
			                    ${m.dog1.nome}
		                	</div>
			                <div class="col-sm-2 foto-alvo-mini match-dono">
			                    <a href="/album/dono/${m.dog1.id}" class="fancybox fancybox.ajax">
			                        <span class="glyphicon glyphicon-camera"></span>
		                        	<g:if test="${ m.dog1.dono.foto != null}">
						            	<img src="/${m.dog1.dono.foto.url}">  
						          	</g:if>
						          	<g:else>
							            <asset:image src="dono_default_image.png"/>
							        </g:else>
			                    </a>
			                    ${m.dog1.dono.nome}
			                </div>
			                <div class="col-sm-3">
		                </g:if>

		                <g:if test="${m.dog2.id != session.dog_id}"> %{-- dog2 é o "outro" --}% 
		                	<div class="col-sm-2 foto-alvo-mini match-dog">
			                    <a href="/album/dog/${m.dog2.id}" class="fancybox fancybox.ajax">
			                        <span class="glyphicon glyphicon-camera"></span>
									<g:if test="${ m.dog2.foto != null}">
						            	<img src="/${m.dog2.foto.url}">  
						          	</g:if>
						          	<g:else>
							            <asset:image src="dog_default_image.png"/>
							        </g:else>

			                    </a>
			                    ${m.dog2.nome}
		                	</div>
			                <div class="col-sm-2 foto-alvo-mini match-dono">
			                    <a href="/album/dono/${m.dog2.id}" class="fancybox fancybox.ajax">
			                        <span class="glyphicon glyphicon-camera"></span>
									<g:if test="${ m.dog2.dono.foto != null}">
						            	<img src="/${m.dog2.dono.foto.url}">  
						          	</g:if>
						          	<g:else>
							            <asset:image src="dono_default_image.png"/>
							        </g:else>
			                    </a>
			                    ${m.dog2.dono.nome}
			                </div>
			                <div class="col-sm-3">
		                </g:if>

		                <!--
		                   <a href="/latidas/domatch/<%= m.id %>" class="fancybox fancybox.ajax btn btn-success form-control"><span class="glyphicon glyphicon-comment"></span>Latir</a>
		                -->  
		                   <button id="singlebutton" name="singlebutton" class="btn btn-success form-control bt-latir"><span class="glyphicon glyphicon-comment"></span> Latir</button>
		                   <hr style="margin-top: 7px;  margin-bottom: 7px;">
		                   <a href="/matches/naorolamais/<%= m.id %>" class="btn btn-danger form-control"><span class="glyphicon glyphicon-remove-circle"></span> ñ rola +</a>
		                </div>
		            </div>
		            <div class="col-sm-12"><hr></div>
		        </div>
		        
		        </g:each>
		        </div><!--matches-->
		        
		    </div>
		    
		    
		    <div id="side-latidas" class="col-md-6">
		        <div id="ponta-box" style="display:none"></div>
		        <div id="top-ocultar"><a href="#" title="ocultar" class="ocultar"><span class="glyphicon glyphicon-eye-close"></span></a></div>
		        <div id="box-latidas" class="col-md-12">
		            
		            
		            <div id="latidas">
		               %{--  <!-- já estava comentado desde o matchdog original
		                <div id="one-latida" class="latida-left col-md-10">
		                    <div id="avatar-latida-left">
		                        <img class="mini-me" src="/images/ellen.jpg">
		                    </div>
		                    <div id="conteudo-latida">
		                        isto é uma latida da outra pessoa
		                    </div>
		                    <span class="data-envio">enviada em 12/07/15 15:02</span>
		                    <div class="seta-esquerda"></div>
		                </div>
		                <div id="one-latida" class="latida-right col-md-10">
		                    <div id="avatar-latida-right"> 
		                        <% if !current_user.foto.nil? %>
		                        <img class="mini-me" src="/images/<%= current_user.foto.url %>"> 
		                        <% else %>    
		                        <%= image_tag "dono_default_image.png", class: "mini-me" %> 
		                        <% end %> 
		                    </div>
		                    <div id="conteudo-latida"> 
		                        isto é uma latida MINHA <br>
		                        teste<br>
		                    </div>
		                    <span class="data-envio">enviada em 12/07/15 15:00</span>
		                    <div class="seta-direita"></div>
		     
		                </div>
		                --> --}%
		            </div>
		            
		        </div><!--fim box latidas-->
		        <div id="form-latida" class="col-md-12">
		            <form id="sendMessage" action="/latidas/enviar" method="post">
		                <div class="col-sm-9">
		                    <input type="hidden" id="hiddenMatchId" name="match_id" value="">
		                    <textarea name="mensagem" required="required" id="mensagemText" placeholder="au au!" class="form-control" rows="2" cols="50"></textarea>
		                </div>
		                <div class="col-sm-3">
		                    <button type="submit" name="singlebutton" class="btn btn-success form-control"><span class="glyphicon glyphicon-comment"></span> Latir</button>
		                </div>
		            </form>
		        </div>
		    </div>
		    
		    
		    <!--carregar via ajax-->
		    <div style="display:none;">
		      
		    </div>
		</div>
		<script>

		$(document).ready(function() {
		      var reload;

		       $("#sendMessage").submit(function(event) {
			      event.preventDefault();
			      var $form = $( this ),
			      url = $form.attr( 'action' );

			      /* Send the data using post */
			      var posting = $.post( url, { match_id: $('#hiddenMatchId').val(), mensagem: $('#mensagemText').val() } );

			      /* Alerts the results */
			      posting.done(function( data ) {
			        $('#mensagemText').val('');
		          	getAjax($('#hiddenMatchId').val());
			      });
			    });
		   
		       $('.foto-alvo-mini').mouseover(function() {
		        $( this ).find( ".glyphicon-camera" ).show();
		      })
		      .mouseout(function() {
		        $( this ).find( ".glyphicon-camera" ).hide();
		      });
		      
		      $('.ocultar').click(function() {
		        $('#box-latidas').fadeOut();
		        $('#form-latida').fadeOut();
		        $('#ponta-box').fadeOut();
		        $('#top-ocultar').fadeOut();
		        clearInterval(reload);
		        $('.one-match').removeClass('inativo');
		        $('.bt-latir').removeClass('inativo');
		      });
		      
		      $('.bt-latir').click(function() {
		        $(this).addClass('inativo');
		        $('#box-latidas').fadeIn();
		        $('#form-latida').fadeIn();
		        $('#ponta-box').fadeIn();
		        $('#top-ocultar').fadeIn();
		        $('#latidas').empty();
		        
		        var match = $(this).parents('[id^="match-"]').attr('id').split('-')[1];
		        //var match = 1;
		        $('#hiddenMatchId').val(match);
		        
		        getAjax(match);
		        
		        reload = setInterval(function(){
		             getAjax(match)   
		        },3000);
		        
		        
		        //inativo todos para depois ativar somente o this
		        $('.one-match').addClass('inativo');
		        $(this).parents('.one-match').removeClass('inativo');
		        
		        //movendo o match clicado para o topo da lista CASO NAO SEJA O PRIMEIRO
		        if($('#matches').children().first()[0] === $(this).parents('.one-match')[0]){
		           //já está no topo, não precisa mover a div
		        }else{
		            $('#matches').children().first().animateAppendTo('#matches', 1000);//tirando o atual
		            $(this).parents('.one-match').animatePrependTo('#matches', 500);//colocando o novo no topo
		        }
		      });
		      
		      function getAjax(match){
		          var dogLogado = ${session.dog_id}
		          $.ajax ({
		            url: "/latidas/domatch/" + match,
		            dataType : "json",
		            success : function(data){
		                var usuario1 = data.match.dog1.id;
		                var usuario2 = data.match.dog2.id;
		                $('#latidas').empty();
		                data.latidas.forEach(function(latida){
		                    var classs = (dogLogado == latida.deDog.id) ? 'right' : 'left';
		                    var fotoDoEnviado = '/'+(usuario1 == latida.deDog.id) ? data.foto_dono1 : data.foto_dono2;
		                    if(!fotoDoEnviado) fotoDoEnviado = '/assets/dono_default_image.png';
		                    var dataEnviadaEm = new Date(latida.enviadaEm);
		                    var dataEnviadaEmFormatada = dataEnviadaEm.getDate() + '/' + (dataEnviadaEm.getMonth()+1 ) + '/' + dataEnviadaEm.getFullYear() +' às ' +  dataEnviadaEm.getHours() + 'h' + dataEnviadaEm.getMinutes() + 'm' +  dataEnviadaEm.getSeconds()+'s';

		                  $('#latidas').append('<div id="one-latida" class="latida-'+ classs +' col-md-10">'+'<div id="avatar-latida-'+classs+'">'+'<img class="mini-me" src="'+fotoDoEnviado+'"></div>'+'<div id="conteudo-latida">'+latida.mensagem+'</div>'+'<span class="data-envio">enviada em ' + dataEnviadaEmFormatada+ '</span>'+'<div class="seta-'+classs+'"></div>'+'</div');
		                      
		                });
		                $("#box-latidas").scrollTop($("#box-latidas").prop('scrollHeight'));
		            }
		        });
		      }
		      
		});
		</script>

    </body>
</html>
