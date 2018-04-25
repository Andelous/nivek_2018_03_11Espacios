<sec:ifLoggedIn>
    <nav class="navbar navbar-expand-md navbar-light bg-light">
        <a class="navbar-brand border border-secondary border-left-0 border-top-0 border-bottom-0" href="${request.contextPath}">
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
                    <g:link controller="institucion" class="nav-link">
                        <span class="oi oi-briefcase"></span> Instituciones
                    </g:link>
                </li>

                <li class="nav-item">
                    <g:link controller="espacios" class="nav-link">
                        <span class="oi oi-spreadsheet"></span> Espacios
                    </g:link>
                </li>

                <li class="nav-item">
                    <g:link controller="solicitudes" class="nav-link">
                        <span class="oi oi-check"></span> Solicitudes
                    </g:link>
                </li>

                <li class="nav-item">
                    <g:link controller="calendario" class="nav-link">
                        <span class="oi oi-calendar"></span> Calendario
                    </g:link>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="# ">
                        <span class="oi oi-clipboard"></span> Reportes
                    </a>
                </li>

            </ul>

            <%@ page import="com.nivek.sms.Rol" %>

            <div class="btn-group">
                <a href="#" class="btn btn-sm
                    ${
                        rolLog.authority == Rol.ADMINISTRADOR_GENERAL ?
                            'btn-info' :
                        rolLog.authority == Rol.ADMINISTRADOR_INSTITUCION ?
                            'btn-primary' :
                        rolLog.authority == Rol.ENCARGADO_ESPACIOS ?
                            'btn-secondary' :
                        rolLog.authority == Rol.BENEFICIARIO_INSTITUCION ?
                            'btn-success' :
                        rolLog.authority == Rol.VISOR_INSTITUCION ?
                            'btn-warning' : 'btn-dark'
                    }"
                    data-toggle="tooltip" data-placement="bottom"
                    title="${rolLog}${usuarioLog.institucion ? ' (' + usuarioLog.institucion + ')' : '' }">
                    Bienvenido, <strong>${usuarioLog.persona.nombres}</strong>
                </a>
                <a href="${request.contextPath}/logoff" class="btn btn-outline-danger btn-sm">Cerrar sesi&oacute;n</a>
            </div>
        </div>
        <!--</div>-->
    </nav>
</sec:ifLoggedIn>
