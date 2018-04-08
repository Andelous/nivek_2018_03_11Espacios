package com.nivek.sms

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.ModelAndView
import grails.plugin.springsecurity.SpringSecurityService

@Secured([Rol.ADMINISTRADOR_GENERAL, Rol.ADMINISTRADOR_INSTITUCION])
@Transactional(readOnly = false)
class UsuariosController {
    def springSecurityService

    static allowedMethods = [
        index: "GET",
        crear: ["GET", "POST"],
        editar: ["GET", "PUT"],
        eliminar: "GET"
    ]

    def index(Institucion institucion) {
        def tamanoPagina = 10
        def usuariosLista = null
        def usuarioActual = springSecurityService.getCurrentUser()

        if (!params.pag) {
            params.pag = 1
        }

        if (!params.q) {
            params.q = ""
        }

        if (usuarioActual.institucion) {
            institucion = usuarioActual.institucion
        }

        def paginas = [offset: tamanoPagina * (params.pag.toInteger() - 1), max: tamanoPagina]

        def q = "%" + params.q + "%"
        def query = Usuario.where {
            persona.nombres =~ q ||
            persona.apellidoPaterno =~ q ||
            persona.apellidoMaterno =~ q
        }

        if (institucion) {
            query = query.where {
                institucion.id == institucion.id
            }
        }

        usuariosLista = query.list(paginas)
        paginas = Math.ceil(query.count() / tamanoPagina)

        def institucionesLista =
            usuarioActual.institucion ?
                [Institucion.get(usuarioActual.institucion.id)]
                :
                Institucion.list()

        [
            usuariosLista: usuariosLista,
            pag: params.pag,
            q: params.q,
            paginas: paginas,
            institucionesLista: institucionesLista,
            institucion: institucion
        ]
    }

    @Transactional
    def crear(Usuario usuario, Rol rol) {
        def usuarioActual = springSecurityService.getCurrentUser()

        flash.institucionesLista = usuarioActual.institucion ?
            [Institucion.get(usuarioActual.institucion.id)]
            :
            Institucion.list()
        flash.rolesLista = usuarioActual.institucion ?
            Rol.where { authority != Rol.ADMINISTRADOR_GENERAL }.list()
            :
            Rol.list()

        if (request.method == "POST") {
            if (usuarioActual.institucion) {
                usuario.institucion = usuarioActual.institucion

                if (rol.authority == Rol.ADMINISTRADOR_GENERAL) {
                    rol = Rol.find {authority == Rol.ADMINISTRADOR_INSTITUCION}
                }
            }

            if (rol.authority == Rol.ADMINISTRADOR_GENERAL) {
                usuario.institucion = null
            }

            if (
                params.usuario.password == params.usuario.passwordC &&
                usuario.save()
            ) {
                UsuarioRol.create usuario, rol

                redirect(action: "index", controller: "usuarios", params: [creado: 1])
            } else {
                [
                    usuario: usuario,
                    rol: rol,
                    contrasena: params.usuario.password != params.usuario.passwordC
                ]
            }
        }
    }

    @Transactional
    def editar(Usuario usuario, Rol rol) {
        def usuarioActual = springSecurityService.getCurrentUser()

        if (
            !usuario ||
            (
                usuarioActual.institucion &&
                usuarioActual.institucion.id != usuario.institucion?.id
            ) ||
            usuario.id == usuarioActual.id
        ) {
            redirect(action: "index", controller: "usuarios",
                params: [errorAcceso: 1])
        } else {
            flash.institucionesLista = usuarioActual.institucion ?
                [Institucion.get(usuarioActual.institucion.id)]
                :
                Institucion.list()
            flash.rolesLista = usuarioActual.institucion ?
                Rol.where { authority != Rol.ADMINISTRADOR_GENERAL }.list()
                :
                Rol.list()

            if (request.method == "PUT") {
                if (rol.authority == Rol.ADMINISTRADOR_GENERAL) {
                    usuario.institucion = null
                }

                if (
                    params.usuario.password == params.usuario.passwordC &&
                    usuario.save()
                ) {
                    UsuarioRol.removeAll usuario
                    UsuarioRol.create usuario, rol

                    redirect(action: "index", controller: "usuarios", params: [actualizado: 1])
                }
            } else {
                rol = usuario.authorities[0]
            }

            [
                usuario: usuario,
                rol: rol,
                contrasena: params.usuario.password != params.usuario.passwordC
            ]
        }
    }

    @Transactional
    def eliminar(Usuario usuario) {
        def usuarioActual = springSecurityService.getCurrentUser()

        if (
            !usuario ||
            (
                usuarioActual.institucion &&
                usuarioActual.institucion.id != usuario.institucion?.id
            ) ||
            usuario.id == usuarioActual.id
        ) {
            redirect(action: "index", controller: "usuarios",
                params: [errorAcceso: 1])
        } else {
            def persona = usuario.persona

            UsuarioRol.removeAll(usuario)
            usuario.delete()
            persona.delete()

            redirect(action: "index", controller: "usuarios", params: [eliminado: 1])
        }
    }
}
