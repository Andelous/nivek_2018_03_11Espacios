
<div class="form-group">
    <label>Raz&oacute;n</label>

    <input type="text"
        name="solicitud.razon"
        value="${solicitud?.razon}"
        class="form-control form-control-sm"
        maxlength=200
        required />
</div>

<div class="row">

    <div class="col-md">
        <div class="form-group">
            <label>Fecha <code>(MES/DIA/A&Ntilde;O)</code></label>
            <input
                type="hidden"
                name="solicitud.fecha"
                id="fechaHidden" />

            <input type="date"
                id="fechaInput"
                value="${
                    solicitud?.fecha?.format('yyyy-MM-dd') ?:
                    (new Date()).format('yyyy-MM-dd')}"
                min="${(new Date()).format('yyyy-MM-dd')}"
                class="form-control form-control-sm"
                required />
        </div>

        <div class="form-group">
            <label>Hora de entrada</label>

            <input type="time"
                id="horaInicio"
                name="solicitud.horaInicio"
                value="${solicitud?.horaInicio}"
                class="form-control form-control-sm"
                required />
        </div>

        <div class="form-group">
            <label>Hora de t&eacute;rmino</label>

            <input type="time"
                id="horaFin"
                name="solicitud.horaFin"
                value="${solicitud?.horaFin}"
                class="form-control form-control-sm"
                required />
        </div>
    </div>

    <div class="col-md">

        <div class="form-group">
            <label>Espacio</label>

            <select class="form-control form-control-sm" id="selectEspacio"
                name="solicitud.espacio.id" onchange="mostrarDivActivo(this)">
                <g:each in="${flash.espaciosLista}" var="espacio">
                    <option value="${espacio.id}"
                        ${espacio.id == solicitud?.espacio?.id ? "selected" : ""}
                        horainicio="${espacio.horaInicioDisponible}"
                        horafin="${espacio.horaFinDisponible}">
                        ${espacio}
                    </option>
                </g:each>
            </select>
        </div>

        <g:set var="diaD" value="font-weight-bold text-primary" />
        <g:set var="diaND" value="text-muted" />

        <g:each in="${flash.espaciosLista}" var="espacio">
            <div id="divEspacio${espacio.id}" class="d-none divespacio">
                <div class="card text-center">
                    <div class="card-header">
                        <strong>${espacio}</strong>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            Horario:
                            <strong>${espacio.horaInicioDisponible}</strong>
                            -
                            <strong>${espacio.horaFinDisponible}</strong>
                        </p>
                        <p>
                            <span class="${espacio.dias[0] == '1' ? diaD : diaND}">L</span>
                            <span class="${espacio.dias[1] == '1' ? diaD : diaND}">M</span>
                            <span class="${espacio.dias[2] == '1' ? diaD : diaND}">M</span>
                            <span class="${espacio.dias[3] == '1' ? diaD : diaND}">J</span>
                            <span class="${espacio.dias[4] == '1' ? diaD : diaND}">V</span>
                            <span class="${espacio.dias[5] == '1' ? diaD : diaND}">S</span>
                            <span class="${espacio.dias[6] == '1' ? diaD : diaND}">D</span>
                        </p>
                    </div>
                </div>
            </div>
        </g:each>
    </div>
</div>

<div class="form-group">
    <label>Material requerido</label>
    <textarea name="solicitud.material"
        class="form-control form-control-sm"
        maxlength=250
        rows=3>${solicitud?.material}</textarea>
</div>

<br />

<script type="text/javascript">
    function mostrarDivActivo(e) {
        var opcion = e.options[e.selectedIndex];
        var id = opcion.value;

        var divsEspacios = document.getElementsByClassName("divespacio");

        for (i = 0; i < divsEspacios.length; i++) {
            var flag = divsEspacios[i].id == ("divEspacio" + id.toString());

            divsEspacios[i].classList.toggle("d-block", flag);
            divsEspacios[i].classList.toggle("d-none", !flag);
        }

        horaInicio.setAttribute("min", opcion.getAttribute("horainicio"));
        horaInicio.setAttribute("max", opcion.getAttribute("horafin"));

        horaFin.setAttribute("min", opcion.getAttribute("horainicio"));
        horaFin.setAttribute("max", opcion.getAttribute("horafin"));
    }

    // Fechas...
    var fechaInput = document.getElementById("fechaInput");
    var fechaHidden = document.getElementById("fechaHidden");

    function crearDates() {
        fechaHidden.value =
            fechaInput.value + " 00:00:00.0";
    }

    fechaInput.addEventListener("change", crearDates);

    // Horas...
    var horaInicio = document.getElementById("horaInicio");
    var horaFin = document.getElementById("horaFin");


    // Acciones iniciales
    mostrarDivActivo(document.getElementById("selectEspacio"));
    crearDates();
</script>
