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
      index: "GET"
    ]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def beneficiarioActual = springSecurityService.getCurrentUser()
        def institucion = beneficiarioActual.institucion
        def mapa = [:]
        def solicitudesAprobadas = []


        def espacios = Espacio.where{
            institucion.id == beneficiarioActual.institucion.id
        }.findAll()




            def valor = Integer.parseInt(params.espacios?.id)


            
            println(params)
            println valor

            if(valor == 0){
                println "Valor 0"
                 solicitudesAprobadas = Solicitud.where {
                     estado.nombre == SolicitudEstado.APROBADA &&
                    espacio.institucion == institucion
                }.findAll()
            }else{
                println "Valor X"
                solicitudesAprobadas = Solicitud.where {
                     estado.nombre == SolicitudEstado.APROBADA &&
                    espacio.institucion == institucion &&
                    espacio.id == valor         
                }.findAll()
            }

           
            
            


        //println(espacio)
        /*mapa.put("solicitudes",solicitudesAprobadas)
        mapa.put("espacios",espacios)
        respond Calendario.list(params), model: mapa*/

        [
            solicitudes: solicitudesAprobadas,
            espacios: espacios
        ]
    }

}
