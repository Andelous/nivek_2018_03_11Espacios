<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Mis espacios</title>
    </head>
    <body>
        <div class="row">

            <h4 class="col-md-8 mb-0 text-center">
                <span class="oi oi-check"></span>
                Listado de solicitudes
            </h4>

            <div class="col-md mb-0 ml-auto">
                <g:form action="misEspacios" method="GET" class="form-inline w-100">
                    <div class="form-group">
                        <label>Mis espacios</label>&nbsp;
                        <select class="form-control form-control-sm"
                            id="selectRol" name="espacio.id"
                            onchange="submit()">
                            <option value="">Todos</option>
                            <g:each in="${espaciosLista}" var="e">
                                <option value="${e.id}"
                                    ${ e.id == espacio?.id ? "selected" : ""}>
                                    ${e}
                                </option>
                            </g:each>
                        </select>
                    </div>
                </g:form>
            </div>
        </div>

        <hr />

        <g:if test="${params.aprobada}">
            <div class="alert alert-success">
                Solicitud aprobada con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.restaurada}">
            <div class="alert alert-info">
                Solicitud restaurada con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.rechazada}">
            <div class="alert alert-warning">
                Solicitud rechazada con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.errorAcceso}">
            <div class="alert alert-danger">
                <h5 class="alert-heading">
                    <strong>Error</strong>
                </h5>
                No tienes permiso para ver, crear o modificar los datos de otras
                instituciones y/o usuarios. O de solicitudes que hayas cancelado o hayan
                sido rechazadas.
            </div>
        </g:if>


        <table class="table table-hover">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Espacio</th>
                    <th scope="col">Fecha y hora</th>
                    <th scope="col">Solicitante</th>
                    <th scope="col">Raz&oacute;n</th>
                    <th scope="col">Estado</th>
                    <th scope="col">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${solicitudesLista}" var="solicitud">
                    <%@ page import="com.nivek.sms.SolicitudEstado" %>
                    <g:set var="cancelada" value="${false}" />
                    <g:set var="aprobada" value="${false}" />
                    <g:set var="enRevision" value="${false}" />
                    <g:set var="rechazadaEncargado" value="${false}" />
                    <g:set var="rechazadaSistema" value="${false}" />

                    <g:set var="cancelada" value="${solicitud?.estado?.nombre == SolicitudEstado.CANCELADA_USUARIO}" />
                    <g:set var="aprobada" value="${solicitud?.estado?.nombre == SolicitudEstado.APROBADA}" />
                    <g:set var="enRevision" value="${solicitud?.estado?.nombre == SolicitudEstado.EN_REVISION}" />
                    <g:set var="rechazadaEncargado" value="${solicitud?.estado?.nombre == SolicitudEstado.RECHAZADA_ENCARGADO}" />
                    <g:set var="rechazadaSistema" value="${solicitud?.estado?.nombre == SolicitudEstado.RECHAZADA_SISTEMA}" />

                    <tr>
                        <td scope="row"><strong>${solicitud.espacio}</strong></td>
                        <td>
                            <strong>${solicitud.fecha.format("yyyy-MM-dd")}</strong>,
                            de
                            <strong>${solicitud.horaInicio}</strong>
                            a
                            <strong>${solicitud.horaFin}</strong>
                        </td>
                        <td>${solicitud.usuario.persona}</td>
                        <td>${solicitud.razon}</td>
                        <td>
                            <i class="
                                ${cancelada ? 'text-danger' : ''}
                                ${aprobada ? 'text-success' : ''}
                                ${rechazada ? 'text-muted' : ''}
                            ">
                                ${solicitud.estado}
                            </i>
                        </td>
                        <td>
                            <a href="#" class="btn btn-link btn-sm text-dark
                                ${enRevision ? '' : 'disabled'}"
                                data-toggle="modal" data-target="#modalAprobar${solicitud.id}">
                                <span class="oi oi-check text-success"></span>
                                Aprobar
                            </a>
                            <a href="#" class="btn btn-link btn-sm text-dark
                                ${aprobada || enRevision ? '' : 'disabled'}"
                                data-toggle="modal" data-target="#modalRechazar${solicitud.id}">
                                <span class="oi oi-circle-x text-danger"></span>
                                Rechazar
                            </a>
                            <a href="#" class="btn btn-link btn-sm text-dark
                                ${rechazadaEncargado ? '' : 'disabled'}"
                                data-toggle="modal" data-target="#modalRestaurar${solicitud.id}">
                                <span class="oi oi-action-undo text-info"></span>
                                Restaurar
                            </a>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>

        <g:render template="/compartido/paginacion" />

        <br />
        <br />




        <g:each in="${solicitudesLista}" var="solicitud">
            <div class="modal fade" id="modalAprobar${solicitud.id}" tabindex="-1"
                role="dialog" aria-labelledby="tituloModal" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title" id="tituloModal">
                                <strong>Confirmaci&oacute;n</strong>
                            </h5>
                            <button type="button" class="close" data-dismiss="modal"
                                aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body text-center bg-success text-white">
                            ¿Est&aacute; seguro que desea aprobar esta solicitud?
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                data-dismiss="modal">Cancelar</button>

                            <g:link action="aprobar" controller="solicitudes"
                                params="['solicitud.id': solicitud.id]"
                                class="btn btn-success">
                                Aprobar
                            </g:link>
                        </div>

                    </div>
                </div>
            </div>





            <div class="modal fade" id="modalRechazar${solicitud.id}" tabindex="-1"
                role="dialog" aria-labelledby="tituloModal" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title" id="tituloModal">
                                <strong>Advertencia</strong>
                            </h5>
                            <button type="button" class="close" data-dismiss="modal"
                                aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body text-center bg-danger text-white">
                            ¿Est&aacute; seguro que desea rechazar esta solicitud?
                            <br />
                            <br />
                            <strong>
                                Si la solicitud est&aacute; aprobada,
                                se recuperar&aacute;n todas las solicitudes
                                que hayan sido rechazadas por su aprobaci&oacute;n.
                            </strong>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                data-dismiss="modal">Cancelar</button>

                            <g:link action="rechazar" controller="solicitudes"
                                params="['solicitud.id': solicitud.id]"
                                class="btn btn-danger">
                                Rechazar solicitud
                            </g:link>
                        </div>

                    </div>
                </div>
            </div>






            <div class="modal fade" id="modalRestaurar${solicitud.id}" tabindex="-1"
                role="dialog" aria-labelledby="tituloModal" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title" id="tituloModal">
                                <strong>Confirmaci&oacute;n</strong>
                            </h5>
                            <button type="button" class="close" data-dismiss="modal"
                                aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body text-center bg-info text-white">
                            ¿Est&aacute; seguro que desea recuperar esta solicitud?
                            <br />
                            <br />
                            <strong>
                                S&oacute;lo se puede recuperar si el horario
                                de esta solicitud no coincide con alguna ya
                                aprobada.
                            </strong>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                data-dismiss="modal">Cancelar</button>

                            <g:link action="restaurar" controller="solicitudes"
                                params="['solicitud.id': solicitud.id]"
                                class="btn btn-info">
                                Recuperar solicitud
                            </g:link>
                        </div>

                    </div>
                </div>
            </div>
        </g:each>



    </body>
</html>
