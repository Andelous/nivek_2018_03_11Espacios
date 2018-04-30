<div class="card cardAndelous mb-3" id="cardUsuario${usuario.id}" idUsuario="${usuario.id}">
    <div class="card-header">
        <input type="checkbox" class="chkAndelous" idUsuario="${usuario.id}">
        ${usuario.persona}
    </div>
    <div class="card-body">
        <p class="card-text">
            Nombre de usuario:
            <strong>
                ${usuario.username}
            </strong>
        </p>
    </div>
</div>
