<sec:ifLoggedIn>
    <nav class="navbar navbar-expand-md navbar-light bg-light">
        <a class="navbar-brand border border-secondary border-left-0 border-top-0 border-bottom-0" href="#">
            <asset:image
            src="s.png"
            width="30px"
            height="auto"
            class="d-inline-block align-top" />
            <strong>&nbsp;Space M. S.&nbsp;&nbsp;&nbsp;</strong>
        </a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCabecera" aria-expanded="false" aria-label="Navegaci&oacute;n">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarCabecera">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <g:link controller="usuarios" class="nav-link">
                        <span class="oi oi-people"></span> Usuarios
                    </g:link>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="# ">
                        <span class="oi oi-briefcase"></span> Instituciones
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="# ">
                        <span class="oi oi-spreadsheet"></span> Espacios
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="# ">
                        <span class="oi oi-check"></span> Solicitudes
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="# ">
                        <span class="oi oi-calendar"></span> Calendario
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="# ">
                        <span class="oi oi-clipboard"></span> Reportes
                    </a>
                </li>

            </ul>

            <div class="btn-group">
                <a href="#" class="btn btn-sm btn-info">
                    Bienvenido, <strong>Administrador</strong>
                </a>
                <a href="${request.contextPath}/logoff" class="btn btn-outline-danger btn-sm">Cerrar sesi&oacute;n</a>
            </div>
        </div>
        <!--</div>-->
    </nav>
</sec:ifLoggedIn>
