<g:if test="${request.method != 'GET' && solicitud}">
    <div class="alert alert-danger">
        <h6 class="alert-header"><strong>Error al crear solicitud</strong></h6>
        <g:renderErrors bean="${solicitud}" as="list" field="" />
    </div>
</g:if>
