<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Modificar usuario</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-6 mx-auto">


                <h4 class="text-center">
                    <span class="oi oi-person"></span>&nbsp;
                     Modificar usuario
                </h4>
                <small class="text-muted d-block text-center">
                    <strong>${usuario.username}</strong> - ${usuario.persona}
                </small>

                <hr />


                <g:render template="/compartido/errores/erroresUsuario" model="[usuario: usuario, rol: rol]"/>


                <g:form controller="usuarios" action="editar" method="PUT"
                    name="formulario">

                    <input type="hidden" name="usuario.id" value="${usuario?.id}">

                    <g:render template="/compartido/formularios/formularioUsuario" model="[usuario: usuario, rol: rol]"/>

                    <input type="submit" name="Actualizar" value="Actualizar"
                        class="btn btn-primary btn-block">

                </g:form>

                <br />
                <br />
            </div>
        </div>
    </body>
</html>
