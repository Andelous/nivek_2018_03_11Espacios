package com.nivek.sms


import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.ModelAndView


@Secured("IS_AUTHENTICATED_FULLY")
@Transactional(readOnly = false)
class InstitucionController {

    InstitucionService institucionService

     static allowedMethods = [
        index: "GET",
        crear: ["GET", "POST"],
        editar: ["GET", "PUT"],
        eliminar: "GET"
    ]

    def index(Integer max) {
        def tamanoPagina = 10
        def institucionesLista = null

        if (!params.pag) {
            params.pag = 1
        }

        if (!params.q) {
            params.q = ""
        }

        def paginas = [offset: tamanoPagina * (params.pag.toInteger() - 1), max: tamanoPagina]

        def q = "%" + params.q + "%"

        def query = Institucion.where {
            nombre =~ q 
        }

        if(query==null){
            query = Institucion.list(paginas)

        }
      

        institucionesLista = query.list(paginas)
        paginas = Math.ceil(query.count() / tamanoPagina)

        [
            institucionesLista: institucionesLista,
            pag: params.pag,
            q: params.q,
            paginas: paginas,
        
        ]
    }

    
    @Transactional
    def crear(Institucion institucion) {
 
        if (request.method == "POST") {
           
                if(institucion.save()){
                     redirect(action: "index", controller: "institucion", params: [creado: 1])

                }

           
        }
    }

    
    @Transactional
    def editar(Institucion institucion) {
     

        if (request.method == "PUT") {
            
                 if (institucion.save()) {
            

                redirect(action: "index", controller: "institucion", params: [actualizado: 1])
            }
        }

         [
            institucion: institucion,
            
        ]

        }
    

   

     @Transactional
    def eliminar(Institucion institucion) {
      
        institucion.delete()

        redirect(action: "index", controller: "institucion", params: [eliminado: 1])
    }
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'institucion.label', default: 'Institucion'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
