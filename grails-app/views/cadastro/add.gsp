<!doctype html>
<html>
    <head>
        <meta name="layout" content="initial"/>
        <title>Welcome to Grails</title>
</head>
    <body>

<form name="cadastro" action="/cadastro/create" method="post" enctype="multipart/form-data" class="form-horizontal">

<div class="col-md-5">


<span class="title-session glyphicon glyphicon-camera"></span><span class="title-session">Foto do Perfil</span>
<hr>

<output  id='fotoperfilinicial' style="display:block">
    <div class="thumbnail">
        <asset:image src="dono_default_image.png"/>
     </div>
</output>
<output  id='fotoperfilnova' style="display:none">
</output>

<span class="file-input btn btn-default btn-block btn-file">
                Procurar Foto&hellip; 
                <input type="file" data-initial-image="fotoperfilinicial" data-output-image="fotoperfilnova" name="foto" id="foto" class="form-control" accept="image/x-png, image/gif, image/jpeg">
</span>


<script>
  document.getElementById('foto').addEventListener('change', handleFileSelect, false);
  
</script>

</div>

<div class="col-md-2"></div>
<div class="col-md-5">
    
<div>
<span class="title-session glyphicon glyphicon-edit"></span><span class="title-session">Seus dados</span>
<hr>
<div class="form-group">
  <div class="col-md-12">
      <input type="text" required="required" name="nome" placeholder="Seu nome" class="form-control">
  </div>
</div>
<div class="form-group">
  <div class="col-md-7">
    <input type="email" required="required" name="email" placeholder="E-mail" class="form-control">
  </div>
  <div class="col-sm-1">
    <label for="sexo">Sexo: </label>
  </div>
  <div class="col-md-4">
    <select id="sexo" required="required" name="sexo" class="form-control">
        <option value="M">Masculino</option>
        <option value="F">Feminino</option>
    </select>
  </div>
</div>

<div class="form-group">
    <div class="col-md-6">
        <input type="password" required="required" name="password" placeholder="Senha" class="form-control">
    </div>
    <div class="col-md-6">
        <input type="password" required="required" name="password-r" placeholder="Repita a senha" class="form-control">
    </div>
</div>

<div class="form-group">
    <input type="submit" class="btn btn-success btn-block" value="Salvar">
</div>

</form>
</div>

</div>

   </body>
</html>
