package nivek_2018_03_11espacios

import com.nivek.sms.*

class BootStrap {

    def init = { servletContext ->

        // ----------------------------
        // Código esencial para que funcione la aplicación
        // ----------------------------

        // Roles
        def rolAdministradorGeneral = Rol.find { authority == Rol.ADMINISTRADOR_GENERAL }
        if (!rolAdministradorGeneral)
            rolAdministradorGeneral = new Rol(authority: Rol.ADMINISTRADOR_GENERAL).save()

        def rolAdministradorInstitucion = Rol.find { authority == Rol.ADMINISTRADOR_INSTITUCION }
        if (!rolAdministradorInstitucion)
            rolAdministradorInstitucion = new Rol(authority: Rol.ADMINISTRADOR_INSTITUCION).save()

        def rolEncargadoEspacios = Rol.find { authority == Rol.ENCARGADO_ESPACIOS }
        if (!rolEncargadoEspacios)
            rolEncargadoEspacios = new Rol(authority: Rol.ENCARGADO_ESPACIOS).save()

        def rolBeneficiarioInstitucion = Rol.find { authority == Rol.BENEFICIARIO_INSTITUCION }
        if (!rolBeneficiarioInstitucion)
            rolBeneficiarioInstitucion = new Rol(authority: Rol.BENEFICIARIO_INSTITUCION).save()

        def rolVisorInstitucion = Rol.find { authority == Rol.VISOR_INSTITUCION }
        if (!rolVisorInstitucion)
            rolVisorInstitucion = new Rol(authority: Rol.VISOR_INSTITUCION).save()

        System.out.println(rolVisorInstitucion)
        System.out.println()

        // Usuario raíz
        if (!Usuario.find { username == "root" }) {
            def personaAdministradorGeneral =
                new Persona(
                    nombres: "Nivek",
                    apellidoPaterno: "Software",
                    apellidoMaterno: "Solutions").save()

            def usuarioAdministradorGeneral =
                new Usuario(
                    username: "root",
                    password: "Mexico.2018",
                    persona: personaAdministradorGeneral).save()

            UsuarioRol.create usuarioAdministradorGeneral, rolAdministradorGeneral
        }

        // Estados de solicitudes

        def estadoAprobada = SolicitudEstado.find { nombre == SolicitudEstado.APROBADA }
        if (!estadoAprobada)
            estadoAprobada = new SolicitudEstado(nombre: SolicitudEstado.APROBADA).save()

        def estadoEnRevision = SolicitudEstado.find { nombre == SolicitudEstado.EN_REVISION }
        if (!estadoEnRevision)
            estadoEnRevision = new SolicitudEstado(nombre: SolicitudEstado.EN_REVISION).save()

        def estadoRechazadaEncargado = SolicitudEstado.find { nombre == SolicitudEstado.RECHAZADA_ENCARGADO }
        if (!estadoRechazadaEncargado)
            estadoRechazadaEncargado = new SolicitudEstado(nombre: SolicitudEstado.RECHAZADA_ENCARGADO).save()

        def estadoRechazadaSistema = SolicitudEstado.find { nombre == SolicitudEstado.RECHAZADA_SISTEMA }
        if (!estadoRechazadaSistema)
            estadoRechazadaSistema = new SolicitudEstado(nombre: SolicitudEstado.RECHAZADA_SISTEMA).save()

        def estadoCanceladaUsuario = SolicitudEstado.find { nombre == SolicitudEstado.CANCELADA_USUARIO }
        if (!estadoCanceladaUsuario)
            estadoCanceladaUsuario = new SolicitudEstado(nombre: SolicitudEstado.CANCELADA_USUARIO).save()

        // ----------------------------
        // Termina código esencial para que funcione la aplicación
        // ----------------------------


        def r = null


        // ------------------------
        // Instituciones de prueba...
        // ------------------------
        def iKarimnot =
            new Institucion(
                nombre: "Karimnot",
                direccion: "Calle Col. Reforma",
                activa: false).save()


        def espacioSalaK1 =
            new Espacio(
                nombre: "Sala Karimnot 1",
                horaInicioDisponible: "08:00",
                horaFinDisponible: "19:30",
                dias: "1111100",
                institucion: iKarimnot).save()

        def espacioSalaK2 =
            new Espacio(
                nombre: "Sala Karimnot 2",
                horaInicioDisponible: "10:00",
                horaFinDisponible: "20:00",
                dias: "1100011",
                institucion: iKarimnot).save()

        def espacioSalaK3 =
            new Espacio(
                nombre: "Sala Karimnot 3",
                horaInicioDisponible: "15:00",
                horaFinDisponible: "18:00",
                dias: "1111000",
                institucion: iKarimnot).save()

        System.out.println(espacioSalaK1)
        System.out.println(espacioSalaK2)
        System.out.println(espacioSalaK3)


        def personaAdministradorK =
            new Persona(
                nombres: "Daniel Karim",
                apellidoPaterno: "Ricárdez",
                apellidoMaterno: "Ortiz").save()

        def usuarioAdministradorK =
            new Usuario(
                username: "karimnot",
                password: "Mexico.2018",
                persona: personaAdministradorK,
                institucion: iKarimnot).save()

        r = UsuarioRol.create usuarioAdministradorK, rolAdministradorInstitucion

        System.out.println(personaAdministradorK)
        System.out.println(usuarioAdministradorK)
        System.out.println(r)


        def personaEncargadoK1 =
            new Persona(
                nombres: "Encargado Karimnot Uno",
                apellidoPaterno: "Unknown",
                apellidoMaterno: "Unknown").save()

        def usuarioEncargadoK1 =
            new Usuario(
                username: "encargadok1",
                password: "Mexico.2018",
                persona: personaEncargadoK1,
                institucion: iKarimnot).save()

        r = UsuarioRol.create usuarioEncargadoK1, rolEncargadoEspacios

        System.out.println(personaEncargadoK1)
        System.out.println(usuarioEncargadoK1)
        System.out.println(r)


        def personaEncargadoK2 =
            new Persona(
                nombres: "Encargado Karimnot Dos",
                apellidoPaterno: "Unknown",
                apellidoMaterno: "Unknown").save()

        def usuarioEncargadoK2 =
            new Usuario(
                username: "encargadok2",
                password: "Mexico.2018",
                persona: personaEncargadoK2,
                institucion: iKarimnot).save()

        r = UsuarioRol.create usuarioEncargadoK2, rolEncargadoEspacios

        System.out.println(personaEncargadoK2)
        System.out.println(usuarioEncargadoK2)
        System.out.println(r)


        def personaBeneficiarioK1 =
            new Persona(
                nombres: "Beneficiario Karimnot Uno",
                apellidoPaterno: "Unknown",
                apellidoMaterno: "Unknown").save()

        def usuarioBeneficiarioK1 =
            new Usuario(
                username: "beneficiariok1",
                password: "Mexico.2018",
                persona: personaBeneficiarioK1,
                institucion: iKarimnot).save()

        r = UsuarioRol.create usuarioBeneficiarioK1, rolBeneficiarioInstitucion

        System.out.println(personaBeneficiarioK1)
        System.out.println(usuarioBeneficiarioK1)
        System.out.println(r)


        def personaBeneficiarioK2 =
            new Persona(
                nombres: "Beneficiario Karimnot Dos",
                apellidoPaterno: "Unknown",
                apellidoMaterno: "Unknown").save()

        def usuarioBeneficiarioK2 =
            new Usuario(
                username: "beneficiariok2",
                password: "Mexico.2018",
                persona: personaBeneficiarioK2,
                institucion: iKarimnot).save()

        r = UsuarioRol.create usuarioBeneficiarioK2, rolBeneficiarioInstitucion

        System.out.println(personaBeneficiarioK2)
        System.out.println(usuarioBeneficiarioK2)
        System.out.println(r)


        espacioSalaK1.addToUsuarios(usuarioEncargadoK1)
        espacioSalaK1.addToUsuarios(usuarioEncargadoK2)

        espacioSalaK2.addToUsuarios(usuarioEncargadoK1)

        espacioSalaK3.addToUsuarios(usuarioEncargadoK2)


        System.out.println()
        System.out.println()
        System.out.println()
        System.out.println()







        def iLaSalle = new Institucion(nombre: "Universidad LaSalle Oaxaca", direccion: "Calle a San Agustín", activa: true).save()







        def iMacroscorp =
            new Institucion(
                nombre: "Macroscorp",
                direccion: "Calle Moctezuma",
                activa: true).save()


        def espacioSalaM1 =
            new Espacio(
                nombre: "Sala Macroscorp 1",
                horaInicioDisponible: "08:00",
                horaFinDisponible: "19:30",
                dias: "1111100",
                institucion: iMacroscorp).save()

        def espacioSalaM2 =
            new Espacio(
                nombre: "Sala Macroscorp 2",
                horaInicioDisponible: "10:00",
                horaFinDisponible: "20:00",
                dias: "1100011",
                institucion: iMacroscorp).save()

        def espacioSalaM3 =
            new Espacio(
                nombre: "Sala Macroscorp 3",
                horaInicioDisponible: "15:00",
                horaFinDisponible: "18:00",
                dias: "1111000",
                institucion: iMacroscorp).save()

        System.out.println(espacioSalaM1)
        System.out.println(espacioSalaM2)
        System.out.println(espacioSalaM3)


        def personaAdministradorM =
            new Persona(
                nombres: "José Daniel",
                apellidoPaterno: "Alonso",
                apellidoMaterno: "Altamirano").save()

        def usuarioAdministradorM =
            new Usuario(
                username: "macroscorp",
                password: "Mexico.2018",
                persona: personaAdministradorM,
                institucion: iMacroscorp).save()

        r = UsuarioRol.create usuarioAdministradorM, rolAdministradorInstitucion

        System.out.println(personaAdministradorM)
        System.out.println(usuarioAdministradorM)
        System.out.println(r)


        def personaEncargadoM1 =
            new Persona(
                nombres: "Encargado Macroscorp Uno",
                apellidoPaterno: "Unknown",
                apellidoMaterno: "Unknown").save()

        def usuarioEncargadoM1 =
            new Usuario(
                username: "encargadom1",
                password: "Mexico.2018",
                persona: personaEncargadoM1,
                institucion: iMacroscorp).save()

        r = UsuarioRol.create usuarioEncargadoM1, rolEncargadoEspacios

        System.out.println(personaEncargadoM1)
        System.out.println(usuarioEncargadoM1)
        System.out.println(r)


        def personaEncargadoM2 =
            new Persona(
                nombres: "Encargado Macroscorp Dos",
                apellidoPaterno: "Unknown",
                apellidoMaterno: "Unknown").save()

        def usuarioEncargadoM2 =
            new Usuario(
                username: "encargadom2",
                password: "Mexico.2018",
                persona: personaEncargadoM2,
                institucion: iMacroscorp).save()

        r = UsuarioRol.create usuarioEncargadoM2, rolEncargadoEspacios

        System.out.println(personaEncargadoM2)
        System.out.println(usuarioEncargadoM2)
        System.out.println(r)


        def personaBeneficiarioM1 =
            new Persona(
                nombres: "Beneficiario Macroscorp Uno",
                apellidoPaterno: "Unknown",
                apellidoMaterno: "Unknown").save()

        def usuarioBeneficiarioM1 =
            new Usuario(
                username: "beneficiariom1",
                password: "Mexico.2018",
                persona: personaBeneficiarioM1,
                institucion: iMacroscorp).save()

        r = UsuarioRol.create usuarioBeneficiarioM1, rolBeneficiarioInstitucion

        System.out.println(personaBeneficiarioM1)
        System.out.println(usuarioBeneficiarioM1)
        System.out.println(r)


        def personaBeneficiarioM2 =
            new Persona(
                nombres: "Beneficiario Macroscorp Dos",
                apellidoPaterno: "Unknown",
                apellidoMaterno: "Unknown").save()

        def usuarioBeneficiarioM2 =
            new Usuario(
                username: "beneficiariom2",
                password: "Mexico.2018",
                persona: personaBeneficiarioM2,
                institucion: iMacroscorp).save()

        r = UsuarioRol.create usuarioBeneficiarioM2, rolBeneficiarioInstitucion

        System.out.println(personaBeneficiarioM2)
        System.out.println(usuarioBeneficiarioM2)
        System.out.println(r)


        espacioSalaM1.addToUsuarios(usuarioEncargadoM1)
        espacioSalaM1.addToUsuarios(usuarioEncargadoM2)

        espacioSalaM2.addToUsuarios(usuarioEncargadoM1)

        espacioSalaM3.addToUsuarios(usuarioEncargadoM2)


        System.out.println()
        System.out.println()
        System.out.println()
        System.out.println()







        def iNivek = new Institucion(nombre: "Nivek Software Solutions", direccion: "Edificio G, Salón 7", activa: true).save()
    }
    def destroy = {
    }
}
