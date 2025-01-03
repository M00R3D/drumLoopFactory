-- Variables globales
local sounds = {}
local patterns = {
    { -- 1: Punk Rock
        { kick = true, snare = false, hihat = true },
        { kick = false, snare = true, hihat = true },
        { kick = true, snare = false, hihat = true },
        { kick = false, snare = true, hihat = false },
    },
    { -- 2: Ritmo más lento
        { kick = true, snare = false, hihat = true },
        { kick = false, snare = false, hihat = true },
        { kick = false, snare = true, hihat = true },
        { kick = false, snare = false, hihat = true },
    },
    { -- 3: Funk
        { kick = true, snare = false, hihat = true },
        { kick = true, snare = false, hihat = true },
        { kick = false, snare = true, hihat = true },
        { kick = false, snare = false, hihat = true },
    },
    { -- 4: Stoner Rock
        { kick = true, snare = false, hihat = true },
        { kick = true, snare = true, hihat = false },
        { kick = false, snare = true, hihat = true },
        { kick = true, snare = false, hihat = false },
    },
    { -- 5: Surf
        { kick = false, snare = true, hihat = true, crash = true },
        { kick = true, snare = false, hihat = true },
        { kick = true, snare = true, hihat = false },
        { kick = false, snare = true, hihat = true },
    },
    { -- 6: Electrónico variado
        { kick = true, snare = true, hihat = false },
        { kick = false, snare = false, hihat = true },
        { kick = false, snare = true, hihat = true },
        { kick = true, snare = false, hihat = false },
        { kick = true, snare = true, hihat = true },
    },
    { -- 7: Patrón 8 golpes + crash
        { kick = true, snare = false, hihat = true ,swing=true,crash=true},
        { kick = true, snare = false, hihat = false },
        { kick = false, snare = false, hihat = true ,swing=true},
        { kick = true, snare = false, hihat = false },
        { kick = false, snare = true, hihat = true ,swing=true},
        { kick = true, snare = false, hihat = false },
        { kick = true, snare = false, hihat = true ,swing=true},
        { kick = false, snare = true, hihat = true },
    },
    { -- 8: Patrón 8 golpes
        { kick = true, snare = false, hihat = true },
        { kick = true, snare = false, hihat = false },
        { kick = false, snare = false, hihat = true },
        { kick = true, snare = false, hihat = false },
        { kick = false, snare = true, hihat = true },
        { kick = true, snare = false, hihat = false },
        { kick = true, snare = false, hihat = true },
        { kick = false, snare = true, hihat = true },
    },
    { -- 9: Patrón 8 golpes swing
        { kick = true, snare = false, hihat = true ,swing=true},
        { kick = true, snare = false, hihat = false },
        { kick = false, snare = false, hihat = true ,swing=true},
        { kick = true, snare = false, hihat = false },
        { kick = false, snare = true, hihat = true ,swing=true},
        { kick = true, snare = false, hihat = false },
        { kick = true, snare = false, hihat = true ,swing=true},
        { kick = false, snare = true, hihat = true },
    },
}

local queue = {} -- Cola de patrones
local step = 1
local bpm = 120
local stepDuration = 60 / bpm / 4
local elapsedTime = 0
local isPaused = false

function love.load()
    sounds.kick = love.audio.newSource("kick.wav", "static")
    sounds.snare = love.audio.newSource("snare.wav", "static")
    sounds.hihat = love.audio.newSource("hihat.wav", "static")
    sounds.crash = love.audio.newSource("crash.wav", "static")
    sounds.swing = love.audio.newSource("swing.wav", "static")
end

function love.update(dt)
    if not isPaused and #queue > 0 then
        elapsedTime = elapsedTime + dt
        if elapsedTime >= stepDuration then
            elapsedTime = elapsedTime - stepDuration
            local currentPattern = patterns[queue[1]]
            playStep(currentPattern[step])
            step = step + 1
            if step > #currentPattern then
                step = 1
                table.remove(queue, 1) -- Eliminar patrón completado
            end
        end
    end
end

function playStep(stepData)
    if stepData.kick then
        sounds.kick:stop()
        sounds.kick:play()
    end
    if stepData.snare then
        sounds.snare:stop()
        sounds.snare:play()
    end
    if stepData.hihat then
        sounds.hihat:stop()
        sounds.hihat:play()
    end
    if stepData.crash then
        sounds.crash:stop()
        sounds.crash:play()
    end
    if stepData.swing then
        sounds.swing:stop()
        sounds.swing:play()
    end
end

function love.keypressed(key)
    if tonumber(key) and patterns[tonumber(key)] then
        table.insert(queue, tonumber(key)) -- Agregar patrón a la cola
    end
    
    if key == "up" then
        bpm = bpm + 10
        stepDuration = 60 / bpm / 4
    end
    
    if key == "down" then
        bpm = bpm - 10
        if bpm < 30 then bpm = 30 end
        stepDuration = 60 / bpm / 4
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        isPaused = not isPaused -- Alternar pausa al hacer clic
    end
end

function love.draw()
    love.graphics.print("Cola actual: " .. table.concat(queue, ", "), 10, 10)
    love.graphics.print("Step: " .. step, 10, 30)
    love.graphics.print("BPM: " .. bpm, 10, 50)
    love.graphics.print("Presiona 1-4 para agregar patrones a la cola", 10, 70)
    love.graphics.print("Usa las flechas arriba/abajo para cambiar los BPM", 10, 90)
    if isPaused then
        love.graphics.print("Pausado", 10, 110)
    end
end
