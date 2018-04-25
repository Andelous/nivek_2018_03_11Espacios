<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Espacios</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-10">

                <div class="row">

                    <h4 class="col-md-8 mb-0 text-center">
                        <span class="oi oi-spreadsheet"></span>
                        Listado de espacios de mi instituci&oacute;n
                    </h4>

                    <div class="col-md mb-0 ml-auto">
                        <g:form action="index" method="GET" class="form-inline">
                            <div class="input-group col-md">
                                <input type="text" name="q"
                                    class="form-control form-control-sm"
                                    placeholder="Nombre"
                                    aria-describedby="basic-addon2"
                                    value="${q}" maxlength=50>

                                    <div class="input-group-append">
                                        <button type="submit" class="btn btn-outline-secondary btn-sm">
                                            <small><span class="oi oi-magnifying-glass"></span></small>
                                        </button>
                                    </div>
                            </div>
                        </g:form>
                    </div>
                </div>


            </div>



            <div class="col-md-2 border border-top-0 border-bottom-0 border-right-0">
                <g:link controller="espacios" action="crear"
                    class="btn btn-primary btn-sm btn-block">
                    <span class="oi oi-plus"></span> Nuevo espacio
                </g:link>
            </div>
        </div>

        <hr />

        <g:if test="${params.creado}">
            <div class="alert alert-success">
                Espacio creado con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.actualizado}">
            <div class="alert alert-info">
                Espacio modificado con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.eliminado}">
            <div class="alert alert-warning">
                Espacio eliminado con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.errorAcceso}">
            <div class="alert alert-danger">
                <h5 class="alert-heading">
                    <strong>Error</strong>
                </h5>
                No tienes permiso para ver, crear o modificar los datos de otras
                instituciones y/o usuarios.
            </div>
        </g:if>


        <table class="table table-hover">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Nombre</th>
                    <th scope="col">Horarios</th>
                    <th scope="col">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <g:set var="diaD" value="font-weight-bold text-primary" />
                <g:set var="diaND" value="text-muted" />

                <g:each in="${espaciosLista}" var="espacio">
                    <tr>
                        <th scope="row">${espacio.nombre}</th>
                        <td>
                            ${espacio.horaInicioDisponible} a ${espacio.horaFinDisponible}
                            -
                            <span class="${espacio.dias[0] == '1' ? diaD : diaND}">L</span>
                            <span class="${espacio.dias[1] == '1' ? diaD : diaND}">M</span>
                            <span class="${espacio.dias[2] == '1' ? diaD : diaND}">M</span>
                            <span class="${espacio.dias[3] == '1' ? diaD : diaND}">J</span>
                            <span class="${espacio.dias[4] == '1' ? diaD : diaND}">V</span>
                            <span class="${espacio.dias[5] == '1' ? diaD : diaND}">S</span>
                            <span class="${espacio.dias[6] == '1' ? diaD : diaND}">D</span>
                        </td>
                        <td>
                            <g:link class="btn btn-link btn-sm text-dark"
                                controller="espacios" action="editar"
                                params="['espacio.id': espacio.id]">
                                <span class="oi oi-pencil text-primary"></span>
                                Editar
                            </g:link>
                            <a href="#" class="btn btn-link btn-sm text-dark"
                                data-toggle="modal" data-target="#modal${espacio.id}">
                                <span class="oi oi-circle-x text-danger"></span>
                                Eliminar
                            </a>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>

        <g:render template="/compartido/paginacion" />

        <br />
        <br />


        <g:each in="${espaciosLista}" var="espacio">
            <div class="modal fade" id="modal${espacio.id}" tabindex="-1"
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
                            ¿Est&aacute; seguro que desea eliminar el espacio
                            ${espacio}?
                            <br />
                            <br />
                            <strong>Estas acciones no pueden revertirse.</strong>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                data-dismiss="modal">Cancelar</button>

                            <g:link action="eliminar" controller="espacios"
                                params="['espacio.id': espacio.id]"
                                class="btn btn-danger">
                                Eliminar
                            </g:link>
                        </div>

                    </div>
                </div>
            </div>
        </g:each>
    </body>
</html>
