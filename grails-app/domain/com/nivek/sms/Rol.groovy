package com.nivek.sms

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@EqualsAndHashCode(includes='authority')
@ToString(includes='authority', includeNames=true, includePackage=false)
class Rol implements Serializable {

	private static final long serialVersionUID = 1

	String authority

	static constraints = {
		authority nullable: false, blank: false, unique: true
	}

	static mapping = {
		cache true
	}

    String toString() {
        switch(authority) {
            case "ROLE_ADMINISTRADOR_GENERAL":
                return "Administrador general"
            case "ROLE_ADMINISTRADOR_INSTITUCION":
                return "Administrador de institución"
            case "ROLE_ENCARGADO_ESPACIOS":
                return "Encargado de espacios"
            case "ROLE_BENEFICIARIO_INSTITUCION":
                return "Beneficiario de institución"
            case "ROLE_VISOR_INSTITUCION":
                return "Visor de institución"
            default:
                return "Desconocido"
        }
    }
}
