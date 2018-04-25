<g:if test="${request.method != 'GET' && espacio}">
    <div class="alert alert-danger">
        <h6 class="alert-header"><strong>Error al crear espacio</strong></h6>
        <g:renderErrors bean="${espacio}" as="list" field="" />
    </div>
</g:if>
