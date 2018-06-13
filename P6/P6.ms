function ajustarPosicion Traveler Clone Terreno Inicio Fin =
(
	animate on 
	(
		for t in Inicio to Fin do
		(
			at time t
			(
				/*Ajustamos la posicion en x,y del objeto clon */
				Clone.pos.x = Traveler.pos.x
				Clone.pos.y = Traveler.pos.y
				
				/*Ajustamos la posición en z del objeto clon */
				/* Rayo desde el objeto original hacia "abajo" */
				Rayo = ray Traveler.pos [0,0,-1]
				
				/* Colisión con el terreno */
				global Colision = IntersectRay Terreno Rayo
				
				/* Para que la esfera no "atraviese" el terreno, tenemos que desplazarla
				en una cantidad igual a su radio a lo largo del vector normal que nos
				da la colisión */
				Clone.pos = ( (normalize Colision.dir) * Clone.radius  ) + Colision.pos
			)
		)
	)
)

function ajustarRotacion Traveler Inicio Fin = 
(	
	animate on 
	(
		for t in Inicio to Fin do
		(
			at time t
			(
				/* Restamos la posición en t del objeto con su posición en t-1 para obtener el vector de dirección */
				directionVector = Traveler.pos - (at time (t-1) (Traveler.pos))
					
				/* El vector de rotación será perpendicular al vector de dirección 
					El producto vectorial de dos vectores nos da un vector perpendicular
					a dichos vectores. En nuestro caso, serán el vector de dirección (que está sobre
					el plano [x,y]) y el vector que representa al eje z de la pelota*/
				rotationVector = cross directionVector Colision.dir
				
				/* Ángulo de rotación del objeto */
				rotationAngle = ((length directionVector)/(Traveler.radius*pi))*180
				
				/* Quaternion [angulo de rotacion] [vector de rotacion] */
				quaternion = quat rotationAngle (normalize rotationVector)
				
				/* Convertimos el quaternion a una rotación de Euler para saber cuanto hay que
					rotar en x, y, z */
				eulerRotation = QuatToEuler quaternion
				
				/* Rotamos el objeto */
				rotate Traveler eulerRotation
			)
		)
	)
)

rollout dialog1 "Animación de un objeto sobre un terreno."
(
	group "Actores" (
		label labelObjPrincipal "Objeto principal:"
		button buttonObjPrincipal "Selecciona el objeto y pulsa"
		label labelObjClon "Objeto clon:"
		button buttonObjClon "Selecciona el objeto y pulsa"
		label labelObjTerr "Objeto terreno:"
		button buttonObjTerr "Selecciona el objeto y pulsa"
	)
	
	group "Duración de la animación"(
		spinner UI_IF "Comienzo de la animación: " range:[0,1000,0] type:#Integer
		spinner UI_FF "Fin de la animación: " range:[1,1000,100] type:#Integer
	)

	button UI_CrearAnimacion "Crear animación"
	
	on buttonObjPrincipal pressed do
	(
		objectsSelected =getCurrentSelection()
		if (objectsSelected.count == 0) then (
			buttonObjPrincipal.text = "Selecciona un objeto"
		) else (
			global Traveler = objectsSelected[1]
			buttonObjPrincipal.text = "Objeto " + Traveler.name + " seleccionado"
		)
	)
	
	on buttonObjClon pressed do
	(
		objectsSelected =getCurrentSelection()
		if (objectsSelected.count == 0) then (
			buttonObjClon.text = "Selecciona un objeto"
		) else (
			global Clon = objectsSelected[1]
			buttonObjClon.text = "Objeto " + Clon.name + " seleccionado"
		)
	)
	
	on buttonObjTerr pressed do
	(
		objectsSelected =getCurrentSelection()
		if (objectsSelected.count == 0) then (
			buttonObjTerr.text = "Selecciona un objeto"
		) else (
			global Terreno = objectsSelected[1]
			buttonObjTerr.text = "Objeto " + Terreno.name + " seleccionado"
		)
	)

	on UI_CrearAnimacion pressed do
	(
		if ((Traveler!= undefined) AND (Clon != undefined) AND (Terreno !=undefined)) do
		(
			deletekeys Clon

			inicio = UI_IF.value
			fin = UI_FF.value
			
			ajustarPosicion Traveler Clon Terreno inicio fin
			ajustarRotacion Clon (inicio+1) fin
		)
    )
)

createDialog dialog1 width:325 height:275 lockHeight:false lockWidth:false \
	style:#(#style_titlebar, #style_border, #style_sysmenu, \
		#style_minimizebox, #style_maximizebox, #style_resizing) 