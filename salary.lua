script_name("MoneySession")
script_authors("Ravskiy1")
script_version("1.01")

require 'lib.moonloader'
local dlstatus = require "moonloader".download_status
local sampev = require 'lib.samp.events'
local encoding = require 'encoding'
local requests = require 'requests'
encoding.default = 'CP1251'

text = renderCreateFont('Tahoma', 10, 5)
session = renderCreateFont('Tahoma', 15, 5)
balance = 0
newbalance = 0


function main()
    repeat wait(0) until isSampAvailable()	
    local request = requests.get('http://212.109.223.189/users.txt')
    local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
    local function res()
        for n in request.text:gmatch('[^\r\n]+') do
            if nick:find(n) then return true end
        end
        return false
    end
    if not res() then 
	wait(5)
	sampAddChatMessage('{CC8C51}[Заработок] {d5dedd}Скрипт неактивирован. Автор: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[Заработок] {d5dedd}Скрипт неактивирован. Автор: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[Заработок] {d5dedd}Скрипт неактивирован. Автор: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[Заработок] {d5dedd}Скрипт неактивирован. Автор: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[Заработок] {d5dedd}Скрипт неактивирован. Автор: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[Заработок] {d5dedd}Скрипт неактивирован. Автор: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[Заработок] {d5dedd}Скрипт неактивирован. Автор: {CC8C51}#ravskiy1.', 0x01A0E9) 
	error('Кот лох полный иди покупай скрупт') end
	
		sampAddChatMessage("{CC8C51}[Заработок] {d5dedd}Скрипт активирован. Автор: {CC8C51}#ravskiy1.", 0x01A0E9)
		while true do
			if sampIsLocalPlayerSpawned() then
					oldMoney = getPlayerMoney(Player)
					while true do
						if oldMoney < getPlayerMoney(Player) then
							newbalance = getPlayerMoney(Player) - oldMoney
						elseif oldMoney > getPlayerMoney(Player) then
							newbalance = -oldMoney + getPlayerMoney(Player)
						end
						renderFontDrawText(text, "Заработок за сессию", 1720, 960 , 0xFFE59203)
						renderFontDrawText(session, newbalance + 0, 1720, 980 , 0xFF03E5DC)
					  wait(0)
					end
			end
			wait(0)
		end
end

function update()
    local updatePath = os.getenv('TEMP')..'\\Selary.json'
    -- Проверка новой версии
    downloadUrlToFile("https://raw.githubusercontent.com/ravskiy1/scripts/master/Selary.json", updatePath, function(id, status, p1, p2)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            local file = io.open(updatePath, 'r')
            if file and doesFileExist(updatePath) then
                local info = decodeJson(file:read("*a"))
                file:close(); os.remove(updatePath)
                if info.version ~= thisScript().version then
                    lua_thread.create(function()
                        wait(2000)
                        -- Загрузка скрипта, если версия изменилась
                        downloadUrlToFile("https://github.com/ravskiy1/scripts/blob/master/salary.luac?raw=true", thisScript().path, function(id, status, p1, p2)
                            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
								sampAddChatMessage('{CC8C51}[Заработок] {d5dedd}Успешно обновлен.', 0x01A0E9) 	
                                -- Обновление успешно загружено, новая версия: info.version
                                thisScript():reload()
                            end
                        end)
                    end)
                else
                    -- Обновлений нет
                end
            end
        end
    end)
end