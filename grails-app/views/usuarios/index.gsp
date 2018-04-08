<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Usuarios</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-10">

                <div class="row">

                    <h4 class="col-md-5 mb-0 text-center">
                        <span class="oi oi-people"></span>
                        Listado de usuarios
                    </h4>

                    <div class="col-md mb-0 ml-auto">
                        <g:form action="index" method="GET" class="form-inline w-100">
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

                            <div class="form-group">
                                <label>Instituci&oacute;n</label>&nbsp;
                                <select class="form-control form-control-sm"
                                    id="selectRol" name="institucion.id"
                                    onchange="submit()">
                                    <option value="">Todas</option>
                                    <g:each in="${institucionesLista}" var="i">
                                        <option value="${i.id}"
                                            ${ i.id == institucion?.id ? "selected" : ""}>
                                            ${i}
                                        </option>
                                    </g:each>
                                </select>
                            </div>
                        </g:form>
                    </div>
                </div>


            </div>



            <div class="col-md-2 border border-top-0 border-bottom-0 border-right-0">
                <g:link controller="usuarios" action="crear"
                    class="btn btn-primary btn-sm btn-block"
                    params="['usuario.institucion.id': institucion?.id]">
                    <span class="oi oi-plus"></span> Nuevo usuario
                </g:link>
            </div>
        </div>

        <hr />

        <g:if test="${params.creado}">
            <div class="alert alert-success">
                Usuario creado con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.actualizado}">
            <div class="alert alert-info">
                Usuario modificado con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.eliminado}">
            <div class="alert alert-warning">
                Usuario eliminado con &eacute;xito
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
                    <th scope="col">Usuario</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Rol</th>
                    <th scope="col">Instituci&oacute;n</th>
                    <th scope="col">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${usuariosLista}" var="usuario">
                    <tr>
                        <td scope="row"><strong>${usuario.username}</strong></td>
                        <td>${usuario.persona}</td>
                        <td>${usuario.authorities[0]}</td>
                        <td><strong>${usuario.institucion ?: "Sin institución"}</strong></td>
                        <td>
                            <g:link class="btn btn-link btn-sm text-dark"
                                controller="usuarios" action="editar"
                                params="['usuario.id': usuario.id]">
                                <span class="oi oi-pencil text-primary"></span>
                                Editar
                            </g:link>
                            <a href="#" class="btn btn-link btn-sm text-dark"
                                data-toggle="modal" data-target="#modal${usuario.id}">
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


        <g:each in="${usuariosLista}" var="usuario">
            <div class="modal fade" id="modal${usuario.id}" tabindex="-1"
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
                            ¿Est&aacute; seguro que desea eliminar el usuario
                            ${usuario.persona}?
                            <br />
                            <br />
                            <strong>Estas acciones no pueden revertirse.</strong>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                data-dismiss="modal">Cancelar</button>

                            <g:link action="eliminar" controller="usuarios"
                                params="['usuario.id': usuario.id]"
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
