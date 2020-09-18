script_name("MoneySession")
script_authors("Ravskiy1")
script_version("1.05")

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
	
	autoupdate("https://raw.githubusercontent.com/ravskiy1/scripts/master/Selary.json", '['..string.upper(thisScript().name)..']: ', "https://github.com/ravskiy1/scripts/blob/master/salary.luac?raw=true")
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

function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('Загрузка обновления завершена.')
                      sampAddChatMessage((prefix..'Обновление завершено!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Обновление не требуется.')
            end
          end
        else
          print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end