tea1 = Teapot pos:[0,0,0] radius:10 name:"tea1"
tea2 = Teapot pos:[-30,0,0] radius:5 name:"tea2"
tea3 = Teapot pos:[-50,0,0] radius:5 name:"tea3"
tea4 = Teapot pos:[-70,0,0] radius:5 name:"tea4"
pos_x = 0
pos_y = 0

animate on
( 
	for t in 0 to 100 by 25 do
	(
		at time t 
		(    
			tea1.pos = [pos_x, pos_y, 0]
			tea2.pos = [tea1.pos.x-30, pos_y, 0]
			tea3.pos = [tea1.pos.x-50, pos_y, 0]
			tea4.pos = [tea1.pos.x-70, pos_y, 0]
			pos_x += 15
			if ((mod t 2) == 0) then 
				pos_y += 15
			else
				pos_y *= -1
		)
	)
)

moveKeys $tea2.pos.controller 25f
moveKeys $tea3.pos.controller 50f
moveKeys $tea4.pos.controller 75f