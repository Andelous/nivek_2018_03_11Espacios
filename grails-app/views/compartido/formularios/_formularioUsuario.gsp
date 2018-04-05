<div class="form-group">
    <label>Nombres</label>
    <input type="text" class="form-control form-control-sm"
     placeholder="Nombres" name="usuario.persona.nombres"
     required value="${usuario?.persona?.nombres}" />
</div>

<div class="row">
    <div class="col-md">
        <div class="form-group">
            <label>Apellido paterno</label>
            <input type="text" class="form-control form-control-sm"
             placeholder="Apellido paterno"
             name="usuario.persona.apellidoPaterno"
             required value="${usuario?.persona?.apellidoPaterno}" />
        </div>
    </div>


    <div class="col-md">
        <div class="form-group">
            <label>Apellido materno</label>
            <input type="text" class="form-control form-control-sm"
             placeholder="Apellido materno"
             name="usuario.persona.apellidoMaterno"
             required value="${usuario?.persona?.apellidoMaterno}" />
        </div>
    </div>
</div>


<br />


<div class="form-group">
    <label><strong>Nombre de usuario</strong></label>
    <input type="text" class="form-control form-control-sm"
     placeholder="Ej. usuarioLaSalle" name="usuario.username"
     required value="${usuario?.username}" />
</div>

<div class="row">
    <div class="col-md">
        <div class="form-group">
            <label>Contrase&ntilde;a</label>
            <input type="password" class="form-control form-control-sm"
             placeholder="Debe contener m&aacute;s de 4 caracteres"
             name="usuario.password" required />
        </div>
    </div>


    <div class="col-md">
        <div class="form-group">
            <label>Confirmar contrase&ntilde;a</label>
            <input type="password" class="form-control form-control-sm"
             placeholder="Confirmar contrase&ntilde;a"
             name="usuario.passwordC" required />
        </div>
    </div>
</div>


<br />


<div class="form-group">
    <label>Rol de usuario</label>
    <select class="form-control form-control-sm" id="selectRol"
        name="rol.id">
        <g:each in="${flash.rolesLista}" var="r">
            <option value="${r.id}"
            ${rol?.id == r.id ? "selected" : ""}>
                ${r}
            </option>
        </g:each>
    </select>
</div>


<div class="form-group">
    <label>Instituci&oacute;n</label>
    <select class="form-control form-control-sm" id="selectInstitucion"
        name="usuario.institucion.id">
        <g:each in="${flash.institucionesLista}" var="institucion">
            <option value="${institucion.id}"
            ${institucion.id == usuario?.institucion?.id ? "selected" : ""}>
                ${institucion}
            </option>
        </g:each>
    </select>
</div>

<br />
