<g:if test="${request.method != 'GET' && (institucion)}">
    <div class="alert alert-danger">
        <h6 class="alert-header"><strong>Error al crear Institucion</strong></h6>
        <g:renderErrors bean="${institucion}" as="list" field="" />

    </div>
</g:if>
