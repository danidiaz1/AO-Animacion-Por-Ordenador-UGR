fn interpolacionLineal t fps pos1 pos2 =(
	V = pos2-pos1
	return (pos1+((normalize V)*(((length V)/fps)*t)))
)

fn interpolacionCuadratica t fps p1 p2 p3 =(
	q1 = interpolacionLineal t fps p1 p2
	q2 = interpolacionLineal t fps p2 p3
	return (interpolacionLineal t fps q1 q2)
)

fn puntoMedio pos1 pos2 =(
	X = (pos1.x + pos2.x)/2
	Y = (pos1.y + pos2.y)/2
	Z = (pos1.z + pos2.z)/2

	return [X,Y,Z]
)

fn distancia pos1 pos2 =(

	return sqrt((pos1.x-pos2.x)^2 + (pos1.y-pos2.y)^2 + (pos1.z-pos2.z)^2)
)

fn Animar Traveler CP1 CP2 CP3 stretchL stretchI stretchS AnguloL AnguloS Inicio Fin  =
(
	animate on
	(
		at time Inicio (
			Traveler.modifiers[#stretchSaltos].Stretch = stretchI
			Traveler.rotation.y = 0
		)
		
		at time (Inicio+((Fin-Inicio)/10)) (
			Traveler.modifiers[#stretchSaltos].Stretch = stretchS
			rotate Traveler (eulerangles 0 AnguloS 0)
		)
		
		at time ((Fin+Inicio)/2) (
			Traveler.modifiers[#stretchSaltos].Stretch = 0
			Traveler.rotation.y = 0
		)
		
		at time (Fin-((Fin-Inicio)/10)) (
			Traveler.modifiers[#stretchSaltos].Stretch = stretchL
			rotate Traveler (eulerangles 0 AnguloL 0)
		)
		
		at time Fin (
			Traveler.modifiers[#stretchSaltos].Stretch = stretchI
			Traveler.rotation.y = 0
		)
		
		for t in Inicio to Fin by 1 do
		(
			at time t
			(
				Traveler.pos = interpolacionCuadratica (t-Inicio) (Fin-Inicio) CP1 CP2 CP3
			)
		)
		
	)
)

fn addStretch obj nombre =
(
	for m in obj.modifiers do
	(
		if (m.name == nombre) do (
			deleteModifier obj m
		)
	)
	
	myStretch = Stretch()
	myStretch.name = nombre
	addmodifier obj myStretch	
)

rollout Saltos "Saltos"
(
	group "Objetos que intervienen" (
		label LActor "Actor:"
		button UI_SelectorActor "Selecciona actor y pulsa"
		label LObjetos "Objetos:"
		button UI_SelectorObjects "Selecciona objetos y pulsa para establecer puntos de salto"
	)
	
	group "Squash and Stretch" (
		spinner UI_StretchL "Stretch de llegada del salto: " range:[-1,1,0.4] type:#Float
		spinner UI_StretchI "Stretch de impacto: " range:[-1,1,-0.25] type:#Float
		spinner UI_StretchS "Stretch de salida del salto: " range:[-1,1,0.5] type:#Float
	)
	
	group "Ángulo del salto" (
		spinner UI_AnguloL "Angulo de llegada del salto: " range:[-360,360,-20] type:#Float
		spinner UI_AnguloS "Angulo de salida del salto: " range:[-360,360,20] type:#Float
	)
	
	group "Tiempo de la animación"(
		spinner UI_IF "Comienzo de la animación: " range:[0,1000,0] type:#Integer
		spinner UI_FF "Duracion de la animación: " range:[5,1000,20] type:#Integer
	)
	
	button UI_CrearAnimacion "Crear animación"
	
	on UI_SelectorActor pressed do
	(
		objectsSelected =getCurrentSelection()
		if (objectsSelected.count == 0) then (
			UI_SelectorActor.text = "Selecciona al menos un objeto"
		) else (
			global Traveler = objectsSelected[1]
			UI_SelectorActor.text = Traveler.name
		)
	)
	
	on UI_SelectorObjects pressed do
	(
		objectsSelected = getCurrentSelection()
		if (objectsSelected.count == 0) then (
			UI_SelectorObjects.text = "Selecciona al menos un objeto"
		) else (
			global objs = #()
			for obj in objectsSelected do (
				append objs obj
			)
			UI_SelectorObjects.text = "Objetos establecidos"
		)
	)
	
	on UI_CrearAnimacion pressed do
	(
		if Traveler!= undefined do
		(
			deletekeys Traveler
			Traveler.dir = [0,0,1]
			
			addStretch Traveler "stretchSaltos"
			
			inicio = UI_IF.value
			fin = UI_FF.value+inicio
			
			animate on
			(
				at time 0 ( 
					Traveler.pos = objs[1].pos
					Traveler.modifiers[#stretchSaltos].Stretch = UI_StretchI.value
				)
			)
			
			intervalo = (fin-inicio)/(objs.count-1) as integer
			fin = inicio+intervalo
			
			for i=1 to (objs.count-1) do (
				pMedio = puntoMedio objs[i].pos objs[i+1].pos
				pMedio.z = pMedio.z + (distancia objs[i].pos objs[i+1].pos)

				Animar Traveler objs[i].pos pMedio objs[i+1].pos \
					UI_StretchL.value UI_StretchI.value UI_StretchS.value \
					UI_AnguloL.value UI_AnguloS.value \
					inicio fin
				
				inicio = fin
				fin = inicio+intervalo
			)
			
			Traveler.showtrajectory = on
		)
    )
)

createDialog Saltos width:325 height:370 lockHeight:false lockWidth:false \
	style:#(#style_titlebar, #style_border, #style_sysmenu, \
		#style_minimizebox, #style_maximizebox, #style_resizing) 
    