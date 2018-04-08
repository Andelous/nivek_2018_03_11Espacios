<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Mis solicitudes</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-10">

                <div class="row">

                    <h4 class="col-md-8 mb-0 text-center">
                        <span class="oi oi-check"></span>
                        Listado de solicitudes
                    </h4>

                    <div class="col-md mb-0 ml-auto">
                        <g:form action="misSolicitudes" method="GET" class="form-inline w-100">
                            <div class="form-group">
                                <label>Espacios</label>&nbsp;
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


            </div>



            <div class="col-md-2 border border-top-0 border-bottom-0 border-right-0">
                <g:link controller="solicitudes" action="crear"
                    class="btn btn-primary btn-sm btn-block"
                    params="['espacio.id': espacio?.id]">
                    <span class="oi oi-plus"></span> Nueva solicitud
                </g:link>
            </div>
        </div>

        <hr />

        <g:if test="${params.creada}">
            <div class="alert alert-success">
                Solicitud creada con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.actualizada}">
            <div class="alert alert-info">
                Solicitud modificada con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.cancelada}">
            <div class="alert alert-warning">
                Solicitud cancelada con &eacute;xito
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
                        <td>${solicitud.razon}</td>
                        <td>
                            <i class="
                                ${cancelada ? 'text-danger' : ''}
                                ${aprobada ? 'text-success' : ''}
                                ${rechazadaEncargado || rechazadaSistema ? 'text-muted' : ''}
                            ">
                                ${solicitud.estado}
                            </i>
                        </td>
                        <td>
                            <g:link class="btn btn-link btn-sm text-dark
                                ${enRevision ? '' : 'disabled'}"
                                controller="solicitudes" action="editar"
                                params="['solicitud.id': solicitud.id]">
                                <span class="oi oi-pencil text-primary"></span>
                                Editar
                            </g:link>
                            <a href="#" class="btn btn-link btn-sm text-dark
                                ${aprobada || enRevision ? '' : 'disabled'}"
                                data-toggle="modal" data-target="#modal${solicitud.id}">
                                <span class="oi oi-circle-x text-danger"></span>
                                Cancelar
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
            <div class="modal fade" id="modal${solicitud.id}" tabindex="-1"
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
                            ¿Est&aacute; seguro que desea cancelar su solicitud?
                            <br />
                            <br />
                            <strong>Estas acciones no pueden revertirse.</strong>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                data-dismiss="modal">Regresar</button>

                            <g:link action="cancelar" controller="solicitudes"
                                params="['solicitud.id': solicitud.id]"
                                class="btn btn-danger">
                                Cancelar solicitud
                            </g:link>
                        </div>

                    </div>
                </div>
            </div>
        </g:each>
    </body>
</html>
