package com.nivek.sms

class Institucion {
    String nombre
    String direccion
    Boolean activa

    static constraints = {
        nombre size: 1..150, matches: "^[a-zA-Z0123456789àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+\$"
        direccion size: 1..200, matches: "^[a-zA-Z#1234567890àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+\$"
    }

    static mapping = {
        id generator: 'increment'
        version false
    }

    String toString() {
        return nombre
    }
}
