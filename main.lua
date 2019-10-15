local State = {
   score = 0,
}

local Box = {
   x = 100,
   y = 50,
   width = 100,
   height = 100,
}

function love.draw()
   love.graphics.setColor(1, 1, 0, 1)
   love.graphics.rectangle('fill', Box.x, Box.y, Box.width, Box.height)

   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.print('you clicked the box ' .. State.score .. ' times', 50, 175)
end

function love.mousepressed(x, y)
   if isInBox(x, y) then
      State.score = State.score + 1
   end
end

function isInBox(x, y)
   return x >= Box.x
      and y >= Box.y
      and x <= Box.x + Box.width
      and y <= Box.y + Box.height
end
