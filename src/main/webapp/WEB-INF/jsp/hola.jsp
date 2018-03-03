<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

	<link type="text/css" media="screen" rel="stylesheet" href="static/css/classification.css" />
	<script src = "static/js/classificationSearchTeam.js"></script>
    
    <div class = "container">
        <h1 id = "classificationTitle">La liga <small>Rugby</small></h1>
        <div id = "classificationHeader">
            <div id = "searchTeamDiv">
                <input id = "searchTeam" class="form-control" type="text" placeholder="Buscar equipo" onclick="search()" >
            </div>
            <div >
                <img id = "classificationImage" src="static/img/imgRugby.jpg" alt="logo pagina clasificacion">
            </div>
        </div>
             
        <div>
            <table class="table">
                <thead id = "classificationHead">
                    <tr>
                        <th scope="col">Puesto</th>
                        <th scope="col">Club</th>
                        <th scope="col">Victorias</th>
                        <th scope="col">Empates</th>
                        <th scope="col">Derrotas</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th scope="row">1</th>
                        <td>Fisicas</td>
                        <td >3</td>
                        <td>0</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <th scope="row">2</th>
                        <td>Matematicas</td>
                        <td>2</td>
                        <td>1</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <th scope="row">3</th>
                        <td>Geologia</td>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <th scope="row">4</th>
                        <td>Farmacia</td>
                        <td>0</td>
                        <td>3</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <th scope="row">5</th>
                        <td>Veterinaria</td>
                        <td>0</td>
                        <td>2</td>
                        <td>3</td>
                    </tr>
                     <tr>
                        <th scope="row">5</th>
                        <td>Quimicas</td>
                        <td>0</td>
                        <td>1</td>
                        <td>4</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

<%@ include file="../jspf/footer.jspf"%>