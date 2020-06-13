--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--Here we have the three pictures that will be used to signify rewards
local star = love.graphics.newImage('star.png')
local skull = love.graphics.newImage('skull.png')
local ruby = love.graphics.newImage('ruby.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- This will display the different icons depending on the score that the player achieves;
	-- A skull for 10 points or more, meaning that the player can do better
	-- A star for 20 points or more, meaning that it was a good try but just a little harder
	-- A ruby for 30 points or more, meaning the player is really good at this
    if self.score >= 30 then
        love.graphics.draw(ruby, (VIRTUAL_WIDTH / 2) - (ruby:getWidth() / 16), (VIRTUAL_HEIGHT / 2) - (ruby:getHeight() / 16 + 10), 0, 0.125, 0.125)

    elseif self.score >= 20 then
        love.graphics.draw(star, (VIRTUAL_WIDTH / 2) - (star:getWidth() / 16), (VIRTUAL_HEIGHT / 2) - (star:getHeight() / 16 + 10), 0, 0.125, 0.125)

    elseif self.score >= 10 then
        love.graphics.draw(skull, (VIRTUAL_WIDTH / 2) - (skull:getWidth() / 16), (VIRTUAL_HEIGHT / 2) - (skull:getHeight() / 16 + 10), 0, 0.125, 0.125)

    end

    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end
