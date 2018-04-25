<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Crear espacio</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-6 mx-auto">


                <h4 class="text-center">
                    <span class="oi oi-spreadsheet"></span>&nbsp;
                    Registrar nuevo espacio
                </h4>

                <hr />


                <g:render template="/compartido/errores/erroresEspacio" model="[espacio: espacio]"/>


                <g:form controller="espacios" action="crear" method="POST"
                    name="formulario">

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
