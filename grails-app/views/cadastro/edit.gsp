<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Welcome to Grails</title>
</head>
    <body>

<form name="cadastro" action="/cadastro/update" method="post" enctype="multipart/form-data" class="form-horizontal">

<div class="row">

<div class="col-md-5">

<span class="title-session glyphicon glyphicon-camera"></span><span class="title-session">Foto do Perfil</span>
<hr>

<output  id='fotoperfilinicial' style="display:block">
    <div class="thumbnail">
          <g:if test="${ dono.foto != null}">
            <img src="/${dono.foto.url}">  
          </g:if>
          <g:else>
            <asset:image src="dono_default_image.png"/>
          </g:else>
     </div>
</output>
<output  id='fotoperfilnova' style="display:none">
</output>

<span class="file-input btn btn-default btn-block btn-file">
                Procurar Foto&hellip; 
                <input type="file" data-initial-image="fotoperfilinicial" data-output-image="fotoperfilnova" name="foto" id="foto" class="form-control" accept="image/x-png, image/gif, image/jpeg">
</span>

</div>
          <div class="col-md-2"></div>
          <div class="col-md-5">

<span class="title-session glyphicon glyphicon-edit"></span><span class="title-session">Seus dados</span>
<hr>
<div class="form-group">
  <div class="col-sm-2">
    <label for="nome">Nome: </label>
  </div>
  <div class="col-sm-10">
      <input type="text" id="nome" name="nome" placeholder="Seu nome" class="form-control" value="${dono.nome}">
  </div>
</div>
<div class="form-group">
  <div class="col-sm-2">
    <label for="email">E-mail: </label>
  </div>
  <div class="col-sm-10">
      <input type="email" id="email" name="email" placeholder="E-mail" class="form-control" value="${dono.email}">
  </div>
</div>
<div class="form-group">
  <div class="col-sm-2">
    <label for="sexo">Sexo: </label>
  </div>
  <div class="col-sm-10">
    <select id="sexo" name="sexo" class="form-control">
        <option value="M" <g:if test="${dono.sexo == 'M'}"> selected="selected" </g:if> >Masculino</option>
        <option value="F" <g:if test="${dono.sexo == 'F'}"> selected="selected" </g:if> >Feminino</option>
    </select>
  </div>
</div>

<div class="form-group">
    <input type="submit" class="btn btn-success btn-block form-control" value="Salvar">
</div>


</div>


</div>

</form>

<div class='row'>
    
<div class="col=md-12">
    <br>
    <br>

    <span class="title-session glyphicon glyphicon-picture"></span><span class="title-session">Álbum de fotos</span>
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
            <form id="form_excluir_foto" class="button_to" method="post" action="">
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
        
        
        <g:each in="${dono.fotos}">
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
            formData.append('classe', 'dono');
            formData.append('id', ${dono.id});
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