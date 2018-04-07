<nav>
    <ul class="pagination justify-content-center">
        <g:set var="i" value="${1}" />
        <g:set var="paginas" value="${paginas.toInteger()}" />

        <g:while test="${i <= paginas}">
            <li class="page-item ${params.pag.toInteger() == i ? 'active' : ''}">
                <g:link action="index" controller="${controllerName}"
                    params="[pag: i, q: params.q, 'institucion.id': institucion?.id, 'espacio.id': espacio?.id]" class="page-link">
                    ${i++}
                </g:link>
            </li>
        </g:while>
    </ul>
</nav>
