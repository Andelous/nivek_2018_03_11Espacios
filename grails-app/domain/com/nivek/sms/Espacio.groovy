package com.nivek.sms

class Espacio {

    String nombre

    // Debe estar en formato 00:00 por ejemplo 08:00
    String horaInicioDisponible
    // Debe estar en formato 00:00 por ejemplo 19:00
    String horaFinDisponible

    // Debe estar en formato binario, por ejemplo 1111100
    // Está disponible de lunes a viernes ------- LMMJVSD
    String dias

    Institucion institucion

    // Agregué este código para que funcione correctamente el
    // módulo de solicitudes. No borrar.
    //
    // También, la parte de responsables es el muchos a muchos de
    // los usuarios que son responsables del espacio.
    static hasMany = [solicitudes: Solicitud, usuarios: Usuario]

    static constraints = {
        nombre size: 1..100, matches: "^[a-zA-Z#1234567890àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+\$"
        horaInicioDisponible size: 5..5
        horaFinDisponible size: 5..5, validator: { val, obj ->
            val > obj.horaInicioDisponible
        }

        dias size: 7..7
    }

    static mapping = {
        id generator: 'increment'
        version false
    }

    String toString() {
        return nombre
    }
}
