<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Modificar solicitud</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-6 mx-auto">


                <h4 class="text-center">
                    <span class="oi oi-check"></span>&nbsp;
                    Modificar solicitud
                </h4>

                <small class="text-muted">
                    <strong>${solicitud?.espacio}</strong>
                    -
                    <i>${solicitud.fecha.format("yyyy-MM-dd")}</i>,
                    de
                    <strong>${solicitud.horaInicio}</strong>
                    a
                    <strong>${solicitud.horaFin}</strong>
                </small>

                <hr />


                <g:render template="/compartido/errores/erroresSolicitud" model="[solicitud: solicitud]"/>


                <g:form controller="solicitudes" action="editar" method="PUT"
                    name="formulario">

                    <input type="hidden" name="solicitud.id" value="${solicitud?.id}">

                    <g:render template="/compartido/formularios/formularioSolicitud" model="[solicitud: solicitud]"/>

                    <input type="submit" name="Actualizar" value="Actualizar"
                        class="btn btn-primary btn-block">

                </g:form>

                <br />
                <br />
            </div>
        </div>
    </body>
</html>
