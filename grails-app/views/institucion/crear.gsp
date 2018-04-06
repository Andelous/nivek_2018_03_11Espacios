<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Crear Institucion</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-6 mx-auto">


                <h4 class="text-center">
                    <span class="oi oi-person"></span>&nbsp;
                    Registrar nueva Institucion
                </h4>

                <hr />


                <g:render template="/compartido/errores/erroresInstitucion" model="[institucion: institucion]"/>


                <g:form controller="institucion" action="crear" method="POST"
                    name="formulario">

                    <g:render template="/compartido/formularios/formularioInstitucion" model="[institucion: institucion]"/>

                    <input type="submit" name="Registrar" value="Registrar"
                        class="btn btn-primary btn-block">

                </g:form>

                <br />
                <br />
            </div>
        </div>
    </body>
</html>
