utf8 = require("utf8")

alpha = {"ア", "イ", "ウ", "エ", "オ", "カ", "キ", "ク", "ケ", "コ", "サ", "シ", "ス", "セ", "ソ", "タ", "チ", "ツ", "テ", "ト", "ナ", "ニ", "ヌ", "ネ", "ノ", "ハ", "ヒ", "フ", "ヘ", "ホ", "マ", "ミ", "ム", "メ", "モ", "ヤ", "ユ", "ヨ", "ラ", "リ", "ル", "レ", "ロ", "ワ", "ヲ", "ン", "あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ", "さ", "し", "す", "せ", "そ", "た", "ち", "つ", "て", "と", "な", "に", "ぬ", "ね", "の", "は", "ひ", "ふ", "へ", "ほ", "ま", "み", "む", "め", "も", "や", "ゆ", "よ", "ら", "り", "る", "れ", "ろ", "わ", "を", "ん"}

function love.load()
    love.window.setTitle("LoveMatrix")
    love.window.setMode(800, 600, { resizable = true }) -- Set window size

    letters = {} -- Store falling letters
    font = love.graphics.newFont("fonts/NotoSansCJKjp-Regular.otf") -- Load custom font without specifying size
    love.graphics.setFont(font) -- Set custom font

    math.randomseed(os.time()) -- Ensure randomness each run
end

function getRandomLetter(set)
    local index = math.random(1, #set)
    return set[index]
end

function love.update(dt)
    -- Add a new random letter at a random position
    if math.random() < 0.1 then -- 10% chance per frame
        local width, height = love.graphics.getDimensions()
        local pos = math.random(0, width)
        local size = math.random(1, 4) * 8
        local spd = 9.325 * size

        font = love.graphics.newFont("NotoSansCJKjp-Regular.otf", size)

        for i = 0, math.random(2, 16) do
            table.insert(letters, {
                char = getRandomLetter(alpha),
                x = pos,
                y = -50 - (i * 30), -- Start above the screen
                speed = spd -- Random falling speed
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
        love.graphics.setColor(0, 1, 0)
        love.graphics.print(letter.char, letter.x, letter.y)
    end
end
