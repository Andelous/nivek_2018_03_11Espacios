package nivek_2018_03_11espacios

import com.nivek.sms.*

class BootStrap {

    def init = { servletContext ->

        if (!Usuario.find { username == "root" }) {
            def rolAdministradorGeneral = Rol.find { authority == "ROLE_ADMINISTRADOR_GENERAL" }

            if (!rolAdministradorGeneral)
                rolAdministradorGeneral = new Rol(authority: "ROLE_ADMINISTRADOR_GENERAL").save()

            def personaAdministradorGeneral = new Persona(nombres: "Nivek", apellidoPaterno: "Software", apellidoMaterno: "Solutions").save()
            def usuarioAdministradorGeneral = new Usuario(username: "root", password: "Mexico.2018", persona: personaAdministradorGeneral).save()
            UsuarioRol.create usuarioAdministradorGeneral, rolAdministradorGeneral
        }

        if (!Rol.find { authority == "ROLE_ADMINISTRADOR_INSTITUCION" })
            new Rol(authority: "ROLE_ADMINISTRADOR_INSTITUCION").save()

        if (!Rol.find { authority == "ROLE_ENCARGADO_ESPACIOS" })
            new Rol(authority: "ROLE_ENCARGADO_ESPACIOS").save()

        if (!Rol.find { authority == "ROLE_BENEFICIARIO_INSTITUCION" })
            new Rol(authority: "ROLE_BENEFICIARIO_INSTITUCION").save()

        if (!Rol.find { authority == "ROLE_VISOR_INSTITUCION" })
            new Rol(authority: "ROLE_VISOR_INSTITUCION").save()

        // Instituciones de prueba...
        def iKarimnot = new Institucion(nombre: "Karimnot", direccion: "Calle Col. Reforma", activa: true).save()
        def iLaSalle = new Institucion(nombre: "Universidad LaSalle Oaxaca", direccion: "Calle a San Agustín", activa: true).save()
        def iMacroscorp = new Institucion(nombre: "Macroscorp", direccion: "Calle Moctezuma", activa: true).save()
        def iNivek = new Institucion(nombre: "Nivek Software Solutions", direccion: "Edificio G, Salón 7", activa: true).save()
    }
    def destroy = {
    }
}
