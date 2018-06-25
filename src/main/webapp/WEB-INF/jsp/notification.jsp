<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<div class="container">

    <div class="col-md-12 text-center">
        <h1>Gestión de notificaciones</h1>
    </div>
    <table class="table">
        <thead>
            <tr>
                <th scope="col" class="text-center">#</th>
                <th scope="col" class="text-center">Nombre</th>
                <th scope="col" class="text-center">Email</th>
                <th scope="col" class="text-center">Fecha</th>
                <th scope="col" class="text-center">Mensaje</th>
                <th scope="col" class="text-center">Opciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${notificationsList}" var="notification" varStatus="count">
                <tr class="text-center">
                    <th scope="row">${count.index + 1}</th>
                    <td>${notification.transmitter.name}</td>
                    <td>${notification.transmitter.email}</td>
                    <td>${notification.date}</td>
                    <td class="text-center col-md-2">${notification.message}</td>
                    <td class="text-center col-md-3">
                        <div class="row">
                            <div class="col-md-6 col-md-offset-1">
                                <!-- onclick = "contactUser(${notification.receiver.id},${notification.transmitter.id})"-->
                                <button type="submit" class="btn btn-success" data-toggle="modal" data-target="#contact">Contactar</button>
                                <!-- Modal contact -->
                                <div class="modal fade" id="contact" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLongTitle">Contactar con ${notification.receiver.name}</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
								          <span aria-hidden="true">&times;</span>
								        </button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row" style="padding-top: 60px">
                                                    <div class="col-md-12">
                                                        <div class="well well-sm">
                                                            <form class="form-horizontal" action="/contactUser" name="notification" method="post">
                                                                <fieldset>
                                                                    <legend class="text-center">Contactar con ${notification.transmitter.name}</legend>
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
                                                                            <input type="hidden" name="receiver_id" value="${notification.transmitter.id}">
                                                							<input type="hidden" name="transmitter_id" value="${notification.receiver.id}">
                                                                        </div>
                                                                    </div>
                                                                </fieldset>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                                <c:if test="${correct}">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="alert alert-success alert-dismissible fade in text-center" role="alert">
                                                                <strong id="notif">Tu mensaje se ha enviado correctamente</strong>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <form action="/deleteNotification" method="post">
                                    <button type="submit" class="btn btn-danger">Borrar</button>
                                    <input type="hidden" name="id" value="${notification.id}">
                                </form>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>








<%@ include file="../jspf/footer.jspf"%>