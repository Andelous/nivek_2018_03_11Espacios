package com.nivek.sms

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@EqualsAndHashCode(includes='authority')
@ToString(includes='authority', includeNames=true, includePackage=false)
class Rol implements Serializable {

	private static final long serialVersionUID = 1

    public static final String ADMINISTRADOR_GENERAL = "ROLE_ADMINISTRADOR_GENERAL"
    public static final String ADMINISTRADOR_INSTITUCION = "ROLE_ADMINISTRADOR_INSTITUCION"
    public static final String ENCARGADO_ESPACIOS = "ROLE_ENCARGADO_ESPACIOS"
    public static final String BENEFICIARIO_INSTITUCION = "ROLE_BENEFICIARIO_INSTITUCION"
    public static final String VISOR_INSTITUCION = "ROLE_VISOR_INSTITUCION"


	String authority

	static constraints = {
		authority nullable: false, blank: false, unique: true
	}

	static mapping = {
		cache true
        id generator: 'increment'
        version false
	}

    String toString() {
        switch(authority) {
            case ADMINISTRADOR_GENERAL:
                return "Administrador general"
            case ADMINISTRADOR_INSTITUCION:
                return "Administrador de institución"
            case ENCARGADO_ESPACIOS:
                return "Encargado de espacios"
            case BENEFICIARIO_INSTITUCION:
                return "Beneficiario de institución"
            case VISOR_INSTITUCION:
                return "Visor de institución"
            default:
                return "Desconocido"
        }
    }
}
