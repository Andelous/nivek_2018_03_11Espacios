package nivek_2018_03_11espacios

import com.nivek.sms.Usuario
import com.nivek.sms.Rol
import com.nivek.sms.UsuarioRol
import com.nivek.sms.Persona

class BootStrap {

    def init = { servletContext ->

        if (!Usuario.find { username: "root" }) {
            def rolAdministradorGeneral = Rol.find { authority == "ROLE_ADMINISTRADOR_GENERAL" }

            if (!rolAdministradorGeneral)
                rolAdministradorGeneral = new Rol(authority: "ROLE_ADMINISTRADOR_GENERAL").save()

            def personaAdministradorGeneral = new Persona().save()
            def usuarioAdministradorGeneral = new Usuario(username: "root", password: "Mexico.2018", persona: personaAdministradorGeneral).save()
            UsuarioRol.create usuarioAdministradorGeneral, rolAdministradorGeneral
        }

    }
    def destroy = {
    }
}
