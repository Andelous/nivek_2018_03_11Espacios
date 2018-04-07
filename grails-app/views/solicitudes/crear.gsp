<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Crear solicitud</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-6 mx-auto">


                <h4 class="text-center">
                    <span class="oi oi-check"></span>&nbsp;
                    Registrar nueva solicitud
                </h4>

                <hr />


                <g:render template="/compartido/errores/erroresSolicitud" model="[solicitud: solicitud]"/>


                <g:form controller="solicitudes" action="crear" method="POST"
                    name="formulario">

                    <g:render template="/compartido/formularios/formularioSolicitud" model="[solicitud: solicitud]"/>

                    <input type="submit" name="Registrar" value="Registrar"
                        class="btn btn-primary btn-block">

                </g:form>

                <br />
                <br />
            </div>
        </div>
    </body>
</html>
