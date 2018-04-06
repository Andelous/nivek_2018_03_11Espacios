package com.nivek.sms

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.ModelAndView
import grails.plugin.springsecurity.SpringSecurityService

@Secured(["ROLE_BENEFICIARIO_INSTITUCION", "ROLE_ENCARGADO_ESPACIOS"])
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
        System.out.println(usuario)
    }




    @Secured("ROLE_BENEFICIARIO_INSTITUCION")
    def misSolicitudes() {

    }

    @Secured("ROLE_BENEFICIARIO_INSTITUCION")
    @Transactional
    def crear(Solicitud solicitud) {

    }

    @Secured("ROLE_BENEFICIARIO_INSTITUCION")
    @Transactional
    def editar(Solicitud solicitud) {

    }

    @Secured("ROLE_BENEFICIARIO_INSTITUCION")
    @Transactional
    def cancelar(Solicitud solicitud) {

    }





    @Secured("ROLE_ENCARGADO_ESPACIOS")
    def misEspacios() {

    }

    @Secured("ROLE_ENCARGADO_ESPACIOS")
    @Transactional
    def aprobar() {

    }

    @Secured("ROLE_ENCARGADO_ESPACIOS")
    @Transactional
    def rechazar() {

    }

    @Secured("ROLE_ENCARGADO_ESPACIOS")
    @Transactional
    def restaurar() {

    }
}
