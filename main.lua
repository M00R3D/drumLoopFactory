-- Variables globales
local sounds = {}
local pattern = { -- Un patrón de batería de 16 pasos para punk rock
{ kick = true, snare = false, hihat = true },  -- kick hihat
{ kick = false, snare = true, hihat = true },  -- snare hihat
{ kick = true, snare = false, hihat = true },  -- kick hihat
{ kick = true, snare = false, hihat = true },  -- kick hihat
{ kick = false, snare = true, hihat = true },  -- snare hihat
{ kick = true, snare = false, hihat = true },  -- kick hihat
{ kick = false, snare = true, hihat = true },  -- snare hihat
{ kick = true, snare = false, hihat = true },  -- kick hihat
{ kick = true, snare = false, hihat = true },  -- kick hihat
{ kick = false, snare = true, hihat = true },  -- snare hihat
{ kick = false, snare = false, hihat = true },  -- hihat
{ kick = false, snare = false, hihat = true },  -- hihat
{ kick = false, snare = false, hihat = true },  -- hihat
{ kick = false, snare = false, hihat = true },  -- hihat
{ kick = false, snare = false, hihat = true },  -- hihat
{ kick = false, snare = false, hihat = true },  -- hihat

}
local step = 1;local bpm = 120;local stepDuration = 60 / bpm / 4
local elapsedTime = 0;

function love.load()
    sounds.kick = love.audio.newSource("kick.wav", "static")
    sounds.snare = love.audio.newSource("snare.wav", "static")
    sounds.hihat = love.audio.newSource("hihat.wav", "static")
end

function love.update(dt)
    -- Actualizar el temporizador
    elapsedTime = elapsedTime + dt
    if elapsedTime >= stepDuration then
        elapsedTime = elapsedTime - stepDuration
        playStep(step)
        step = step + 1
        if step > #pattern then
            step = 1 -- Reiniciar al comienzo del patrón
        end
    end
end

function playStep(step)
    -- Reproducir sonidos según el patrón actual con reinicio para evitar desfases
    local currentStep = pattern[step]
    if currentStep.kick then
        sounds.kick:stop() -- Detener sonido anterior
        sounds.kick:play() -- Reproducir desde el inicio
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

function love.draw()
    -- Dibujar información para depurar (opcional)
    love.graphics.print("Step: " .. step, 10, 10)
end
