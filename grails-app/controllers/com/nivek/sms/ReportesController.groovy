package com.nivek.sms

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.ModelAndView
import grails.plugin.springsecurity.SpringSecurityService

@Secured(
    [
        Rol.VISOR_INSTITUCION,
        Rol.ADMINISTRADOR_INSTITUCION,
        Rol.BENEFICIARIO_INSTITUCION,
        Rol.ENCARGADO_ESPACIOS
    ]
)
@Transactional(readOnly = false)
class ReportesController {
    def springSecurityService

    static allowedMethods = [
        index: "GET"
    ]

    def index(Date inicio, Date fin, Espacio espacio, String nombrePersona) {
        def solicitudesLista = null
        def usuarioActual = springSecurityService.getCurrentUser()

        if (espacio && espacio?.institucion?.id != usuarioActual.institucion.id) {
            redirect(action: "index",
                params: [errorAcceso: 1])
            return
        }

        if (params.inicio && params.fin) {
            inicio = Date.parse("yyyy-MM-dd HH:mm:ss.S", params.inicio)
            fin = Date.parse("yyyy-MM-dd HH:mm:ss.S", params.fin)
        } else {
            inicio = null
            fin = null
        }

        if (inicio && fin) {
            println("Entramos")
            println(inicio?.toString())
            println(fin?.toString())
            println(nombrePersona ?: "")
            println(espacio ? espacio.toString() : "")
            println(params.inicio)
            println(params.fin)
            def query = Solicitud.where {
                fecha >= inicio &&
                fecha <= fin
            }

            if (espacio) {
                query = query.where {
                    espacio.id == espacio.id
                }
            }

            if (nombrePersona && nombrePersona.trim() != "") {
                query = query.where {
                    usuario.persona.nombres =~ nombrePersona /* ||
                    usuario.persona.apellidoPaterno =~ nombrePersona ||
                    usuario.persona.apellidoMaterno =~ nombrePersona*/
                }
            }

            solicitudesLista = query.list().sort { a, b ->
                a.espacio.nombre <=> b.espacio.nombre ?:
                a.estado.nombre <=> b.estado.nombre ?:
                a.fecha <=> b.fecha ?:
                a.horaInicio <=> b.horaInicio
            }
        }

        def espaciosLista = Espacio.where {
            institucion.id == usuarioActual.institucion.id
        }

        [
            solicitudesLista: solicitudesLista,
            inicio: inicio,
            fin: fin,
            espacio: espacio,
            nombrePersona: nombrePersona,
            espaciosLista: espaciosLista
        ]
    }
}
