package com.nivek.sms

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.ModelAndView
import grails.plugin.springsecurity.SpringSecurityService

@Secured("permitAll")
@Transactional(readOnly = false)
class MiscController {
    public static Usuario obtenerUsuarioActivo(SpringSecurityService springSecurityService) {
        return springSecurityService.getCurrentUser()
    }
}
