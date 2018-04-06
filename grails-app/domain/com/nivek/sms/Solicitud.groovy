package com.nivek.sms

class Solicitud {
    Date fecha
    String horaInicio
    String horaFin

    static belongsTo = [usuario: Usuario, espacio: Espacio]
    SolicitudEstado estado

    static constraints = {
    }
}
