package com.nivek.sms

class SolicitudEstado {
    public static final String APROBADA = "2APROBADA"
    public static final String EN_REVISION = "1EN_REVISION"
    public static final String RECHAZADA_ENCARGADO = "3RECHAZADA_ENCARGADO"
    public static final String RECHAZADA_SISTEMA = "4RECHAZADA_SISTEMA"
    public static final String CANCELADA_USUARIO = "5CANCELADA_USUARIO"

    String nombre

    static constraints = {
    }

    static mapping = {
        id generator: 'increment'
        version false
    }

    String toString() {
        switch(nombre) {
            case APROBADA:
                return "Aprobada"
            case EN_REVISION:
                return "En revisión"
            case RECHAZADA_ENCARGADO:
                return "Rechazada por el encargado del espacio"
            case RECHAZADA_SISTEMA:
                return "Rechazada automáticamente por el sistema"
            case CANCELADA_USUARIO:
                return "El usuario canceló su solicitud"
            default:
                return "Desconocido"
        }
    }
}
