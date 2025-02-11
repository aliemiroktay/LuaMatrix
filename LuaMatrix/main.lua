function love.load()
    love.window.setTitle("Falling Letters")
    love.window.setMode(800, 600, { resizable = true }) -- Set window size and make resizable
    love.graphics.setBackgroundColor(0, 0, 0)

    letters = {} -- Store falling letters
    fonts = {} -- Store fonts of varying sizes
    local sizes = {} -- Track valid font sizes
    
    for size = 12, 60, 4 do
        fonts[size] = love.graphics.newFont(size)
        table.insert(sizes, size)
    end
    
    fontSizes = sizes -- Store valid font sizes
end

function love.update(dt)
    -- Add a new random letter at a random position
    if math.random() < 0.1 then -- 10% chance per frame
        width, height = love.graphics.getDimensions()
        x = math.random(0, width)
        
        -- Select a valid font size from the precomputed list
        size = fontSizes[math.random(#fontSizes)]
        speed = 9.325 * size

        for i = 0, math.random(2, 20) do
            table.insert(letters, {
                char = string.char(math.random(65, 90)), -- Random uppercase letter
                x = x,
                y = -50 - (i * (size + 2)), -- Start above the screen
                speed = speed, -- Random falling speed
                font = fonts[size], -- Always assign a valid font
                color = {0, math.random(200, 255) / 255, 0} -- Pre-generate color
            })
        end
    end

    -- Update letter positions
    for i, letter in ipairs(letters) do
        letter.y = letter.y + letter.speed * dt
    end

    -- Remove letters that fall off the screen
    for i = #letters, 1, -1 do
        if letters[i].y > height then
            table.remove(letters, i)
        end
    end
end

function love.draw()
    for _, letter in ipairs(letters) do
        love.graphics.setFont(letter.font) -- Use pre-generated font
        love.graphics.setColor(letter.color) -- Use pre-generated color
        love.graphics.print(letter.char, letter.x, letter.y)
    end
end
