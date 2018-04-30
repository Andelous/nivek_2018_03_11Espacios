<%@ page import="com.nivek.sms.Rol" %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Asignar encargados a espacio</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-8 mx-auto">


                <h4 class="text-center">
                    <span class="oi oi-spreadsheet"></span>&nbsp;
                    Asignar encargados a espacio
                </h4>

                <small class="text-muted d-block text-center">
                    ${espacio} |
                    <strong>
                        ${espacio.horaInicioDisponible}
                    </strong>
                    -
                    <strong>
                        ${espacio.horaFinDisponible}
                    </strong>
                </small>

                <hr />


                <g:render template="/compartido/errores/erroresEspacio" model="[espacio: espacio]"/>


                <g:form controller="espacios" action="asignarEncargados" method="PUT"
                    name="formulario">

                    <input type="hidden" name="espacio.id" value="${espacio.id}">
                    <input type="hidden" name="ids" value="" id="inputIds">


                    <div class="row">
                        <div class="col-md">
                            <h5 class="text-center">Encargados disponibles</h5>
                            <hr />

                            <div id="divDisponibles">
                                <g:each in="${usuarios}" var="usuario1">
                                    <g:if test="${
                                        usuario1.authorities[0].authority == Rol.ENCARGADO_ESPACIOS &&
                                        !espacio.usuarios.contains(usuario1)
                                    }">
                                        <g:render template="/compartido/modelos/usuario" model="${[usuario: usuario1]}"/>
                                    </g:if>
                                </g:each>
                            </div>
                        </div>

                        <div class="col-md-2 text-center">
                            <strong>Acciones</strong>

                            <br />
                            <br />

                            <button type="button" name="button"
                                class="btn btn-block btn-sm btn-outline-primary pb-0"
                                onclick="cambiarCards('divDisponibles', 'divActuales')">
                                <span class="oi oi-arrow-thick-right"></span>
                            </button>

                            <br />

                            <button type="button" name="button"
                                class="btn btn-block btn-sm btn-outline-danger pb-0"
                                onclick="cambiarCards('divActuales', 'divDisponibles')">
                                <span class="oi oi-ban"></span>
                            </button>
                        </div>

                        <div class="col-md">
                            <h5 class="text-center">Encargados actuales</h5>
                            <hr />

                            <div id="divActuales">
                                <g:each in="${espacio.usuarios}" var="usuario1">
                                    <g:render template="/compartido/modelos/usuario" model="${[usuario: usuario1]}"/>
                                </g:each>
                            </div>
                        </div>
                    </div>

                    <br />
                    <br />

                    <input type="submit" name="Guardar" value="Guardar" onclick="crearString()"
                        class="btn btn-primary btn-block">

                </g:form>

                <br />
                <br />
            </div>
        </div>

        <script type="text/javascript">
            function cambioCheck() {
                var card = document.getElementById("cardUsuario" + this.getAttribute("idUsuario"));
                card.classList.toggle("border-primary", this.checked);

                var chk = this;

                if (this.checked) {
                    activos.push({
                        card: card,
                        check: this,
                        id: this.getAttribute("idUsuario")
                    });
                } else {
                    activos = activos.filter(function (val) {
                        return val.id != chk.getAttribute("idUsuario")
                    });
                }
            }

            function cambiarCards(origen, destino) {
                var divOrigen = document.getElementById(origen);
                var divDestino = document.getElementById(destino);

                var checks = [];

                for (i = 0; i < activos.length; i++) {
                    if (!divOrigen.contains(activos[i].card)) {
                        continue;
                    }

                    divOrigen.removeChild(activos[i].card);
                    divDestino.appendChild(activos[i].card);

                    activos[i].check.checked = false;
                    checks.push(activos[i].check);
                }

                checks.forEach(function (val) {
                    cambioCheck.call(val);
                });
            }

            function crearString() {
                var hidden = document.getElementById("inputIds");
                var divActuales = document.getElementById("divActuales");
                var hijos = divActuales.childNodes;

                var str = "";

                for (i = 0; i < hijos.length; i++) {
                    if (
                        hijos[i].nodeName == "DIV" &&
                        hijos[i].classList.contains("cardAndelous")
                    ) {
                        if (str.length > 0) {
                            str += ",";
                        }
                        str += hijos[i].getAttribute("idUsuario");
                    }
                }

                if (str.length == 0) {
                    str += "0";
                }

                hidden.value = str;
            }

            var chksAndelous = document.getElementsByClassName("chkAndelous");

            var activos = [];

            for (i = 0; i < chksAndelous.length; i++) {
                chksAndelous[i].addEventListener("change", cambioCheck);
            }
        </script>
    </body>
</html>
