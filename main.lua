-- Variables globales
local sounds = {}
local patterns = {
    { 1: Punk Rock
        { kick = true, snare = false, hihat = true }, 
        { kick = false, snare = true, hihat = true },  
        { kick = true, snare = false, hihat = true },  
        { kick = true, snare = false, hihat = true },  
        { kick = false, snare = true, hihat = true },  
        { kick = true, snare = false, hihat = true },  
        { kick = false, snare = true, hihat = true },  
        { kick = true, snare = false, hihat = true },  
        { kick = true, snare = false, hihat = true },  
        { kick = false, snare = true, hihat = true },  
        { kick = false, snare = false, hihat = true }, 
        { kick = false, snare = false, hihat = true }, 
        { kick = false, snare = false, hihat = true }, 
        { kick = false, snare = false, hihat = true }, 
        { kick = false, snare = false, hihat = true }, 
        { kick = false, snare = false, hihat = true },
    },
    { -- 2: Ritmo más lento
        { kick = true, snare = false, hihat = false }, 
        { kick = false, snare = true, hihat = false },  
        { kick = true, snare = false, hihat = true },  
        { kick = false, snare = true, hihat = false },  
        { kick = true, snare = false, hihat = true },  
        { kick = false, snare = true, hihat = false },  
        { kick = true, snare = false, hihat = false },  
        { kick = false, snare = true, hihat = true },  
        { kick = true, snare = true, hihat = true },  
        { kick = false, snare = false, hihat = true },  
        { kick = false, snare = false, hihat = false }, 
        { kick = true, snare = false, hihat = true }, 
        { kick = false, snare = true, hihat = false }, 
        { kick = true, snare = false, hihat = true }, 
        { kick = false, snare = true, hihat = false }, 
        { kick = true, snare = true, hihat = true },
    },
    { -- 3: Funk
        { kick = true, snare = false, hihat = true }, 
        { kick = false, snare = true, hihat = true },  
        { kick = false, snare = false, hihat = true }, 
        { kick = true, snare = false, hihat = false }, 
        { kick = true, snare = true, hihat = true }, 
        { kick = false, snare = false, hihat = true }, 
        { kick = false, snare = true, hihat = true }, 
        { kick = true, snare = false, hihat = false }, 
        { kick = true, snare = true, hihat = true }, 
        { kick = false, snare = false, hihat = true }, 
        { kick = false, snare = true, hihat = false }, 
        { kick = true, snare = false, hihat = true }, 
        { kick = true, snare = true, hihat = true }, 
        { kick = false, snare = false, hihat = true }, 
        { kick = false, snare = true, hihat = false }, 
        { kick = true, snare = true, hihat = true },
    },
    { -- 4: Electrónico básico
        { kick = true, snare = false, hihat = true }, 
        { kick = false, snare = true, hihat = false },  
        { kick = true, snare = false, hihat = true },  
        { kick = false, snare = false, hihat = true },  
        { kick = true, snare = true, hihat = true }, 
        { kick = false, snare = false, hihat = false }, 
        { kick = true, snare = false, hihat = true }, 
        { kick = false, snare = true, hihat = false }, 
        { kick = true, snare = true, hihat = true }, 
        { kick = false, snare = false, hihat = true }, 
        { kick = true, snare = false, hihat = false }, 
        { kick = false, snare = true, hihat = true }, 
        { kick = true, snare = true, hihat = true }, 
        { kick = false, snare = false, hihat = false }, 
        { kick = true, snare = true, hihat = true }, 
        { kick = false, snare = false, hihat = true },
    }
}
local currentPattern = 1 
local step = 1
local bpm = 120
local stepDuration = 60 / bpm / 4
local elapsedTime = 0

function love.load()
    sounds.kick = love.audio.newSource("kick.wav", "static")
    sounds.snare = love.audio.newSource("snare.wav", "static")
    sounds.hihat = love.audio.newSource("hihat.wav", "static")
end

function love.update(dt)
    elapsedTime = elapsedTime + dt
    if elapsedTime >= stepDuration then
        elapsedTime = elapsedTime - stepDuration
        playStep(step)
        step = step + 1
        if step > #patterns[currentPattern] then
            step = 1
        end
    end
end

function playStep(step)
    local currentStep = patterns[currentPattern][step]
    if currentStep.kick then
        sounds.kick:stop()
        sounds.kick:play()
    end
    if currentStep.snare then
        sounds.snare:stop()
        sounds.snare:play()
    end
    if currentStep.hihat then
        sounds.hihat:stop()
        sounds.hihat:play()
    end
end

function love.keypressed(key)
    if key == "space" then
        currentPattern = currentPattern % #patterns + 1 -- Alternar entre los patrones
    end
end

function love.draw()
    love.graphics.print("Patrón actual: " .. currentPattern, 10, 10)
    love.graphics.print("Step: " .. step, 10, 30)
    love.graphics.print("Presiona 'Espacio' para cambiar el ritmo", 10, 50)
end
