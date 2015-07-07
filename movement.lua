function translate(x, y, z)
	for _, vertex in pairs(vertex) do
			for i = 1,tablelength(vertex) do
				vertex[i].x = vertex[i].x + x
				vertex[i].y = vertex[i].y + y
				vertex[i].z = vertex[i].z + z
			end
	end
end

function rotateY(r)
	local cosR = math.cos(r)
	local sinR = math.sin(r)
	
	for _, vertex in pairs(vertex) do
			for i = 1,tablelength(vertex) do 
				local x = vertex[i].x
				local z = vertex[i].z
				vertex[i].x = x*cosR + z*-sinR
				vertex[i].z = x*sinR + z*cosR
			end
	end
end



function mousecontrols(rotSpeed)
	mousex, mousey = love.mouse.getPosition( )
	movex, movey   = mousex-windowcenter[1],mousey-windowcenter[2]
	
	oldlookpos = {lookpos[1],lookpos[2]}
	
	lookpos[1] = lookpos[1] -rotSpeed*(movex/100)
	
	rotateY(lookpos[1]-oldlookpos[1])
	
	love.mouse.setPosition(windowcenter[1],windowcenter[2])
end

function movement(delta)
	local moveSpeed = delta*5
	local rotSpeed = delta*5
	
	
	mousecontrols(rotSpeed)
	
	
	oldpos = {pos[1],pos[2],pos[3]}
	
	if love.keyboard.isDown("a") then
		pos[1] = pos[1] + moveSpeed
	end
	if love.keyboard.isDown("d") then
		pos[1] = pos[1] - moveSpeed
	end

	if love.keyboard.isDown("w") then
		pos[3] = pos[3] + moveSpeed
	end
	if love.keyboard.isDown("s") then
		pos[3] = pos[3] - moveSpeed
	end
	
	if love.keyboard.isDown(" ") then
			pos[2] = pos[2] - moveSpeed
	end
	if love.keyboard.isDown("lshift") then
			pos[2] = pos[2] + moveSpeed
	end	
	
	
	--[[
	if love.keyboard.isDown("q") then
			rotateY(rotSpeed)
	end
	if love.keyboard.isDown("e") then
			rotateY(-rotSpeed)
	end
	
	translate(0, 0, -moveSpeed)
	
	]]--
	
	translate(pos[1]-oldpos[1], pos[2]-oldpos[2], pos[3]-oldpos[3])
	
	return(sorted)
	
	
end
