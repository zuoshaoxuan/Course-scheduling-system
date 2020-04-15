<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>登录系统</title>
<script>
	var __links = document.querySelectorAll('a');
		function __linkClick(e) { parent.window.postMessage(this.href, '*');} ;
		for (var i = 0, l = __links.length; i < l; i++){
			if ( __links[i].getAttribute('data-t') == '_blank' ){
				__links[i].addEventListener('click', __linkClick, false);
				}
			}
</script>
<script src="js/jquery.min.js"></script>
<script>$(document).ready(function(c) {
	$('.alert-close').on('click', function(c){
		$('.message').fadeOut('slow', function(c){
	  		$('.message').remove();
		});
	});	  
});
</script>
</head>
<body>
<!-- contact-form -->
<div>	
<div class="message warning">
<div class="inset">
	<div class="login-head">
		<h1>Login Form</h1>
		 <div class="alert-close"> </div> 			
	</div>
		 <form action="login_action.jsp" method="post">
		 <ul>
			<li>
				<input type="text" class="text" value="用户名" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'username';}" name="username"><a href="#" class=" icon user" ></a>
			</li>
				<div class="clear"> </div>
			<li>
				<input type="password" value="密码" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'password';}" name="password"> <a href="#" class="icon lock"></a>
			</li>
				<div class="clear"> </div>
			</ul>
			<div class="submit">
				<input type="submit" onclick="myFunction()" value="登录" >
				<h4><a href="#">忘记密码？</a></h4>
						  <div class="clear">  </div>	
			</div>
		</form>
		</div>					
	</div>
	</div>
	<div class="clear"> </div>
<!--- footer --->
<div class="footer">
	<p>Copyright &copy; 2020</p>
</div>
</html>