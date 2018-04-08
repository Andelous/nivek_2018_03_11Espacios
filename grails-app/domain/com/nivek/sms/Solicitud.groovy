package com.nivek.sms

class Solicitud {
    Date fecha
    // Formato 00:00 Ejemplo 08:00
    String horaInicio
    // Formato 00:00 Ejemplo 16:30
    String horaFin

    String razon

    static belongsTo = [usuario: Usuario, espacio: Espacio]
    SolicitudEstado estado

    static constraints = {
        razon size: 1..200

        espacio validator: { val, obj ->
            val?.institucion?.id == obj.usuario?.institucion?.id
        }

        horaInicio size: 5..5, validator: { val, obj ->
            def solicitudesSimilares = Solicitud.where {
                id != obj.id &&
                espacio.id == obj.espacio?.id &&
                estado.nombre == SolicitudEstado.APROBADA &&
                fecha == obj.fecha &&
                (
                    (
                        horaInicio <= val &&
                        horaFin > val
                    ) || (
                        horaInicio >= val &&
                        horaFin <= obj.horaFin
                    )
                )
            }

            return val >= obj.espacio?.horaInicioDisponible &&
                val < obj.espacio?.horaFinDisponible &&
                solicitudesSimilares.count() == 0
        }

        horaFin size: 5..5, validator: { val, obj ->

            def solicitudesSimilares = Solicitud.where {
                id != obj.id &&
                espacio.id == obj.espacio?.id &&
                estado.nombre == SolicitudEstado.APROBADA &&
                fecha == obj.fecha &&
                (
                    (
                        horaInicio < val &&
                        horaFin >= val
                    ) || (
                        horaInicio >= obj.horaInicio &&
                        horaFin <= val
                    )
                )
            }

            return val > obj.horaInicio &&
                val > obj.espacio?.horaInicioDisponible &&
                val <= obj.espacio?.horaFinDisponible &&
                solicitudesSimilares.count() == 0
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

            return obj.espacio?.dias?.charAt(dia) == '1' && (val > new Date())
        }
    }

    static mapping = {
        id generator: 'increment'
        version false
    }
}
