package com.nivek.sms

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.ModelAndView
import grails.plugin.springsecurity.SpringSecurityService

@Secured([Rol.BENEFICIARIO_INSTITUCION, Rol.ENCARGADO_ESPACIOS])
@Transactional(readOnly = false)
class CalendarioController {
    def springSecurityService

    CalendarioService calendarioService

    static allowedMethods = [
      index: "GET"
    ]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def beneficiarioActual = springSecurityService.getCurrentUser()
        def institucion = beneficiarioActual.institucion
        def mapa = [:]

        def solicitudesAprobadas = Solicitud.where {
          estado.nombre == SolicitudEstado.APROBADA &&
          espacio.institucion == institucion
        }.findAll()
        mapa.put("solicitudes",solicitudesAprobadas)
        respond Calendario.list(params), model: mapa
    }

}
