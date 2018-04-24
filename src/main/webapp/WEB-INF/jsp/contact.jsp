<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<div class="container">
	<div class="row" style = "padding-top: 60px">
	    <div class="col-md-6 col-md-offset-3">   	
			<div class="well well-sm">
				<form class="form-horizontal" action="/contactDelegated" method="post">
					<fieldset>
						<legend class="text-center">Contactar delegado de Rugby Fisicas</legend>
						<!-- Name input-->
						<div class="form-group">
							<label class="col-md-3 control-label" for="name">Nombre</label>
								<div class="col-md-9">
							<input id="name" name="name" type="text" placeholder="Tu nombre" class="form-control">
							</div>
						</div>
						<!-- Message body -->
						<div class="form-group">
						<label class="col-md-3 control-label" for="message">Mensaje</label>
						<div class="col-md-9">
							<textarea class="form-control" id="message" name="message" placeholder="Introduce tu mensaje aqui..." rows="5"></textarea>
						</div>
						</div>
						<!-- Form actions -->
						<div class="form-group">
						<div class="col-md-12 text-center">
							<button type="submit" class="btn btn-primary btn-lg">Enviar</button>
						</div>
						</div>
					</fieldset>
				</form>
			</div>
	    </div>
	</div>
</div>

<%@ include file="../jspf/footer.jspf"%>
