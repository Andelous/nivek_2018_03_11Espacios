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

        if (usuario.authorities[0].authority == Rol.BENEFICIARIO_INSTITUCION) {
            redirect(action: "misSolicitudes")
            return
        }
        else {
            redirect(action: "misEspacios")
            return
        }
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

        solicitudesLista = query.list(paginas).sort { a, b ->
            a.espacio.nombre <=> b.espacio.nombre ?:
            a.estado.nombre <=> b.estado.nombre ?:
            a.fecha <=> b.fecha ?:
            a.horaInicio <=> b.horaInicio
        }
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
                return
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
                return
            }
        }

        if (request.method == 'PUT'){
            def intento = solicitud.save(flush: true)
            if (intento) {
                redirect(action: "misSolicitudes", controller: "solicitudes",
                    params: [actualizada: 1])
                return
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
            solicitud?.usuario?.id != usuarioActual?.id ||
            solicitud?.estado?.nombre != SolicitudEstado.EN_REVISION
        ) {
            redirect(action: "misSolicitudes", controller: "solicitudes",
                params: [errorAcceso: 1])
            return
        } else {
            def estadoCanceladaUsuario = SolicitudEstado.find { nombre == SolicitudEstado.CANCELADA_USUARIO }

            solicitud.estado = estadoCanceladaUsuario
            if (solicitud.save()) {
                redirect(action: "misSolicitudes", controller: "solicitudes",
                    params: [cancelada: 1])
                return
            } else {
                redirect(action: "misSolicitudes", controller: "solicitudes",
                    params: [errorAcceso: 1])
                return
            }
        }
    }














    @Secured(Rol.ENCARGADO_ESPACIOS)
    def misEspacios(Espacio espacio) {
        def tamanoPagina = 10
        def solicitudesLista = null
        def usuarioActual = springSecurityService.getCurrentUser()

        if (!params.pag) {
            params.pag = 1
        }

        System.out.println(espacio)

        def espaciosEncargado = usuarioActual.espacios
        def idsEspaciosEncargado = new Long[espaciosEncargado.size()]
        def i = 0

        espaciosEncargado.each {
            idsEspaciosEncargado[i++] = it.id
        }

        if (
            !(espacio?.id in idsEspaciosEncargado)
        ) {
            espacio = null
        }

        System.out.println(espacio)

        def paginas = [
            offset: tamanoPagina * (params.pag.toInteger() - 1),
            max: tamanoPagina,
            sort: "fecha"]

        def query = Solicitud.where {
            espacio.id in idsEspaciosEncargado
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

        solicitudesLista = query.list(paginas).sort { a, b ->
            a.espacio.nombre <=> b.espacio.nombre ?:
            a.estado.nombre <=> b.estado.nombre ?:
            a.fecha <=> b.fecha ?:
            a.horaInicio <=> b.horaInicio
        }

        paginas = Math.ceil(query.count() / tamanoPagina)

        System.out.println("Solicitudes totales     - " + Solicitud.count())
        System.out.println("Solicitudes del encargado - " + query.count())

        [
            solicitudesLista: solicitudesLista,
            pag: params.pag,
            paginas: paginas,
            espaciosLista: Espacio.where {
                id in idsEspaciosEncargado
            }.list(),
            espacio: espacio
        ]
    }

    @Secured(Rol.ENCARGADO_ESPACIOS)
    @Transactional
    def aprobar(Solicitud solicitud) {
        // Sacamos los espacios que pertenecen al usuario activo
        def usuarioActual = springSecurityService.getCurrentUser()

        def espaciosEncargado = usuarioActual.espacios
        def idsEspaciosEncargado = new Long[espaciosEncargado.size()]
        def i = 0

        espaciosEncargado.each {
            idsEspaciosEncargado[i++] = it.id
        }

        // Validamos que la solicitud:
        // Exista, su espacio pertenezca al usuario y esté en revisión
        if (
            !solicitud ||
            !(solicitud?.espacio?.id in idsEspaciosEncargado) ||
            solicitud.estado.nombre != SolicitudEstado.EN_REVISION
        ) {
            redirect(action: "misEspacios", controller: "solicitudes",
                params: [errorAcceso: 1])
            return
        } else {
            // Si cumple con las características,
            // le cambiamos el estado y guardamos
            def estadoAprobada = SolicitudEstado.find { nombre == SolicitudEstado.APROBADA }

            solicitud.estado = estadoAprobada

            if (solicitud.save()) {

                // El sistema rechaza todas las solicitudes que estén en
                // revisión y que coincidan con el horario de la aprobada

                def solicitudesCoincidentes = Solicitud.where {
                    id != solicitud.id &&
                    estado.nombre == SolicitudEstado.EN_REVISION &&
                    espacio.id == solicitud.espacio.id &&
                    fecha == solicitud.fecha &&
                    (
                        (       // Hora de inicio dentro del horario de la solicitud
                            horaInicio >= solicitud.horaInicio &&
                            horaInicio < solicitud.horaFin
                        ) || (  // Hora de fin dentro del horario de la solicitud
                            horaFin > solicitud.horaInicio &&
                            horaFin <= solicitud.horaFin
                        ) || ( // Horario de solicitud con el horario de la solicitud dentro
                            horaInicio <= solicitud.horaInicio &&
                            horaFin >= solicitud.horaFin
                        )
                    )
                }.list()

                // Le cambiamos el estado a todas... para que estén
                // rechazadas por el sistema.
                def estadoRechazadaSistema = SolicitudEstado.find { nombre == SolicitudEstado.RECHAZADA_SISTEMA }

                solicitudesCoincidentes.each {
                    it.estado = estadoRechazadaSistema
                    it.save()
                }

                redirect(action: "misEspacios", controller: "solicitudes",
                    params: [aprobada: 1])
                return
            } else {
                redirect(action: "misEspacios", controller: "solicitudes",
                    params: [errorAcceso: 1])
                return
            }
        }
    }

    @Secured(Rol.ENCARGADO_ESPACIOS)
    @Transactional
    def rechazar(Solicitud solicitud) {
        // Sacamos los espacios que pertenecen al usuario activo
        def usuarioActual = springSecurityService.getCurrentUser()

        def espaciosEncargado = usuarioActual.espacios
        def idsEspaciosEncargado = new Long[espaciosEncargado.size()]
        def i = 0

        espaciosEncargado.each {
            idsEspaciosEncargado[i++] = it.id
        }

        // Validamos que la solicitud:
        // Exista, su espacio pertenezca al usuario y esté
        // aprobada o en revisión
        if (
            !solicitud ||
            !(solicitud?.espacio?.id in idsEspaciosEncargado) ||
            (
                solicitud.estado.nombre != SolicitudEstado.EN_REVISION &&
                solicitud.estado.nombre != SolicitudEstado.APROBADA
            )
        ) {
            redirect(action: "misEspacios", controller: "solicitudes",
                params: [errorAcceso: 1])
            return
        } else {
            // Si cumple con las características,
            // le cambiamos el estado y guardamos
            def estadoRechazadaEncargado = SolicitudEstado.find { nombre == SolicitudEstado.RECHAZADA_ENCARGADO }

            def flagAprobada = solicitud.estado.nombre == SolicitudEstado.APROBADA

            solicitud.estado = estadoRechazadaEncargado

            if (solicitud.save(flush: true)) {

                // Si la solicitud estaba aprobada, entonces
                // el sistema recuperará todas las solicitudes que
                // hayan sido rechazadas por su aprobación

                if (flagAprobada) {
                    def solicitudesCoincidentes = Solicitud.where {
                        id != solicitud.id &&
                        estado.nombre == SolicitudEstado.RECHAZADA_SISTEMA &&
                        espacio.id == solicitud.espacio.id &&
                        fecha == solicitud.fecha &&
                        (
                            (       // Hora de inicio dentro del horario de la solicitud
                                horaInicio >= solicitud.horaInicio &&
                                horaInicio < solicitud.horaFin
                            ) || (  // Hora de fin dentro del horario de la solicitud
                                horaFin > solicitud.horaInicio &&
                                horaFin <= solicitud.horaFin
                            ) || ( // Horario de solicitud con el horario de la solicitud dentro
                                horaInicio <= solicitud.horaInicio &&
                                horaFin >= solicitud.horaFin
                            )
                        )
                    }.list()

                    // Le cambiamos el estado a todas... para que estén
                    // en revisión.
                    def estadoEnRevision = SolicitudEstado.find { nombre == SolicitudEstado.EN_REVISION }

                    solicitudesCoincidentes.each {
                        it.estado = estadoEnRevision
                        it.save()
                    }
                }

                redirect(action: "misEspacios", controller: "solicitudes",
                    params: [rechazada: 1])
                return
            } else {
                redirect(action: "misEspacios", controller: "solicitudes",
                    params: [errorAcceso: 1])
                return
            }
        }
    }

    @Secured(Rol.ENCARGADO_ESPACIOS)
    @Transactional
    def restaurar(Solicitud solicitud) {
        // Sacamos los espacios que pertenecen al usuario activo
        def usuarioActual = springSecurityService.getCurrentUser()

        def espaciosEncargado = usuarioActual.espacios
        def idsEspaciosEncargado = new Long[espaciosEncargado.size()]
        def i = 0

        espaciosEncargado.each {
            idsEspaciosEncargado[i++] = it.id
        }

        // Validamos que la solicitud:
        // Exista, su espacio pertenezca al usuario y esté
        // aprobada o en revisión
        if (
            !solicitud ||
            !(solicitud?.espacio?.id in idsEspaciosEncargado) ||
            solicitud.estado.nombre != SolicitudEstado.RECHAZADA_ENCARGADO
        ) {
            redirect(action: "misEspacios", controller: "solicitudes",
                params: [errorAcceso: 1])
            return
        } else {
            // Si cumple con las características,
            // le cambiamos el estado y guardamos
            def estadoEnRevision = SolicitudEstado.find { nombre == SolicitudEstado.EN_REVISION }

            solicitud.estado = estadoEnRevision

            // Automáticamente se validará que no choque con una
            // que ya esté aprobada.
            if (solicitud.save()) {
                redirect(action: "misEspacios", controller: "solicitudes",
                    params: [restaurada: 1])
                return
            } else {
                redirect(action: "misEspacios", controller: "solicitudes",
                    params: [errorAcceso: 1])
                return
            }
        }
    }
}
