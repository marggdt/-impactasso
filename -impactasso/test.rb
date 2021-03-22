sql_query = " \
  missions.title @@ :query \
  OR missions.lieu @@ :query \
  OR missions.type_mission @@ :query \
  OR missions.dispo @@ :query \
"

missions = Mission.where(sql_query, query: "%#{'Crias'}%")

ap "je sui sla"
ap missions
