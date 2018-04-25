
<div class="form-group">
    <label>Nombre</label>

    <input type="text"
        name="espacio.nombre"
        value="${espacio?.nombre}"
        class="form-control form-control-sm"
        maxlength=100
        required />
</div>

<div class="row">
    <div class="col-md">
        <div class="form-group">
            <label>Hora de inicio de disponibilidad</label>

            <input type="time"
                id="horaInicioDisponible"
                name="espacio.horaInicioDisponible"
                value="${espacio?.horaInicioDisponible}"
                class="form-control form-control-sm"
                required />
        </div>
    </div>

    <div class="col-md">
        <div class="form-group">
            <label>Hora de t&eacute;rmino de disponibilidad</label>

            <input type="time"
                id="horaFinDisponible"
                name="espacio.horaFinDisponible"
                value="${espacio?.horaFinDisponible}"
                class="form-control form-control-sm"
                required />
        </div>
    </div>
</div>



<div class="row">
    <div class="col-md">

    </div>

    <div class="col-md">
        <p class="text-center">D&iacute;as de disponibilidad</p>

        <div class="btn-group btn-group-toggle" data-toggle="buttons">
            <label class="btn btn-outline-info andelous-lbl-chk">
                <input type="checkbox" name="options" id="option1" autocomplete="off" class="andelous-chk"> Lun.
            </label>
            <label class="btn btn-outline-info andelous-lbl-chk">
                <input type="checkbox" name="options" id="option2" autocomplete="off" class="andelous-chk"> Mar.
            </label>
            <label class="btn btn-outline-info andelous-lbl-chk">
                <input type="checkbox" name="options" id="option3" autocomplete="off" class="andelous-chk"> Mi&eacute;.
            </label>
            <label class="btn btn-outline-info andelous-lbl-chk">
                <input type="checkbox" name="options" id="option3" autocomplete="off" class="andelous-chk"> Jue.
            </label>
            <label class="btn btn-outline-info andelous-lbl-chk">
                <input type="checkbox" name="options" id="option3" autocomplete="off" class="andelous-chk"> Vie.
            </label>
            <label class="btn btn-outline-info andelous-lbl-chk">
                <input type="checkbox" name="options" id="option3" autocomplete="off" class="andelous-chk"> S&aacute;b.
            </label>
            <label class="btn btn-outline-info andelous-lbl-chk">
                <input type="checkbox" name="options" id="option3" autocomplete="off" class="andelous-chk"> Dom.
            </label>
        </div>

        <input type="hidden" name="espacio.dias" id="diasEspacio" value="${espacio?.dias}">
    </div>

    <div class="col-md">

    </div>

</div>

<br />

<script type="text/javascript">
    // Horas...
    var horaInicio = document.getElementById("horaInicio");
    var horaFin = document.getElementById("horaFin");

    var labels = document.getElementsByClassName("andelous-lbl-chk");
    var checks = document.getElementsByClassName("andelous-chk");

    var inputDias = document.getElementById("diasEspacio");

    for (var i = 0; i < labels.length; i++) {
        labels[i].addEventListener("click", timerIterar);
    }

    function iterar() {
        var str = "";

        for (var i = 0; i < checks.length; i++) {
            console.log(i, checks[i].checked);
            str += checks[i].checked ? "1" : "0";
        }

        inputDias.value = str;
    }

    function timerIterar() {
        setTimeout(iterar, 200);
    }

    function inicializarDias() {
        var str = "${espacio ? espacio.dias : '1111100'}";

        for (var i = 0; i < labels.length; i++) {
            if (str[i] == "1") {
                labels[i].classList.toggle("active", true);
                checks[i].setAttribute("checked", "checked");
            }
        }
    }

    inicializarDias();
</script>
