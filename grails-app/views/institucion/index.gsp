<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>institucion</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-10">

                <div class="row">

                    <h4 class="col-md-5 mb-0 text-center">
                        <span class="oi oi-people"></span>
                        Listado de instituciones
                    </h4>

                    <div class="col-md mb-0 ml-auto">
                        <g:form action="index" method="GET" class="form-inline w-100">
                            <div class="input-group col-md">
                                <input type="text" name="q"
                                    class="form-control form-control-sm"
                                    placeholder="Nombre"
                                    aria-describedby="basic-addon2"
                                    value="${q}">

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
                <g:link controller="institucion" action="crear"
                    class="btn btn-primary btn-sm btn-block">
                    <span class="oi oi-plus"></span> Nueva institución
                </g:link>
            </div>
        </div>

        <hr />

        <g:if test="${params.creado}">
            <div class="alert alert-success">
                Institución  creada con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.actualizado}">
            <div class="alert alert-info">
                Institución modificada con &eacute;xito
            </div>
        </g:if>

        <g:if test="${params.eliminado}">
            <div class="alert alert-warning">
                Institución eliminada con &eacute;xito
            </div>
        </g:if>


        <table class="table">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Nombre</th>
                    <th scope="col">Lugar</th>
                    <th scope="col">Actividad</th>
                    <th scope="col">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${institucionesLista}" var="institucion">
                    <tr>
                        <td scope="row"><strong>${institucion.nombre}</strong></td>
                        <td>${institucion.direccion}</td>
                        <td><strong>${institucion.activa?"Disponible":"No disponible"}</strong></td>
                        <td>
                            <g:link class="btn btn-link btn-sm text-dark"
                                controller="institucion" action="editar"
                                params="['institucion.id': institucion.id]">
                                <span class="oi oi-pencil text-primary"></span>
                                Editar
                            </g:link>
                            <a href="#" class="btn btn-link btn-sm text-dark"
                                data-toggle="modal" data-target="#modal${institucion.id}">
                                <span class="oi oi-circle-x text-danger"></span>
                                Eliminar
                            </a>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>


       
    </body>
</html>
