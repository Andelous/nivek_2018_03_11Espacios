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

        if (usuario.authorities[0].authority == Rol.BENEFICIARIO_INSTITUCION)
            redirect(action: "misSolicitudes")
        else
            redirect(action: "misEspacios")
    }




    @Secured(Rol.BENEFICIARIO_INSTITUCION)
    def misSolicitudes(Espacio espacio) {
        def tamanoPagina = 10
        def solicitudesLista = null
        def usuarioActual = springSecurityService.getCurrentUser()

        if (!params.pag) {
            params.pag = 1
        }

        System.out.println(espacio)

        if (espacio?.institucion?.id != usuarioActual.institucion?.id) {
            espacio = null
        }

        System.out.println(espacio)

        def paginas = [
            offset: tamanoPagina * (params.pag.toInteger() - 1),
            max: tamanoPagina,
            sort: "fecha"]

        def query = Solicitud.where {
            usuario.id == usuarioActual.id
        }

        if (espacio) {
            query = query.where {
                espacio.id == espacio.id
            }
        }

        System.out.println()
        System.out.println(query.getClass())
        System.out.println()

        System.out.println(query)

        solicitudesLista = query.list(paginas)
        paginas = Math.ceil(query.count() / tamanoPagina)

        System.out.println("Solicitudes totales     - " + Solicitud.count())
        System.out.println("Solicitudes del usuario - " + query.count())

        [
            solicitudesLista: solicitudesLista,
            pag: params.pag,
            paginas: paginas,
            espaciosLista: Espacio.where {
                institucion.id == usuarioActual.institucion?.id
            }.list(),
            espacio: espacio
        ]
    }

    @Secured(Rol.BENEFICIARIO_INSTITUCION)
    @Transactional
    def crear(Solicitud solicitud, Espacio espacio) {
        def usuarioActual = springSecurityService.getCurrentUser()

        flash.espaciosLista = Espacio.where {
            institucion.id == usuarioActual.institucion?.id
        }.list()

        if (request.method == 'GET') {
            solicitud = new Solicitud()
            solicitud.espacio = espacio
        }

        solicitud.usuario = usuarioActual
        solicitud.estado = SolicitudEstado.find { nombre == SolicitudEstado.EN_REVISION }

        if (request.method == 'POST'){
            def intento = solicitud.save(flush: true)
            if (intento) {
                redirect(action: "misSolicitudes", controller: "solicitudes",
                    params: [creada: 1])
            }
        }

        [solicitud: solicitud]
    }

    @Secured(Rol.BENEFICIARIO_INSTITUCION)
    @Transactional
    def editar(Solicitud solicitud) {
        def usuarioActual = springSecurityService.getCurrentUser()

        flash.espaciosLista = Espacio.where {
            institucion.id == usuarioActual.institucion?.id
        }.list()

        if (request.method == 'GET') {
            if (
                !solicitud ||
                solicitud?.usuario?.id != usuarioActual?.id ||
                solicitud?.estado?.nombre != SolicitudEstado.EN_REVISION
            ) {
                redirect(action: "misSolicitudes", controller: "solicitudes",
                    params: [errorAcceso: 1])
            }
        }

        if (request.method == 'PUT'){
            def intento = solicitud.save(flush: true)
            if (intento) {
                redirect(action: "misSolicitudes", controller: "solicitudes",
                    params: [actualizada: 1])
            }
        }

        [solicitud: solicitud]
    }

    @Secured(Rol.BENEFICIARIO_INSTITUCION)
    @Transactional
    def cancelar(Solicitud solicitud) {
        def usuarioActual = springSecurityService.getCurrentUser()

        if (
            !solicitud ||
            solicitud?.usuario?.id != usuarioActual?.id
        ) {
            redirect(action: "misSolicitudes", controller: "solicitudes",
                params: [errorAcceso: 1])
        } else {
            def estadoCanceladaUsuario = SolicitudEstado.find { nombre == SolicitudEstado.CANCELADA_USUARIO }

            solicitud.estado = estadoCanceladaUsuario
            if (solicitud.save()) {
                redirect(action: "misSolicitudes", controller: "solicitudes",
                    params: [cancelada: 1])
            } else {
                redirect(action: "misSolicitudes", controller: "solicitudes",
                    params: [errorAcceso: 1])
            }
        }
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
