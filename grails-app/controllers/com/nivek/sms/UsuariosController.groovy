package com.nivek.sms

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.ModelAndView

@Secured("IS_AUTHENTICATED_FULLY")
@Transactional(readOnly = false)
class UsuariosController {

    static allowedMethods = [
        index: "GET",
        crear: ["GET", "POST"],
        editar: ["GET", "PUT"],
        eliminar: "GET"
    ]

    def index() {
        def tamanoPagina = 10
        def usuariosLista = null

        if (!params.pag) {
            params.pag = 1
        }

        if (!params.q) {
            params.q = ""
        }

        def paginas = [offset: tamanoPagina * (params.pag.toInteger() - 1), max: tamanoPagina]

        def q = "%" + params.q + "%"
        def query = Usuario.where {
            persona.nombres =~ q ||
            persona.apellidoPaterno =~ q ||
            persona.apellidoMaterno =~ q
        }

        if (params.institucion?.id) {
            query = query.where {
                institucion.id == params.institucion.id
            }
        }

        usuariosLista = query.list(paginas)
        paginas = Math.ceil(query.count() / tamanoPagina)

        [
            usuariosLista: usuariosLista,
            pag: params.pag,
            q: params.q,
            paginas: paginas,
            institucionesLista: Institucion.list(),
            institucion: [id: params.institucion?.id]
        ]
    }

    @Transactional
    def crear(Usuario usuario, Rol rol) {

        flash.institucionesLista = Institucion.list()
        flash.rolesLista = Rol.list()

        if (request.method == "POST") {
            if (rol.authority == 'ROLE_ADMINISTRADOR_GENERAL') {
                usuario.institucion = null
            }

            if (params.usuario.password == params.usuario.passwordC &&
                usuario.save()) {
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
        flash.institucionesLista = Institucion.list()
        flash.rolesLista = Rol.list()

        if (request.method == "PUT") {
            if (rol.authority == 'ROLE_ADMINISTRADOR_GENERAL') {
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

    @Transactional
    def eliminar(Usuario usuario) {
        def persona = usuario.persona

        UsuarioRol.removeAll(usuario)
        usuario.delete()
        persona.delete()

        redirect(action: "index", controller: "usuarios", params: [eliminado: 1])
    }
}
