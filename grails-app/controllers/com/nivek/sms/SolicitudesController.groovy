package com.nivek.sms

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.ModelAndView

@Secured("IS_AUTHENTICATED_FULLY")
@Transactional(readOnly = false)
class SolicitudesController {

    static allowedMethods = [
        index: "GET",
        crear: ["GET", "POST"],
        editar: ["GET", "PUT"],
        eliminar: "GET"
    ]

    def index() {

    }

    @Transactional
    def crear(Solicitud solicitud) {

    }

    @Transactional
    def editar(Solicitud solicitud) {

    }

    @Transactional
    def eliminar(Solicitud solicitud) {

    }
}
