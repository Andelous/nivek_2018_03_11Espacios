<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Calendario</title>
        <asset:stylesheet src="fullcalendar.print.min.css" media="print"/>
        <asset:stylesheet src="fullcalendar.min.css" />
        <asset:javascript src="moment.min.js"/>
        <asset:javascript src="fullcalendar.js"/>
        <g:javascript>
        setTimeout(function() {
            $(document).ready(function() {
              $('#calendar').fullCalendar({
                header: {
                  left: 'prev,next today',
                  center: 'title',
                  right: 'month,agendaWeek,agendaDay,listWeek'
                },
                defaultDate: '2018-04-16',
                navLinks: true,
                editable: true,
                eventLimit: true,
                events: [
                  {
                    title: 'Primer Evento',
                    start: '2018-04-01',
                  },
                  {
                    title: 'Evento de tres días',
                    start: '2018-04-07',
                    end: '2018-04-10'
                  },
                  {
                    id: 999,
                    title: 'Evento repetido',
                    start: '2018-04-09T16:00:00Z'
                  },
                  {
                    id: 999,
                    title: 'Evento repetido',
                    start: '2018-04-16T16:00:00Z'
                  },
                  {
                    title: 'Conferencia',
                    start: '2018-03-11',
                    end: '2018-03-13'
                  },
                  {
                    title: 'Junta',
                    start: '2018-03-12T10:30:00',
                    end: '2018-03-12T12:30:00'
                  }
                ]
              });

            });
          },1000);
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
    </body>
</html>
