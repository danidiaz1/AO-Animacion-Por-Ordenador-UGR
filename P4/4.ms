fn interpolacionLineal t fps p1 p2 =(
	V = p2-p1
	return (p1+((normalize V)*(((length V)/fps)*t)))
)

fn interpolacionCuadratica t fps p1 p2 p3 =(
	q1 = interpolacionLineal t fps p1 p2
	q2 = interpolacionLineal t fps p2 p3
	return (interpolacionLineal t fps q1 q2)
)

fn interpolacionCubica t fps p1 p2 p3 p4 =(
	r1 = interpolacionCuadratica t fps p1 p2 p3
	r2 = interpolacionCuadratica t fps p2 p3 p4
	return (interpolacionLineal t fps r1 r2)
)

s1 = Sphere radius:3 pos:[0,0,0] segs:32 wireColor:blue
s2 = Sphere radius:3 pos:[0,0,0] segs:32 wireColor:blue
s3 = Sphere radius:4 pos:[0,0,0] segs:32 wireColor:red
b1 =Box pos:[-50,-50,0] width:5 length:5 height:5 wireColor:green
b2 =Box pos:[50,25,0] width:5 length:5 height:5 wireColor:green
b3 =Box pos:[0,-25,0] width:5 length:5 height:5 wireColor:green
b4 =Box pos:[100,100,0] width:5 length:5 height:5 wireColor:green

animate on(
	for t in 0 to 100 by 1 do(
		at time t (
			s1.pos = interpolacionCuadratica t 100 b2.pos b3.pos b4.pos
			s2.pos = interpolacionCuadratica t 100 b1.pos b2.pos b3.pos
			s3.pos = interpolacionCubica t 100 b1.pos b2.pos b3.pos b4.pos
		)
	)
	--s1.showTrajectory = on;
	--s2.showTrajectory = on;
	s3.showTrajectory = on;
)