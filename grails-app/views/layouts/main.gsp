<!doctype html>
<html lang="es">

    <head>
        <meta charset="utf-8">

        <title>
            SmS - <g:layoutTitle default="Bienvenido" />
        </title>

        <!-- Etiqueta de Bootstrap -->
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
        <asset:stylesheet src="application.css" />

        <g:layoutHead/>
    </head>

<body>
    <g:render template="/layouts/header" />

    <br />

    <div class="container">
        <g:layoutBody />
    </div>

    <br />
    <br />

    <g:render template="/layouts/footer" />
    <asset:javascript src="application.js" />
</body>

</html>
