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

    def show(Long id) {
        respond institucionService.get(id)
    }
    @Transactional
    def crear(Institucion institucion) {
 
        if (request.method == "POST") {
           
                if(institucion.save()){
                     redirect(action: "index", controller: "institucion", params: [creado: 1])

                }

           
        }
    }

    

    def edit(Long id) {
        respond institucionService.get(id)
    }

    def update(Institucion institucion) {
        if (institucion == null) {
            notFound()
            return
        }

        try {
            institucionService.save(institucion)
        } catch (ValidationException e) {
            respond institucion.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'institucion.label', default: 'Institucion'), institucion.id])
                redirect institucion
            }
            '*'{ respond institucion, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        institucionService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'institucion.label', default: 'Institucion'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
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
