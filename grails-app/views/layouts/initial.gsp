<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><g:layoutTitle default="MatchDog - Grails"/></title>
    <meta name="description" content="">
    <meta name="author" content="">
        <asset:javascript src="application.js"/>
        
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

        <asset:stylesheet src="application.css"/>
        

    <g:layoutHead/>
  </head>
  <body>
    <header class="navbar">
      <nav class="navbar-inner">
        <div class="container container-logo-initial">
          <span><asset:image src="icon_matchDog200.png"/></span>
        </div>
      </nav>
    </header>
    <div id="main" role="main">
      <div class="container container-initial">
        <div class="content">
        <div class="row-fluid">
          <g:layoutBody/>
        </div>
          

        </div>
      </div> <!--! end of .container -->
    </div> <!--! end of #main -->
    <footer class="footer">
      <div class="container">
        <div class="col-md-4" id='fb-root'>
          <div  class="fb-like"   data-share="true"    data-width="450"   data-show-faces="true"></div>
        </div>
        <div class="col-md-5">
          <p>MatchDog - All Rights Reserved</p>
        </div>
        <div class="col-md-4"></div>
      </div>
    </footer>
  </body>
<!--<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '1458025767830877',
      xfbml      : true,
      version    : 'v2.3'
    });
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
</script>-->
</html>