function stena(xs,ys)

	firstId=0
	for x=0 to 15
		stenaid=CreateSprite(0)
		if firstId=0 then firstId=stenaid
		setspritephysicson(stenaid,1)
		SetSpriteSize(stenaid,30,9)
		SetSpritePositionByOffset(stenaid,xs+x*30,ys)
		SetSpriteColor(stenaid,250,0,0,255)
	next

endfunction firstId



