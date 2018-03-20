package com.nivek.sms

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.ModelAndView

@Secured("IS_AUTHENTICATED_FULLY")
@Transactional(readOnly = false)
class UsuariosController {

    def index() {
        
    }

    def crear(Usuario usuario) {

    }
}
