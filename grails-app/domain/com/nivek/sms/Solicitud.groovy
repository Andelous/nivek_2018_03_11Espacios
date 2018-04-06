package com.nivek.sms

class Solicitud {
    Date fecha
    // Formato 00:00 Ejemplo 08:00
    String horaInicio
    // Formato 00:00 Ejemplo 16:30
    String horaFin

    static belongsTo = [usuario: Usuario, espacio: Espacio]
    SolicitudEstado estado

    static constraints = {
        horaInicio size: 5..5
        horaFin size: 5..5, validator: { val, obj ->
            horaFin > horaInicio
        }

        fecha validator: { val, obj ->
            def dia = val[Calendar.DAY_OF_WEEK]

            if (dia == Calendar.MONDAY) {
                dia = 0
            } else if (dia == Calendar.TUESDAY) {
                dia = 1
            } else if (dia == Calendar.WEDNESDAY) {
                dia = 2
            } else if (dia == Calendar.THURSDAY) {
                dia = 3
            } else if (dia == Calendar.FRIDAY) {
                dia = 4
            } else if (dia == Calendar.SATURDAY) {
                dia = 5
            } else if (dia == Calendar.SUNDAY) {
                dia = 6
            } else {
                return false
            }

            return obj.espacio.dias.charAt(dia) == '1'
        }
    }

    static mapping = {
        id generator: 'increment'
        version false
    }
}
