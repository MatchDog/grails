<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Welcome to Grails</title>
</head>
    <body>

<form name="cadastro" action="/dogs/update" method="post" enctype="multipart/form-data" class="form-horizontal">
<div class="row">
          
        
<div class="col-md-5">

<span class="title-session glyphicon glyphicon-camera"></span><span class="title-session">Foto do Perfil</span>
<hr>

<output  id='fotoperfilinicial' style="display:block">
    <div class="thumbnail">
          <g:if test="${ dog.foto != null}">
            <img src="/${dog.foto.url}">  
          </g:if>
          <g:else>
            <asset:image src="dog_default_image.png"/>
          </g:else>
     </div>
</output>
<output  id='fotoperfilnova' style="display:none">
</output>


<span class="file-input btn btn-default btn-block btn-file">
                Procurar Foto&hellip; <input type="file" data-initial-image="fotoperfilinicial" data-output-image="fotoperfilnova" name="foto" id="foto" class="form-control" accept="image/x-png, image/gif, image/jpeg">
            </span>
            
 
     
</div>

 <div class="col-md-2"></div>
 
<div class="col-md-5">
              
<span class="title-session glyphiconsPro glyphicon-dog">
     <span class="dog-icon-g"><asset:image src="dog-icon.png"/></span>
</span><span class="title-session">Seu dog</span>
<hr>


<div class="form-group">
  <div class="col-md-6">
     <input type="hidden" id="id" name="id" value="${ dog.id}">
     <input id="nome" required="required" type="text" name="nome" class="form-control" placeholder="Nome" value="${ dog.nome}">
  </div>
  <div class="col-md-6">
     <g:select name="raca"
          from="${racas}"
          class="form-control"
          optionKey="id" 
          optionValue="nome"
          value="${dog.raca.id}"
           />
  </div>
</div>
<div class="form-group">
    <div class="col-md-5">
    <select id="sexo" name="sexo" required="required" class="form-control">
        <option value="M" <g:if test="${dog.sexo == 'M'}"> selected="selected" </g:if>>Masculino</option>
        <option value="F" <g:if test="${dog.sexo == 'F'}"> selected="selected" </g:if>>Feminino</option>
    </select>
    </div>
    
    <div class="col-md-3">
        <label for="pedigree">
            <span style="display: inline;margin-right:5px;" class="glyphicon glyphicon-certificate"></span>Pedigree?</label>
    </div>
    <div class="col-md-4">
        <select id="pedigree" name="temPedigree" class="form-control">
            <option value="1" <g:if test="${dog.temPedigree}"> selected="selected" </g:if>>Sim</option>
            <option value="0" <g:if test="${!dog.temPedigree}"> selected="selected" </g:if>>Não</option>
        </select>
    </div>
</div>
<div class="form-group">
    <div class="col-md-12">
        <g:select name="cidade"
          from="${cidades}"
          class="form-control"
          optionKey="id" 
          optionValue="nome"
          value="${dog.cidade.id}"
           />
    </div>
</div>
<div class="form-group">
    
    <div class="col-md-3">
        <label for="cruzar">Cruzar?</label>
    </div>
    <div class="col-md-3">
        <select id="cruzar" name="interessaCruzar" class="form-control">
            <option value="1" <g:if test="${dog.interessaCruzar}"> selected="selected" </g:if>>Sim</option>
            <option value="0" <g:if test="${!dog.interessaCruzar}"> selected="selected" </g:if>>Não</option>
        </select>
    </div>
    <div class="col-md-3">
        <label for="passear">Passear?</label>
    </div>
    <div class="col-md-3">
        <select id="passear" name="interessaPassear" class="form-control">
            <option value="1" <g:if test="${dog.interessaPassear}"> selected="selected" </g:if>>Sim</option>
            <option value="0" <g:if test="${!dog.interessaPassear}"> selected="selected" </g:if>>Não</option>
        </select>
    </div>
    
</div>

<div class="form-group">
    <div class="col-md-12">
        <input type="submit" name="Salvar" class="btn btn-success btn-block" value="Salvar">
    </div>
</div>

 </div>

</div>

</form>


<div class='row'>
     
<div class="col=md-12">
    <br>
    <br>

    <span class="title-session glyphicon glyphicon-picture"></span><span class="title-session">Álbum do dog</span>
    <hr>
    <br>
    <br>
    <div class='row'>
        <div class='col-md-12' id='novaFoto'>
            
            <div class="thumbnail clearfix">
                
            <form name="fotos" action="/fotos/create" method="post" enctype="multipart/form-data" class="dropzone form" id="media-dropzone">

              <div class="fallback">
                <input type="file" name="media" multiple="true" />
              </div>
            </form>
            
            </div>
            
        </div>
    </div>
        
    <div id='album' class="row"></div>

</div>
</div> 



<div class="modal fade" id="deleteFotoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header panel-heading">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">Você tem certeza disso ?</h4>
        </div>
        <div class="modal-body">
          Você tem certeza que <b>deseja remover essa foto?</b>
        </div>
        <div class="modal-footer">
            <form id="form_excluir_foto" class="button_to" method="get" action="">
              <button type="button" class="btn btn-default" data-dismiss="modal">Não! Não quero remover.</button>
              <input class="btn btn-primary" type="submit" value="Sim! Quero remover!">
              </form>
          
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<script type="text/x-jquery-tmpl" id="foto-tmpl">

    <div class='col-md-4 same-height fotoBox'>
        <div class='thumbnail clearfix'>
            <img src='{{= url}}'/>
            <div>
                <button data-toggle='modal' data-target='#deleteFotoModal' data-id='{{= id}}' role='button' class='btn btn-danger pull-right' style='opacity: 0.75;position:absolute; left: 30px; top:15px;' role='button'>Excluir Foto</button>
            </div>
            <div class='caption'>
            <a href='#' id='descricao_{{= id}}' data-type='textarea' data-resource='foto' data-name='descricao' data-url='/fotos/update' data-pk='{{= id}}'>{{= descricao}}</a>
            {{html "<sc"+"ript>"}}
                $(function(){ 
                    $('#descricao_{{= id}}').editable({ 
                        title: 'Alterar descrição da foto', 
                        emptytext: 'Foto sem descrição',
                        rows: 4,
                    }); 
                }); 
            {{html "</sc"+"ript>"}}
            </a>
            </div>
        </div>
    </div>

</script>

<script>
  
     $('#deleteFotoModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var id = button.data('id')
        
        var modal = $(this)
        if(modal.find('#form_excluir_foto').attr("action") != "/fotos/destroy/"+String(id) ){

          modal.find('#form_excluir_foto').attr("action", "/fotos/destroy/"+String(id))
          
          modal.find('#form_excluir_foto').unbind('submit');
        
          modal.find('#form_excluir_foto').submit(function( event ){
              
              $.post(
                  $(this).attr('action'), 
                  $(this).serialize(), 
                  function(json) {
                      modal.find('.close').click();
                      button.parents('.fotoBox').remove();
                       $('.same-height').responsiveEqualHeightGrid();
                  }, 'json');

              return false;
          })

        }
      
    });

    

    function adicionarFotoNoAlbum(foto) {
      $.tmpl($("#foto-tmpl"), foto).appendTo("#album");
    }

	
    $(function() {
        
        document.getElementById('foto').addEventListener('change', handleFileSelect, false);
        
        
        <g:each in="${dog.fotos}">
            adicionarFotoNoAlbum(
                {
                    url: '/${it.url}',  
                    descricao: '${it.descricao}', 
                    id: '${it.id}'
                }
            );
        </g:each>
        
        $('.same-height').responsiveEqualHeightGrid();
    
        var mediaDropzone = new Dropzone("#media-dropzone", {
            dictDefaultMessage:"<center>"
              +"<br>"
              +"<br>"
              +"<icon class='fa fa-image fa-4x fa-fw'></icon>"
              +"<br>"
              +"Arraste novas fotos para cá"
              +"<br>"
              +"<br>"
              +"</center>"});
                
        mediaDropzone.on('sending', function(data, xhr, formData){
            formData.append('classe', 'dog');
            formData.append('id', ${ dog.id});
        });
        
        mediaDropzone.on("success", function(file, responseText) {
            var foto =  {
                url: '/'+responseText.url,  
                descricao: responseText.descricao, 
                id: responseText.id
            };
            adicionarFotoNoAlbum(foto);
            var _this = this;
            
            setTimeout(function(){
              _this.removeAllFiles();
            },2000);
            
            $('.same-height').responsiveEqualHeightGrid();	
      
        });
      
    });
   
    
</script>

</body>
</html>