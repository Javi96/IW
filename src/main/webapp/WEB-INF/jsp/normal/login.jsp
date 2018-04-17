<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<%@ include file="../../jspf/header.jspf"%>
<script type="text/javascript" src="${s}/js/script.js"></script>

<link rel="icon" type="image/icon" href="https://sso.ucm.es/simplesaml/resources/icons/favicon.ico" />

<div id="wrap" class="fondogris container-fluid">
<div id="content" class="container">
	<form action="/login" method="post" class="form-horizontal">
		<h2 class="h2sub hidden-xs">Acceso Web Unificado a la UCM (Web SSO)</h2>
		<p>Identificarse correctamente en esta página le habilitará la entrada en la mayoría de las aplicaciones y en los servicios en la nube @UCM.</p>
		<div class="row">
			<div class="col-sm-1"></div>
			<div class="col-sm-2 hidden-xs">
				<img id="img-llaves" class="img-circle" src="${s}/img/gtk-dialog-authentication.48x48.png" alt="img-autenticacion" />
			</div>
			<div class="col-sm-8 col-xs-12">
				<div class="form-group">
					<label for="username" class="col-lg-4 control-label">Dirección de correo UCM</label>
					<div class="col-lg-8">
						<input type="text" class="form-control" id="username" tabindex="1" name="username"/>
					</div>
				</div>
				<div class="form-group">
					<label for="password" class="col-lg-4 control-label">Contrase&ntilde;a</label>
					<div class="col-lg-8">
						<input class="form-control" id="password" type="password" tabindex="2" name="password"/>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</div>
				</div>
				<input type="hidden" name="AuthState" value="_89a47d127c2c05f3db796e7745f2a74c804003a4f5:https://sso.ucm.es/simplesaml/saml2/idp/SSOService.php?spentityid=ucm-sp&amp;cookieTime=1523388167&amp;RelayState=https%3A%2F%2Fwww.ucm.es%2Flogin_sso%2F" />
				<!-- 2FA will be integrated in this div -->
				<div class="form-group" id="secondFA" style="display:none">
					<label for="captcha2" class="col-lg-4 control-label">Segundo Factor de Autenticación (escriba la clave numérica generada con su dispositivo)</label>
					<div class="col-lg-8">
						<input class="form-otp" id="totp" type="text"  tabindex="3" name="totp"/>
					</div>
				</div>
				<div id="boxAJAX" class=hidden></div>
				<br/>
				<div class="text-center">
					<input type="submit" class="btn btn-default btn-lg active" tabindex="4" name="Enviar" value="Iniciar sesión" />
				<!-- <button class="btn btn-default btn-lg active" type="submit">Iniciar sesión</button> -->
				</div>
			</div>
		</div>
		<h2></h2><p><a href='https://idm.ucm.es/clave'>&#191;Olvidó la contrase&ntilde;a&#63;</a><br><a href='http://faq.ucm.es'>Más información</a></p>
	</form>
	</div>
</div>
<%@ include file="../../jspf/footer.jspf"%>
