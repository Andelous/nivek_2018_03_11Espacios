<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Modificar espacio</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-6 mx-auto">


                <h4 class="text-center">
                    <span class="oi oi-spreadsheet"></span>&nbsp;
                    Modificar espacio
                </h4>

                <small class="text-muted d-block text-center">
                    ${espacio} |
                    <strong>
                        ${espacio.horaInicioDisponible}
                    </strong>
                    -
                    <strong>
                        ${espacio.horaFinDisponible}
                    </strong>
                </small>

                <hr />


                <g:render template="/compartido/errores/erroresEspacio" model="[espacio: espacio]"/>


                <g:form controller="espacios" action="editar" method="PUT"
                    name="formulario">

                    <input type="hidden" name="espacio.id" value="${espacio.id}">

                    <g:render template="/compartido/formularios/formularioEspacio" model="[espacio: espacio]"/>

                    <input type="submit" name="Registrar" value="Registrar"
                        class="btn btn-primary btn-block">

                </g:form>

                <br />
                <br />
            </div>
        </div>
    </body>
</html>
