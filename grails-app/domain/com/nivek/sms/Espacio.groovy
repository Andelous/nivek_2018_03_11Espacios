package com.nivek.sms

class Espacio {

    // Agregué este código para que funcione correctamente el
    // módulo de solicitudes. No borrar.
    static hasMany = [solicitudes: Solicitud]

    static constraints = {
    }
}
