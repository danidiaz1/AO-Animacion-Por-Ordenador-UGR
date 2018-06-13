fn puntoMedioYAltura object1 object2=
(
	X = (object1.pos.x + object2.pos.x)/2
	Y = (object1.pos.y + object2.pos.y)/2
	Z1 = (object1.pos.z + object2.pos.z)/2
	
	dist_x = (object2.pos.x-object1.pos.x)*(object2.pos.x-object1.pos.x);
	dist_y = (object2.pos.y-object1.pos.y)*(object2.pos.y-object1.pos.y);
	dist_z = (object2.pos.z-object1.pos.z)*(object2.pos.z-object1.pos.z);
	Z2 = sqrt(dist_x+dist_y+dist_z)
	
	Z_final = Z1 + Z2;
	p = [X, Y, Z_final] 
	return p
)

s1 = Sphere radius:4 pos:[0,0,0] segs:40 name:"s1"
b1 = Box pos:[-30,0,-2.5] width:10 length:15 height:5 name:"box1"
b2 = Box pos:[30,0,-2.5] width:10 length:15 height:5 name:"box2"

animate on
( 
	at time 0   b1.pos = [-30,0,-2.5]
	at time 0   b2.pos = [30,0,-2.5]
	at time 0   s1.pos = [0,0,0]
)

animate on for t in 0 to 100 by 15 do 
(
	at time t (
		b1.pos = b1.pos + random [-25,-25,-25] [25,25,25]
		b2.pos = b2.pos + random [-25,-25,-25] [25,25,25]
		s1.pos = puntoMedioYAltura b1 b2
	)
)