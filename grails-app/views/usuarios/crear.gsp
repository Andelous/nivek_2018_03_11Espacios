<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Crear usuario</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-6 mx-auto">


                <h4 class="text-center">
                    <span class="oi oi-person"></span>&nbsp;
                    Registrar nuevo usuario
                </h4>

                <hr />


                <g:render template="/compartido/errores/erroresUsuario" model="[usuario: usuario, rol: rol]"/>


                <g:form controller="usuarios" action="crear" method="POST"
                    name="formulario">

                    <g:render template="/compartido/formularios/formularioUsuario" model="[usuario: usuario, rol: rol]"/>

                    <input type="submit" name="Registrar" value="Registrar"
                        class="btn btn-primary btn-block">

                </g:form>

                <br />
                <br />
            </div>
        </div>
    </body>
</html>
