<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Usuarios</title>
    </head>
    <body>
        <div class="row">
            <div class="col-md-10">

                <div class="row">

                    <h4 class="col-md-5 mb-0 text-center">
                        <span class="oi oi-people"></span>
                        Listado de usuarios
                    </h4>

                    <div class="col-md mb-0 ml-auto">
                        <form class="form-inline w-100">
                            <div class="input-group col-md">

                                <input type="text" name="q"
                                    class="form-control form-control-sm"
                                    placeholder="Nombre"
                                    value=""
                                    aria-describedby="basic-addon2">

                                    <div class="input-group-append">
                                        <button type="submit" class="btn btn-outline-secondary btn-sm">
                                            <small><span class="oi oi-magnifying-glass"></span></small>
                                        </button>
                                    </div>
                            </div>

                            <div class="form-group">
                                <label>Instituci&oacute;n</label>&nbsp;
                                <select class="form-control form-control-sm" id="selectRol">
                                    <option value="todos">Todas</option>
                                    <option value="desarrollador">Universidad La Salle Oaxaca</option>
                                    <option value="directivo">Karimnot</option>
                                    <option value="administrativo">Macroscorp</option>
                                    <option value="secretario">Harim Inc.</option>
                                    <option value="secretario">Nivek Software Solutions</option>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>


            </div>



            <div class="col-md-2 border border-top-0 border-bottom-0 border-right-0">
                <a href="#" class="btn btn-primary btn-sm btn-block">
                    <span class="oi oi-plus"></span> Nuevo usuario
                </a>
            </div>
        </div>

        <hr />


        <table class="table">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Rol</th>
                    <th scope="col">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th scope="row">1</th>
                    <td>Alonso Tovar &Aacute;ngel Daniel</td>
                    <td>Administrador de Instituci&oacute;n</td>
                    <td>
                        <a class="btn btn-link btn-sm text-dark" href="#">
                            <span class="oi oi-pencil text-primary"></span>
                            Editar
                        </a>
                        <a href="#" class="btn btn-link btn-sm text-dark" data-toggle="modal">
                            <span class="oi oi-circle-x text-danger"></span>
                            Eliminar
                        </a>
                    </td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>Gonz&aacute;lez Santiago Eduardo Luis</td>
                    <td>Beneficiario de Instituci&oacute;n</td>
                    <td>
                        <a class="btn btn-link btn-sm text-dark" href="#">
                            <span class="oi oi-pencil text-primary"></span>
                            Editar
                        </a>
                        <a href="#" class="btn btn-link btn-sm text-dark" data-toggle="modal">
                            <span class="oi oi-circle-x text-danger"></span>
                            Eliminar
                        </a>
                    </td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>Lindner D&iacute;az Stuart <strong>Kevin</strong></td>
                    <td>Encargado de Espacios</td>
                    <td>
                        <a class="btn btn-link btn-sm text-dark" href="#">
                            <span class="oi oi-pencil text-primary"></span>
                            Editar
                        </a>
                        <a href="#" class="btn btn-link btn-sm text-dark" data-toggle="modal">
                            <span class="oi oi-circle-x text-danger"></span>
                            Eliminar
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
