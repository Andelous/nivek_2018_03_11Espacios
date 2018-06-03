<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Generaci&oacute;n de reportes</title>
    </head>
    <body>

        <h4 class="text-center">
            <span class="oi oi-clipboard"></span>
            Reportes
        </h4>

        <hr />











        <g:form action="index" method="GET" controller="reportes">
            <div class="row">
                <div class="col-md">
                    <div class="form-group">
                        <label>Nombre de la persona que hizo la solicitud</label>

                        <input type="text"
                            name="nombrePersona"
                            value="${nombrePersona}"
                            class="form-control form-control-sm"
                            maxlength=200 />
                    </div>
                </div>

                <div class="col-md">

                    <div class="form-group">
                        <label>Espacio</label>

                        <select class="form-control form-control-sm" id="selectEspacio"
                            name="espacio.id">
                            <option>Todos</option>
                            <g:each in="${espaciosLista}" var="espacio">
                                <option value="${espacio.id}"
                                    ${espacio.id.toString() == params['espacio.id'] ? "selected" : ""}>
                                    ${espacio}
                                </option>
                            </g:each>
                        </select>
                    </div>

                </div>
            </div>

            <div class="row">
                <div class="col-md">
                    <div class="form-group">
                        <label>Fecha m&iacute;nima de la consulta <code>(MES/DIA/A&Ntilde;O)</code></label>
                        <input
                            type="hidden"
                            name="inicio"
                            id="inicioHidden" />

                        <input type="date"
                            id="inicioInput"
                            value="${
                                (inicio ?: (new Date() - 1)).
                                format('yyyy-MM-dd')
                            }"
                            class="form-control form-control-sm"
                            required />
                    </div>
                </div>

                <div class="col-md">
                    <div class="form-group">
                        <label>Fecha m&aacute;xima de la consulta <code>(MES/DIA/A&Ntilde;O)</code></label>
                        <input
                            type="hidden"
                            name="fin"
                            id="finHidden" />

                        <input type="date"
                            id="finInput"
                            value="${
                                (fin ?: new Date()).
                                format('yyyy-MM-dd')
                            }"
                            class="form-control form-control-sm"
                            required />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md">

                </div>
                <div class="col-md">
                    <input type="submit" class="btn btn-block btn-primary" value="Generar">
                </div>
                <div class="col-md">

                </div>
            </div>
        </g:form>



        <div class="row">
            <div class="col-md">

            </div>
            <div class="col-md">

            </div>
            <div class="col-md-2">
                <button class="btn btn-primary btn-block" onclick="print()">
                    <span class="oi oi-print"></span> Imprimir
                </button>
            </div>
        </div>

        <br />
        
        <g:if test="${params.errorAcceso}">
            <div class="alert alert-danger">
                <h5 class="alert-heading">
                    <strong>Error</strong>
                </h5>
                No tienes permiso para ver, crear o modificar los datos de otras
                instituciones y/o usuarios.
            </div>
        </g:if>


        <table class="table table-hover">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Espacio</th>
                    <th scope="col">Fecha y hora</th>
                    <th scope="col">Solicitante</th>
                    <th scope="col">Raz&oacute;n</th>
                    <th scope="col">Material</th>
                    <th scope="col">Estado</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${solicitudesLista}" var="solicitud">
                    <%@ page import="com.nivek.sms.SolicitudEstado" %>
                    <g:set var="cancelada" value="${false}" />
                    <g:set var="aprobada" value="${false}" />
                    <g:set var="enRevision" value="${false}" />
                    <g:set var="rechazadaEncargado" value="${false}" />
                    <g:set var="rechazadaSistema" value="${false}" />

                    <g:set var="cancelada" value="${solicitud?.estado?.nombre == SolicitudEstado.CANCELADA_USUARIO}" />
                    <g:set var="aprobada" value="${solicitud?.estado?.nombre == SolicitudEstado.APROBADA}" />
                    <g:set var="enRevision" value="${solicitud?.estado?.nombre == SolicitudEstado.EN_REVISION}" />
                    <g:set var="rechazadaEncargado" value="${solicitud?.estado?.nombre == SolicitudEstado.RECHAZADA_ENCARGADO}" />
                    <g:set var="rechazadaSistema" value="${solicitud?.estado?.nombre == SolicitudEstado.RECHAZADA_SISTEMA}" />

                    <tr>
                        <td scope="row"><strong>${solicitud.espacio}</strong></td>
                        <td>
                            <strong>${solicitud.fecha.format("yyyy-MM-dd")}</strong>,
                            de
                            <strong>${solicitud.horaInicio}</strong>
                            a
                            <strong>${solicitud.horaFin}</strong>
                        </td>
                        <td>${solicitud.usuario.persona}</td>
                        <td>${solicitud.razon}</td>
                        <td>${solicitud.material}</td>
                        <td>
                            <i class="
                                ${cancelada ? 'text-danger' : ''}
                                ${aprobada ? 'text-success' : ''}
                                ${rechazada ? 'text-muted' : ''}
                            ">
                                ${solicitud.estado}
                            </i>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>

        <br />
        <br />


        <script type="text/javascript">
            // Fechas...
            var inicioInput = document.getElementById("inicioInput");
            var inicioHidden = document.getElementById("inicioHidden");

            var finInput = document.getElementById("finInput");
            var finHidden = document.getElementById("finHidden");

            function crearDates() {
                inicioHidden.value =
                    inicioInput.value + " 00:00:00.0";
                finHidden.value =
                    finInput.value + " 00:00:00.0";
            }

            inicioInput.addEventListener("change", crearDates);
            finInput.addEventListener("change", crearDates);

            crearDates();
        </script>
    </body>
</html>
