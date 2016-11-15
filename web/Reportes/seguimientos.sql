select S.fecha,S.observaciones,S.id_solicitud,S.id_status,T.nombre as estatus,O.id_tramite,O.id_solicitud,O.id_solicitante,M.nombre as tramite,M.id_tramite, concat(A.nombre,A.apellido_paterno,A.apellido_materno)as solicitante,A.id_solicitante from seguimiento S inner join status T on S.id_status=T.id_status inner join solicitud O on O.id_solicitud=S.id_solicitud inner join tramite M on M.id_tramite=O.id_tramite inner join solicitante A on A.id_solicitante=O.id_solicitante order by S.fecha desc