-- Script made by Oysi - built upon by jordan4ibanez
dofile("helper.lua")
dofile("movement.lua")


vertex  = {}
vertpos = {}
--generate a face
for i = 1, 5 do
	vertex[i] = {}
	for z = 1,4 do
		vertex[i][1] = {
						x = -1;
						y = -1;
						z = i-10;
						}
		vertex[i][2] = {
						x = 1;
						y = -1;
						z = i-10;
						}
		vertex[i][3] = {
						x = 1;
						y = 1;
						z = i-10;
						}
		vertex[i][4] = {
						x = -1;
						y = 1;
						z = i-10;
						}
	end
	vertpos[i] = {
					x=0,
					y=0,
					z=i,
				}
end


    
function love.load(delta)
	windowwidth   = love.graphics.getWidth()
	windowheight  = love.graphics.getHeight()
	windowcenter  = {windowwidth/2,windowheight/2}
	love.mouse.setVisible(false)
	dirt = love.graphics.newImage("dirt.png")
	pos        = {0,0,0} --x,y,z
	oldpos     = {0,0,0} --x,y,z
	lookpos    = {0,0}
	oldlookpos = {0,0}
	sorted     = 1
end


function love.draw()
	sortdistances()
	for _, vertex in pairs(vertex) do
		--point1
		local vector = {}
		for i = 1,tablelength(vertex) do 
			if vertex[i].z < 0 then
					local x = vertex[i].x / -vertex[i].z
					local y = vertex[i].y / -vertex[i].z * -1
				   
					x = 400 + x*400
					y = 300 + y*400
				   
					love.graphics.circle("fill", x, y, 2/-vertex[i].z, 10)
					
					--do some texture mapping
					if i == 1 then
						w,e = 0,0
					elseif i == 2 then
						w,e = 0,1
					elseif i == 3 then
						w,e = 1,1
					elseif i == 4 then
						w,e = 1,0			
					end
					table.insert(vector, {x,y,w,e, 255,255,255})
			end
		end
		
		
		--this is a cheap way of rendering the faces
		local render = true
		for i = 1,tablelength(vertex) do
			if vertex[i].z < 0 then
				--pass
			else
				render = false
			end
		end
		--print_r(vector)
		if render == true then
			local mesh = love.graphics.newMesh(vector, dirt, "fan")
			
			--local mesh = love.graphics.newMesh({{0,0}, {566,563}, {255,255,255,255}}, dirt, "fan")

			love.graphics.draw(mesh, 0, 0)
			--old draw line stuff
			--love.graphics.line(vector[1][1],vector[1][2],vector[2][1],vector[2][2],vector[3][1],vector[3][2],vector[4][1],vector[4][2],vector[1][1],vector[1][2])
			
		end
	end
end

function sortdistances()

	local sortedlist = {}
	local secondsortedlist = {}
	local count = 1
	print("distances:")
	for _, vertex in pairs(vertex) do
		--let's get the center of the face
		local xmean = vertpos[count].x
		local ymean = vertpos[count].y
		local zmean = vertpos[count].z

		
		local howfar = distance ( xmean, ymean, zmean, pos[1], pos[2], pos[3] )

		sortedlist[howfar] = vertex
		
		table.insert(secondsortedlist, howfar)
		
		count = count + 1
	end
	
	table.sort(secondsortedlist, function(a,b) return a*100000<b*100000 end)
	vertex = {}
	for i = 1,tablelength(secondsortedlist) do
		vertex[i] =  sortedlist[secondsortedlist[i]]
	end

	sorted = true

end


function love.update(delta)
	--mousepole()
	movement(delta)			
	--print(distance(pos[1],pos[2],pos[3],vertpos[1].x,vertpos[1].y,vertpos[1].z))
end

function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   end
end

function shakefaces()
	for _, vertex in pairs(vertex) do
		local xadd = ((math.random()*math.random(-1,1))/math.random(10,100))
		local zadd = ((math.random()*math.random(-1,1))/math.random(10,100))	
		for i = 1,tablelength(vertex) do 
				vertex[i].x = vertex[i].x + xadd
				vertex[i].z = vertex[i].z + zadd
		end
	end
end

