<!doctype html>
<html>

    <head>

        <meta name="layout" content="main" />
        <title>Iniciar sesi&oacute;n</title>

    </head>

    <body>

        <g:if
        test="${params.login_error == '1'}">
            <div
            class="alert alert-danger mx-auto text-center"
            style="max-width: 25rem;">
                Datos incorrectos, intente nuevamente.
            </div>
        </g:if>

        <div
        class="card mx-auto"
        style="max-width:25rem;">
            <div
            class="card-header">
                <div
                class="w-100 text-center">

                    <asset:image
                    src="s.png"
                    width="200"
                    height="auto" />

                    <br />

                    <h4>
                        <strong>
                            Space Management System
                        </strong>
                    </h4>

                </div>
            </div>

            <div
            class="card-body">
                <g:form
                controller="login"
                action="authenticate"
                method="POST">

                    <div
                    class="input-group mb-3">

                        <div
                        class="input-group-prepend">

                            <span
                            class="input-group-text">
                                <span class="oi oi-person"></span>
                            </span>

                        </div>

                        <input
                            type="text"
                            class="form-control"
                            maxlength=50
                            minlength=4
                            placeholder="Usuario"
                            name="username"
                            required>

                    </div>

                    <div
                    class="input-group mb-3">

                        <div
                        class="input-group-prepend">

                            <span
                            class="input-group-text">
                                <span class="oi oi-shield"></span>
                            </span>

                        </div>

                        <input type="password"
                            class="form-control"
                            placeholder="Contrase&ntilde;a"
                            minlength="4"
                            maxlength="50"
                            name="password"
                            required>

                    </div>



                    <button
                    type="submit"
                    class="btn btn-primary btn-block w-75 mx-auto">
                        Iniciar sesi&oacute;n
                    </button>
                </g:form>
            </div>
        </div>

    </body>
</html>
