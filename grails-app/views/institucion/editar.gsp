<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Modificar Institucion</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-6 mx-auto">


                <h4 class="text-center">
                    <span class="oi oi-person"></span>&nbsp;
                     Modificar Institucion
                </h4>
                <small class="text-muted d-block text-center">
                    <strong>${institucion?.nombre}</strong> - ${institucion?.nombre}
                </small>

                <hr />


                <g:render template="/compartido/errores/erroresInstitucion" model="[institucion: institucion]"/>


                <g:form controller="institucion" action="editar" method="PUT"
                    name="formulario">

                    <input type="hidden" name="institucion.id" value="${institucion?.id}">

                    <g:render template="/compartido/formularios/formularioInstitucion" model="[institucion: institucion]"/>

                    <input type="submit" name="Actualizar" value="Actualizar"
                        class="btn btn-primary btn-block">

                </g:form>

                <br />
                <br />
            </div>
        </div>
    </body>
</html>
