pdDialogue = {}

function pdDialogue.wrap(lines, width, font)
    -- lines: array of strings
    -- width: width to limit text (in pixels)
    -- font: optional, will get current font if not provided
    if font == nil then
        font = playdate.graphics.getFont()
    end

    local result = {}
    for _, line in ipairs(lines) do
        local currentWidth = 0
        local currentLine = ""
        if line == "" then
            -- Insert blank lines without processing
            table.insert(result, line)
        elseif font:getTextWidth(line) <= width then
            -- Insert short enough lines without processing
            table.insert(result, line)
        else
            -- Iterate through every word (split by whitespace) in the line
            for word in line:gmatch("%S+") do
                local wordWidth = font:getTextWidth(word)
                if currentWidth == 0 then
                    -- If current line is empty, set to word
                    currentWidth = wordWidth
                    currentLine = word
                else
                    -- If not, concatonate the strings and get width
                    local newLine = currentLine .. " " .. word
                    local newWidth = font:getTextWidth(newLine)
                    if newWidth >= width then
                        table.insert(result, currentLine)
                        currentWidth = wordWidth
                        currentLine = word
                    else
                        currentWidth = newWidth
                        currentLine = newLine
                    end
                end
            end
            -- If line is complete and currentLine is not empty, add to result
            if currentWidth ~= 0 then
                table.insert(result, currentLine)
            end
        end
    end
    return result
end

function pdDialogue.window(text, start_index, height, font)
    -- lines: array of strings (pre-wrapped)
    -- start_index: row index to start window
    -- rows: number of rows to render
    local result = {text[start_index]}
    if font == nil then
        font = playdate.graphics.getFont()
    end
    -- Subtract one because we start with 1 row
    local rows = pdDialogue.getRows(height, font) - 1
    for index = 1, rows do
        -- Check if index is out of range of the text
        if start_index + index > #text then
            break
        end

        table.insert(result, text[start_index + index])
    end
    -- Return a single string
    return table.concat(result, "\n")
end

function pdDialogue.paginate(lines, height, font)
    -- lines: array of strings (pre-wrapped)
    -- height: height to limit text (in pixels)
    -- font: optional, will get current font if not provided
    local result = {}
    local currentLine = {}
    if font == nil then
        font = playdate.graphics.getFont()
    end
    local rows = pdDialogue.getRows(height, font)
    for _, line in ipairs(lines) do
        if line == "" then
            -- If line is empty and currentLine has text...
            if #currentLine ~= 0 then
                -- Merge currentLine and add to result
                table.insert(result, table.concat(currentLine, "\n"))
                currentLine = {}
            end
        else
            -- If over row count...
            if #currentLine >= rows then
                -- Concat currentLine, add to result, and start new line
                table.insert(result, table.concat(currentLine, "\n"))
                currentLine = {line}
            else
                table.insert(currentLine, line)
            end
        end
    end
    -- If all lines are complete and currentLine is not empty, add to result
    if #currentLine ~= 0 then
        table.insert(result, table.concat(currentLine, "\n"))
        currentLine = {}
    end
    return result
end

function pdDialogue.process(text, width, height, font)
    -- lines: array of strings (pre-wrapped)
    -- width: width to limit text (in pixels)
    -- height: height to limit text (in pixels)
    local lines = {}
    if font == nil then
        font = playdate.graphics.getFont()
    end
    -- Split newlines in text

    for line in text:gmatch("(.-)\n") do
        table.insert(lines, line)
    end
    local wrapped = pdDialogue.wrap(lines, width, font)
    local paginated = pdDialogue.paginate(wrapped, height, font)
    return paginated
end

function pdDialogue.getRows(height, font)
    if font == nil then
        font = playdate.graphics.getFont()
    end
    local leading = font:getLeading()
    -- Use integer division
    return height // (font:getHeight() + leading)
end

function pdDialogue.getRowsf(height, font)
    if font == nil then
        font = playdate.graphics.getFont()
    end
    local leading = font:getLeading()
    return height / (font:getHeight() + leading)
end

DialogueBox = {}
class("DialogueBox").extends()

function DialogueBox:init(text, width, height, font)
    DialogueBox.super.init(self)
    self.padding = 4
    self.speed = 0.5 -- char per frame
    self.width = width
    self.height = height
    self.font = font
    self.line_complete = false
    self.done_talking = false

    self:setText(text)
end

function DialogueBox:setText(text)
    self.text = text
    self.pages = pdDialogue.process(text, self.width, self.height)
    self.currentPage = 1
    self.currentChar = 1
    self.line_complete = false
    self.done_talking = false
end

function DialogueBox:setPadding(padding)
    self.padding = padding
end

function DialogueBox:setNineSlice(nineSlice)
    self.nineSlice = nineSlice
end

function DialogueBox:setSpeed(speed)
    self.speed = speed
end

function DialogueBox:finishLine()
    self.currentChar = #self.pages[self.currentPage]
    self.line_complete = true
    self.done_talking = self.currentPage == #self.pages
end

function DialogueBox:nextPage()
    -- CHeck if last in pages, if it is then close
    self.currentPage += 1
    self.currentChar = 1

    self.line_complete = false
    self.done_talking = false
end

function DialogueBox:drawBox(text, x, y, width, height, padding, font, line_complete, nineSlice)
    local halfPadding = padding // 2
    if nineSlice ~= nil then
        nineSlice:drawInRect(x - halfPadding, y - halfPadding, width + padding, height + padding)
    else
        playdate.graphics.drawRect(x - halfPadding, y - halfPadding, width + padding, height + padding)
    end

    playdate.graphics.setFont(font)
    playdate.graphics.drawText(text, x, y)

    if line_complete then
        playdate.graphics.drawText("Ⓐ", x + width - 6, y + height - 6)
    end
end

function DialogueBox:draw(x, y)
    local currentText = self.pages[self.currentPage]
    if not self.line_complete then
        currentText = currentText:sub(1, math.floor(self.currentChar))
    end
    self:drawBox(currentText, x, y, self.width, self.height, self.padding, self.font, self.line_complete, self.nineSlice)
end

function DialogueBox:update()
    local pageLength = #self.pages[self.currentPage]
    self.currentChar += self.speed
    if self.currentChar > pageLength then
        self.currentChar = pageLength
    end

    self.line_complete = self.currentChar == pageLength
    self.done_talking = self.currentPage == #self.pages
end
