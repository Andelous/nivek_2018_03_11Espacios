<g:if test="${request.method != 'GET' && (usuario || usuario.persona)}">
    <div class="alert alert-danger">
        <h6 class="alert-header"><strong>Error al crear usuario</strong></h6>
        <g:renderErrors bean="${usuario}" as="list" field="" />
        <g:renderErrors bean="${usuario.persona}" as="list" field="" />
        <g:if test="${contrasena}">
            <ul class="mb-0">
                <li>Contrase&ntilde;a incorrecta.</li>
            </ul>
        </g:if>
    </div>
</g:if>
