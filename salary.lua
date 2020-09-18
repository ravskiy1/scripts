script_name("MoneySession")
script_authors("Ravskiy1")
script_version("0.2")

require 'lib.moonloader'
local dlstatus = require ('moonloader').download_status
local inicfg = require 'inicfg'
local sampev = require 'lib.samp.events'
local encoding = require 'encoding'
local requests = require 'requests'
encoding.default = 'CP1251'

update_state = false

local script_vers = 1
local script_vers_text = '1.00'

local update_url = 'https://raw.githubusercontent.com/ravskiy1/scripts/master/update.ini'
local update_path = getWorkingDirectory() .. '/update.ini'

local script_url = 'https://github.com/ravskiy1/scripts/blob/master/salary.luac?raw=true'
local script_path = thisScript().path


text = renderCreateFont('Tahoma', 10, 5)
session = renderCreateFont('Tahoma', 15, 5)
balance = 0
newbalance = 0


function main()
    repeat wait(0) until isSampAvailable()
	
	downloadUrlToFile(update_url, update_path, function(id, status)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					updateIni = inicfg.load(nil, update_path)
					if tonumber(updateIni.info.vers) > script_vers then
						sampAddChatMessage('{CC8C51}[Заработок] {d5dedd}Обнаружено обновление. Версия: {CC8C51}' .. updateIni.info.vers_text, 0x01A0E9) 	
						update_state = true
					end
					os.remove(update_path)
			end
	end)
	
	while true do
			wait(0)
			
			if update_state then
					downloadUrlToFile(update_url, update_path, function(id, status)
							if status == dlstatus.STATUS_ENDDOWNLOADDATA then
									sampAddChatMessage('{CC8C51}[Заработок] {d5dedd}Успешно обновлен.', 0x01A0E9) 	
									thisScript():reload()				
							end
					end)
					break
			end
	end	
			
			
			
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