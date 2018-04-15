<!DOCTYPE html>

<sec:ifLoggedIn>
    <%@ page import="com.nivek.sms.Usuario" %>

    <g:set var="idUsuario">
        <sec:loggedInUserInfo field="id" />
    </g:set>

    <g:set var="usuarioLog" value="${Usuario.get(idUsuario.trim())}" />
    <g:set var="rolLog" value="${usuarioLog.authorities[0]}" />
</sec:ifLoggedIn>

<html lang="es">

    <head>
        <meta charset="utf-8">

        <title>
            SmS - <g:layoutTitle default="Bienvenido" />
        </title>

        <!-- Etiqueta de Bootstrap -->
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
        <asset:stylesheet src="application.css"/>

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

    <script type="text/javascript">
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
    </script>
</body>

</html>
