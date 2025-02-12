function love.load()
    love.window.setTitle("LuaMatrix")
    love.window.setMode(800, 600, { resizable = true, fullscreen = true, vsync = true }) -- Set window size and make resizable
    love.mouse.setVisible(false) -- Hides the mouse cursor
    love.graphics.setBackgroundColor(0, 0, 0)

    letters = {} -- Store falling letters
    fonts = {} -- Store fonts of varying sizes
    fontSizes = {} -- Track valid font sizes
    
    for size = 12, 60, 4 do
        fonts[size] = love.graphics.newFont(size)
        table.insert(fontSizes, size)
    end
end

function love.update(dt)
    -- Add a new random letter at a random position
    if math.random() < 0.1 then -- 10% chance per frame
        local width, height = love.graphics.getDimensions()
        local x = math.random(0, width)
        
        -- Select a valid font size from the precomputed list
        local size = fontSizes[math.random(#fontSizes)]
        local speed = 9.325 * size

        for i = 0, math.random(2, 20) do
            table.insert(letters, {
                char = string.char(math.random(41, 126)), -- Random ASCII character
                x = x,
                y = -50 - (i * (size + 2)), -- Start above the screen
                speed = speed, -- Falling speed
                font = fonts[size], -- Preloaded font
                color = {0, math.random(200, 255) / 255, 0}, -- Random bright green
            })
        end
    end

    -- Update letter positions
    for i, letter in ipairs(letters) do
        letter.y = letter.y + letter.speed * dt
    end

    -- Remove letters that fall off the screen
    local width, height = love.graphics.getDimensions()
    for i = #letters, 1, -1 do
        if letters[i].y > height then
            table.remove(letters, i)
        end
    end
end

function love.draw()
    for _, letter in ipairs(letters) do
        love.graphics.setFont(letter.font) -- Set varying font size
        local textWidth = letter.font:getWidth("W")
        local textHeight = letter.font:getHeight()

        -- Draw a background box behind the letter
        love.graphics.setColor(0, letter.color[2] * 0.5, 0, 0.1875) -- Dark green, slightly transparent
        love.graphics.rectangle("fill", letter.x, letter.y + textHeight, textWidth, (textHeight * -6))

        -- Draw the letter in bright green
        love.graphics.setColor(letter.color)
        love.graphics.print(letter.char, letter.x, letter.y)
    end
end
