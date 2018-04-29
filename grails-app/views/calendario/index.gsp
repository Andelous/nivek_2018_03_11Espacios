<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Calendario</title>
        <asset:stylesheet src="fullcalendar.print.min.css" media="print"/>
        <asset:stylesheet src="fullcalendar.min.css" />
        <asset:javascript src="moment.min.js"/>
        <asset:javascript src="fullcalendar.js"/>
        <asset:javascript src="es-us.js"/>
        <g:javascript>
        setTimeout(function() {
            $(document).ready(function() {
              var eventos = new Array();
              var it = 0;
              obj = {"title":null,
                      "start":null,
                      "end":null
                    }
              var tabla = document.getElementById('tablaDatos');
              for (var r = 1, n = tabla.rows.length; r < n; r++) {
                  for (var c = 0, m = tabla.rows[r].cells.length; c < m; c++) {
                       if(it == 1){
                        obj.title = tabla.rows[r].cells[c].innerHTML;
                      }else if(it == 2){
                        obj.start = tabla.rows[r].cells[c].innerHTML;
                      }else if(it == 3){
                        obj.end = tabla.rows[r].cells[c].innerHTML;
                      }
                      it++;
                      if(it == 4   ){
                        it = 0;
                        eventos.push(obj)
                        obj = {"title":null,
                                "start":null,
                                "end":null
                              }
                      }
                  }
              }

              $('#calendar').fullCalendar({
                locale: 'es-us',
                header: {
                  left: 'prev,next today',
                  center: 'title',
                  right: 'month,agendaWeek,agendaDay,listWeek'
                },
                navLinks: true,
                editable: false,
                eventLimit: true,
                events: eventos
              });


            });
          },1);
        </g:javascript>
        <style>
          body {
            padding: 0;
            font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
            font-size: 14px;
          }

          #calendar {
            max-width: 900px;
            margin: 0 auto;
          }

        </style>
    </head>
    <body>
    <div id='calendar'></div>
      <div style="display: none" >
        <p>Prueba de datos</p>
        <table id="tablaDatos" class="table  table-hover">
          <thead class="thead-dark">
            <th>usuario</th>
            <th>titulo</th>
            <th>fechaInicio</th>
            <th>fechaFin</th>
          </thead>
          <tbody>
            <g:each in="${solicitudes}" var="sol">
              <tr>
                <td>${sol.usuario.username}</td>
                <td>${sol.razon}</td>
                <td>${sol.fecha.format('yyyy-MM-dd')+'T'+sol.horaInicio+':00.00Z'}</td>
                <td>${sol.fecha.format('yyyy-MM-dd')+'T'+sol.horaFin+':00.00Z'}</td>
              </tr>
            </g:each>
          </tbody>
        </table>
      </div>
    </body>
</html>
