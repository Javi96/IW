<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>


<script>

//JavaScript Document
$(function() {
	// ordenar los menus de bootstrap
	var viewportWidth = $(window).width();
    if (viewportWidth <= 767) {
            $("#contenidomenu").removeClass("nav-justified").addClass("navbar-nav");
    }   
   //  fin ordenar menus boot
   
   // comportamiento buscar en movil, click en lupa
   $('#btsearch').click(function(e){
		$('#formbuscador').removeClass('posicion_buscar');	
		$('#formbuscador').addClass('posicion_input_buscar');
		$('#boption').show();
		if (viewportWidth <= 550) {
			$('#boption').addClass('boption_block');
		}
		if (!$('#search').is(':visible')){
		  e.preventDefault();
		}
		$('#search').show();
		$('#search').focus();
		$('#cerrar_buscador').show();
		$('#btsearch').hide();
		$('#collapse-personal').hide();
  });
  
  $('#cerrar_buscador').click(function(e){
	$('#formbuscador').removeClass('posicion_input_buscar');
	$('#formbuscador').addClass('posicion_buscar');	   
	$('#btsearch').show();
	$('#boption').hide();
	 if (viewportWidth <= 767) {
		 $('#collapse-personal').show();
		 $('#search').hide();
	 }
	$('#cerrar_buscador').hide();	
	e.preventDefault();
  });
   $('#carouselUcm').carousel({
	  interval: 10000,
	  pausa: 'hover',
   });
   
});
</script>
<main id="portada">
		
		<section class="fondogris">
			<div class="container carousel_col">
				<div id="carouselUcm" class="carousel slide" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carouselUcm" data-slide-to="0" class="active"></li>
						<li data-target="#carouselUcm" data-slide-to="1"></li>
						<li data-target="#carouselUcm" data-slide-to="2"></li>
						<li data-target="#carouselUcm" data-slide-to="3"></li>
					</ol>
					<div class="carousel-inner" role="listbox">
						<header><h2>Titulares</h2></header>
						<article class="item active">
							<figure>
								<img src="${s}/img/carrusel1.jpg" alt="Dcode Lab: La música en nuestras vidas" />
							</figure>
							<div class="news1_txt carousel-caption-ucm">
								<h3><a href="http://tribuna.ucm.es/43/art3249.php#.WvQGX4iFOUl" title="Dcode Lab: La música en nuestras vidas" class="enlace">Dcode Lab: La música en nuestras vidas</a></h3>
							</div>
						</article>
						<article class="item">
							<figure>
								<img src="${s}/img/carrusel2.jpg" alt="La Complutense, primera universidad española según el ranking “Las 50 carreras” de El Mundo" />
							</figure>
							<div class="news1_txt carousel-caption-ucm">
								<h3><a href="https://www.ucm.es/complutense-primera-ranking-el-mundo" title="La Complutense, primera universidad española según el ranking “Las 50 carreras” de El Mundo" class="enlace">La Complutense, primera universidad española según el ranking “Las 50 carreras” de El Mundo</a></h3>
							</div>
						</article>
						<article class="item">
							<figure>
								<img src="${s}/img/carrusel3.jpg" alt="Abierta la matrícula para los Cursos de Verano de la UCM en El Escorial y Madrid. Consulta las becas disponibles" />
							</figure>
							<div class="news1_txt carousel-caption-ucm">
								<h3><a href="https://www.ucm.es/cursosdeverano/programacion" title="Abierta la matrícula para los Cursos de Verano de la UCM en El Escorial y Madrid. Consulta las becas disponibles" class="enlace">Abierta la matrícula para los Cursos de Verano de la UCM en El Escorial y Madrid. Consulta las becas disponibles</a></h3>
							</div>
						</article>
						<article class="item">
							<figure>
								<img src=${s}/img/carrusel4.jpg" alt="Especialízate en lo que quieras con los másteres complutenses. Ampliado el plazo extraordinario hasta el 18 de mayo" />
							</figure>
							<div class="news1_txt carousel-caption-ucm">
								<h3><a href="https://www.ucm.es/plazo-admision-masteres" title="Especialízate en lo que quieras con los másteres complutenses. Ampliado el plazo extraordinario hasta el 18 de mayo" class="enlace">Especialízate en lo que quieras con los másteres complutenses. Ampliado el plazo extraordinario hasta el 18 de mayo</a></h3>
							</div>
						</article>
					</div>
					<a class="left carousel-control" href="#carouselUcm" role="button" data-slide="prev" aria-label="left">
						<span class="fa fa-chevron-left" aria-hidden="true" title="left"></span>
					</a>
					<a class="right carousel-control" href="#carouselUcm" role="button" data-slide="next" aria-label="right">
						<span class="fa fa-chevron-right" aria-hidden="true" title="right"></span>
					</a>
				</div>
			<div class="container news2">
				<div class="news2_item">
					<article>
							<figure>
							<img src="${s}/img/mini1.jpg" alt="Elecciones para la renovación de sectores del Consejo de Gobierno y Delegación de Estudiantes" class="img-responsive img_not_sec_vert"/>
						</figure>
						<div class="news2_txt">
							<h3><a href="https://www.ucm.es/noticias/elecciones-para-la-renovacion-de-sectores-del-consejo-de-gobierno" title="Elecciones para la renovación de sectores del Consejo de Gobierno y Delegación de Estudiantes">Elecciones para la renovación de sectores del Consejo de Gobierno y ... <i class="fa fa-plus-circle" aria-hidden="true"></i></a></h3>
						</div>
					</article>
				</div>
				<div class="news2_item">
					<article>
							<figure>
							<img src="${s}/img/mini2.jpg" alt="Horario ampliado de la Biblioteca María Zambrano por exámenes" class="img-responsive img_not_sec_hor"/>
						</figure>
						<div class="news2_txt">
							<h3><a href="https://biblioteca.ucm.es/noticias/25683" title="Horario ampliado de la Biblioteca María Zambrano por exámenes">Horario ampliado de la Biblioteca María Zambrano por exámenes</a></h3>
						</div>
					</article>
				</div>
			</div>
			</div>
		</section>		
		<div class="container">
			<div class="row" id="restonoticias">
				<section class="col-sm-6 col-xs-12" id="news3">
			<header class="rayabaja"><h2>Noticias</h2></header>
					<ul class="ulnoticias">
						<li><a href="https://www.ucm.es/noticias/publicados-los-listado-de-ayudas-ucm-grado-master-y-excelencia-master" title="Listado de NUEVOS BENEFICIARIOS de Ayudas UCM de Grado, curso 2017-18. Hasta 325 becas más." class="enlace">Listado de NUEVOS BENEFICIARIOS de Ayudas UCM de Grado, curso 2017-18. Hasta 325 becas más.</a></li>
						<li><a href="https://www.ucm.es/directo" title="Sigue en directo el seminario &quot;Desafíos de las ciudades iberoamericanas: ciudades inteligentes y vulnerabilidad social&quot;. Viernes 11 de mayo, a las 9:30 h, en Encuentros Complutense" class="enlace">Sigue en directo el seminario &quot;Desafíos de las ciudades iberoamericanas: ciudades inteligentes y vulnerabilidad social&quot;. Viernes 11 de mayo, a las 9:30 h, en Encuentros Complutense</a></li>
						<li><a href="https://www.ucm.es/noticias/seis-universidades-europeas-firman-en-bolonia-un-acuerdo-para-abrir-un-espacio-academico-compartido-multilingue-y-multidisciplinar" title="Seis universidades europeas firman en Bolonia un acuerdo para abrir un espacio académico compartido, multilingüe  y multidisciplinar" class="enlace">Seis universidades europeas firman en Bolonia un acuerdo para abrir un espacio académico compartido, multilingüe  y multidisciplinar</a></li>
						<li><a href="https://www.ucm.es/deportes" title="Trofeo deportivo Alfonso XIII. Finales femeninas y masculinas de baloncesto, balonmano, fútbol sala, rugby y voleibol. Jueves 10 de mayo, a partir de las 11:00 h" class="enlace">Trofeo deportivo Alfonso XIII. Finales femeninas y masculinas de baloncesto, balonmano, fútbol sala, rugby y voleibol. Jueves 10 de mayo, a partir de las 11:00 h</a></li>
					</ul>
					<div class="news_mas">
						<div class="news_mas_left">
							<a href="http://eventos.ucm.es/" title="UCM Eventos"><img src="/themes/ucm16/media/img/ucm-eventos.jpg" alt="UCM Eventos" /></a>
					</div>
						<div class="news_mas_right">
							<a href="https://www.ucm.es/noticias" class="enlace texto-gris" title="Más noticias">Más noticias</a>
							<a href="http://www.tribuna.ucm.es/" class="enlace texto-gris news_tribuna" title="Tribuna Complutense"><img src="/themes/ucm16/media/img/tribuna-complutense.jpg" alt="Tribuna Complutense" /></a>
						</div>
					</div>
				</section>
				<section class="col-sm-6 col-xs-12" id="avisos">
			<header class="rayabaja"><h2>Avisos y Destacados</h2></header>
					<ul class="ulavisos">
						<li><a href="http://venalacomplu.ucm.es">Ven a la Complutense &quot;#VenalaComplu&quot;</a></li>
						<li><a href="https://www.ucm.es/elecciones-sectores-cg">Elecciones para la renovación de sectores del Consejo de Gobierno</a></li>
						<li><a href="https://www.ucm.es/elecciones-delegacion-de-estudiantes">Elecciones Delegación de Estudiantes</a></li>
						<li><a href="https://www.ucm.es/data/cont/docs/3-2018-02-23-Colaboradores%20AEI.pdf">Aprobado el procedimiento de elección de colaboradores científicos de la AEI</a></li>
						<li><a href="https://www.ucm.es/convocatorias-vigentes-pas">Procesos Selectivos y Promociones Internas Vigentes para el PAS</a></li>
						<li><a href="/refugees-welcome">Colabora con los refugiados</a></li>
						<li><a href="http://psicallucm.es">PsiCall UCM: Servicio de Atención Psicológica a Estudiantes</a></li>
						<li><a href="/data/cont/docs/3-2017-02-08-4ª devolución paga extra diciembre 2012.pdf">4ª devolución parcial paga extra 2012</a></li>
					</ul>
				</section>
			</div>
		</div>		
		
		<section class="container recursos">
			<header><h2>Recursos</h2></header>
			<div class="row">
				<div class="">
					<ul class="iconos">
						<li><a href="http://www.ucm.es/informacion" class="enlace"><img alt="Información" src="/themes/ucm16/media/img/icono-informacion.png" /><p class="caption texto-gris text-center">INFORMACIÓN</p></a></li>
						<li><a href="https://www.ucm.es/portaldetransparencia" class="enlace"><img alt="Transparencia" src="/themes/ucm16/media/img/icono-transparencia.png" /><p class="caption texto-cielo text-center">TRANSPARENCIA</p></a></li>
						<li><a href="http://e-administracion.ucm.es" class="enlace"><img alt="Sede Electrónica" src="/themes/ucm16/media/img/icono-sede.png" /><p class="caption texto-rojo text-center">SEDE<br/>ELECTRÓNICA</p></a></li>
						<li><a href="https://www.ucm.es/becas-y-ayudas" class="enlace"><img alt="Becas y Ayudas" src="/themes/ucm16/media/img/icono-becas.png" /><p class="caption texto-verde text-center">BECAS Y <br/> AYUDAS</p></a></li>
						<li><a href="http://www.ucm.es/ucm-en-linea" class="enlace"><img alt="UCM Online" src="/themes/ucm16/media/img/icono-recursos.png" /><p class="caption texto-amarillo text-center">UCM ONLINE</p></a></li>
						<li><a href="http://www.ucm.es/perfilcontratante" class="enlace"><img alt="Perfil del contratante" src="/themes/ucm16/media/img/icono-contratante.png" /><p class="caption texto-bourdeos text-center">PERFIL DEL<br/>CONTRATANTE</p></a></li>         
						<li><a href="http://biblioteca.ucm.es/" class="enlace"><img alt="Biblioteca" src="/themes/ucm16/media/img/icono-biblioteca.png" /><p class="caption texto-azul text-center">BIBLIOTECA</p></a></li>
						<li><a href="http://www.ucm.es/campusvirtual" class="enlace"><img alt="Campus Virtual" src="/themes/ucm16/media/img/icono-campus-virtual.png" /><p class="caption texto-ocre text-center">CAMPUS VIRTUAL</p></a></li>			         											
					</ul>
		     	</div>
			</div>
		</section>		<div class="container">
	<div class="row">
		<div class="col-sm-6 col-xs-12" id="marco_01">
			<div class="column" id="lista_1">
						</div>
		</div>
		<div class="col-sm-6 col-xs-12" id="marco_02">
			<div class="column" id="lista_2">
						</div>
		</div>
	</div>
</div>	</main>
	

<%@ include file="../jspf/footer.jspf"%>
