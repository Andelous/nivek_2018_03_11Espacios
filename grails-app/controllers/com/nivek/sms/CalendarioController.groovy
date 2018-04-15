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
      index: "GET",

      //My methods
      vistaBeneficiario: "GET",
      vistaEncargado: "GET"
    ]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Calendario.list(params), model: [calendarioCount: Calendario.count()]
    }

    def indexTest() {
      def usuario = springSecurityService.getCurrentUser()

      if (usuario.authorities[0].authority == Rol.BENEFICIARIO_INSTITUCION)
        redirect(action: "vistaBeneficiario")
      else
        redirect(action: "vistaEncargado")
    }

    @Secured(Rol.BENEFICIARIO_INSTITUCION)
    def vistaBeneficiario(){
      def beneficiarioActual = springSecurityService.getCurrentUser()
      def institucion = beneficiarioActual.institucion
      def mapa = [:]

      def solicitudesAprobadas = Solicitud.where {
        estado.nombre == SolicitudEstado.APROBADA &&
        espacio.institucion == institucion

      }

      mapa.put("solicitudes",solicitudesAprobadas)
      println(solicitudesAprobadas)
      System.out.println(beneficiarioActual.persona.nombres)
      [
        solicitudesAprobadas: solicitudesAprobadas
      ]
    }

    @Secured(Rol.ENCARGADO_ESPACIOS)
    def vistaEncargado(){
      def encargadoActual = springSecurityService.getCurrentUser()

      def institucion = encargadoActual.institucion
      System.out.println(encargadoActual.persona.nombres)
    }

}
