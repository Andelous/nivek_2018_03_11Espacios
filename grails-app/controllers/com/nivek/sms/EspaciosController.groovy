package com.nivek.sms

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.ModelAndView
import grails.plugin.springsecurity.SpringSecurityService
import java.util.regex.Pattern
import java.util.regex.Matcher

@Secured(Rol.ADMINISTRADOR_INSTITUCION)
@Transactional(readOnly = false)
class EspaciosController {
    def springSecurityService

    static allowedMethods = [
        index: "GET",
        crear: ["GET", "POST"],
        editar: ["GET", "PUT"],
        eliminar: "GET",
        asignarEncargados: ["GET", "PUT"]
    ]

    def index() {
        def tamanoPagina = 10
        def espaciosLista = null
        def usuarioActual = springSecurityService.getCurrentUser()

        if (!params.pag) {
            params.pag = 1
        }

        if (!params.q) {
            params.q = ""
        }

        def paginas = [offset: tamanoPagina * (params.pag.toInteger() - 1), max: tamanoPagina]

        def q = "%" + params.q + "%"
        def query = Espacio.where {
            nombre =~ q &&
            institucion.id == usuarioActual.institucion.id
        }

        espaciosLista = query.list(paginas)
        paginas = Math.ceil(query.count() / tamanoPagina)

        [
            espaciosLista: espaciosLista,
            pag: params.pag,
            q: params.q,
            paginas: paginas
        ]
    }

    @Transactional
    def crear(Espacio espacio) {
        def usuarioActual = springSecurityService.getCurrentUser()

        if (request.method == "POST") {
            espacio.institucion = usuarioActual.institucion

            if (espacio.save(flush: true)) {
                redirect(action: "index", controller: "espacios", params: [creado: 1])
                return
            } else {
                [
                    espacio: espacio
                ]
            }
        }
    }

    @Transactional
    def editar(Espacio espacio) {
        def usuarioActual = springSecurityService.getCurrentUser()

        if (
            !espacio ||
            espacio.institucion?.id != usuarioActual.institucion?.id
        ) {
            redirect(action: "index", controller: "espacios",
                params: [errorAcceso: 1])
            return
        }

        if (request.method == "PUT") {
            espacio.institucion = usuarioActual.institucion

            if (espacio.save()) {
                redirect(action: "index", controller: "espacios", params: [actualizado: 1])
                return
            }
        }

        [
            espacio: espacio
        ]
    }

    @Transactional
    def eliminar(Espacio espacio) {
        def usuarioActual = springSecurityService.getCurrentUser()

        if (
            !espacio ||
            espacio.institucion?.id != usuarioActual.institucion?.id
        ) {
            redirect(action: "index", controller: "espacios",
                params: [errorAcceso: 1])
            return
        } else {
            espacio.delete()

            redirect(action: "index", controller: "espacios", params: [eliminado: 1])
            return
        }
    }

    @Transactional
    def asignarEncargados(Espacio espacio, String ids) {
        def usuarioActual = springSecurityService.getCurrentUser()

        if (
            !espacio ||
            espacio.institucion?.id != usuarioActual.institucion?.id
        ) {
            redirect(action: "index", controller: "espacios",
                params: [errorAcceso: 1])
            return
        }

        if (request.method == "PUT" && ids) {
            Pattern p = Pattern.compile("[0-9]+(,[0-9]+)*")
            Matcher m = p.matcher(ids)

            if (m.matches()) {
                def arrIds = ids.split(",")
                def arrIdsInt = []

                for (String s : arrIds) {
                    if (s.trim() != "")
                        arrIdsInt.add(Long.parseLong(s))
                }

                def usuarios = Usuario.where {
                    id in arrIdsInt
                }.list()

                espacio.usuarios.clear()

                for (Usuario u : usuarios) {
                    if (
                        u.institucion?.id != espacio.institucion.id ||
                        u.authorities[0].authority != Rol.ENCARGADO_ESPACIOS
                    ) {
                        continue
                    }

                    espacio.usuarios.add(u)
                }

                def test = espacio.save()

                if (test) {
                    redirect(action: "index", controller: "espacios", params: [actualizado: 1])
                    return
                }
            }
        }

        [
            espacio: espacio,
            ids: ids,
            usuarios: Usuario.where {
                institucion.id == usuarioActual.institucion.id
            }.list()
        ]
    }
}
