package com.nivek.sms

class SolicitudEstado {
    String nombre

    static constraints = {
    }

    static mapping = {
        id generator: 'increment'
        version false
    }
}
