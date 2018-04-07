package com.nivek.sms

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.ModelAndView
import grails.plugin.springsecurity.SpringSecurityService

@Secured([Rol.BENEFICIARIO_INSTITUCION, Rol.ENCARGADO_ESPACIOS])
@Transactional(readOnly = false)
class SolicitudesController {
    def springSecurityService

    static allowedMethods = [
        index: "GET",

        misSolicitudes: "GET",
        crear: ["GET", "POST"],
        editar: ["GET", "PUT"],
        cancelar: "GET",

        misEspacios: "GET",
        aprobar: "GET",
        rechazar: "GET",
        restaurar: "GET"
    ]

    def index() {
        def usuario = springSecurityService.getCurrentUser()


    }




    @Secured(Rol.BENEFICIARIO_INSTITUCION)
    def misSolicitudes() {

    }

    @Secured(Rol.BENEFICIARIO_INSTITUCION)
    @Transactional
    def crear(Solicitud solicitud) {

    }

    @Secured(Rol.BENEFICIARIO_INSTITUCION)
    @Transactional
    def editar(Solicitud solicitud) {

    }

    @Secured(Rol.BENEFICIARIO_INSTITUCION)
    @Transactional
    def cancelar(Solicitud solicitud) {

    }





    @Secured(Rol.ENCARGADO_ESPACIOS)
    def misEspacios() {

    }

    @Secured(Rol.ENCARGADO_ESPACIOS)
    @Transactional
    def aprobar(Solicitud solicitud) {

    }

    @Secured(Rol.ENCARGADO_ESPACIOS)
    @Transactional
    def rechazar(Solicitud solicitud) {

    }

    @Secured(Rol.ENCARGADO_ESPACIOS)
    @Transactional
    def restaurar(Solicitud solicitud) {

    }
}
