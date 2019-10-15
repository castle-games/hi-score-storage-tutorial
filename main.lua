local State = {
   score = 0,
   highScore = 0,
}

local Box = {
   x = 100,
   y = 50,
   width = 100,
   height = 100,
}

local HIGH_SCORE_STORAGE_KEY = 'highscore'

function love.load()
   loadHighScore()
end

function love.draw()
   love.graphics.setColor(1, 1, 0, 1)
   love.graphics.rectangle('fill', Box.x, Box.y, Box.width, Box.height)

   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.print('you clicked the box ' .. State.score .. ' times', 50, 175)

   if State.highScore > 0 then
      love.graphics.setColor(1, 0, 1, 1)
      love.graphics.print('your best score: ' .. State.highScore .. ' clicks', 50, 195)
   end
end

function love.mousepressed(x, y)
   if isInBox(x, y) then
      State.score = State.score + 1
      if State.score > State.highScore then
         saveHighScore(State.score)
      end
   end
end

function isInBox(x, y)
   return x >= Box.x
      and y >= Box.y
      and x <= Box.x + Box.width
      and y <= Box.y + Box.height
end

function saveHighScore(score)
   State.highScore = score
   network.async(function()
         castle.storage.set(HIGH_SCORE_STORAGE_KEY, score)
   end)
end

function loadHighScore()
   network.async(function()
         local highScore = castle.storage.get(HIGH_SCORE_STORAGE_KEY)
         if not (highScore == nil) then
            State.highScore = highScore
         end
   end)
end
