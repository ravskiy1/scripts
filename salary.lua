script_name("MoneySession")
script_authors("Ravskiy1")
script_version('1.05')


local dlstatus = require('moonloader').download_status
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
	sampAddChatMessage('{CC8C51}[���������] {d5dedd}������ �������������. �����: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[���������] {d5dedd}������ �������������. �����: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[���������] {d5dedd}������ �������������. �����: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[���������] {d5dedd}������ �������������. �����: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[���������] {d5dedd}������ �������������. �����: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[���������] {d5dedd}������ �������������. �����: {CC8C51}#ravskiy1.', 0x01A0E9) 	
	sampAddChatMessage('{CC8C51}[���������] {d5dedd}������ �������������. �����: {CC8C51}#ravskiy1.', 0x01A0E9) 
	error('��� ��� ������ ��� ������� ������') end
	
		sampAddChatMessage("{CC8C51}[���������] {d5dedd}������ �����������. �����: {CC8C51}#ravskiy1.", 0x01A0E9)
		while true do
			if sampIsLocalPlayerSpawned() then
					oldMoney = getPlayerMoney(Player)
					while true do
						if oldMoney < getPlayerMoney(Player) then
							newbalance = getPlayerMoney(Player) - oldMoney
						elseif oldMoney > getPlayerMoney(Player) then
							newbalance = -oldMoney + getPlayerMoney(Player)
						end
						renderFontDrawText(text, "��������� �� ������", 1720, 960 , 0xFFE59203)
						renderFontDrawText(session, newbalance + 0, 1720, 980 , 0xFF03E5DC)
					  wait(0)
					end
			end
			wait(0)
		end
end

function checkupdate(arg) -- �� ���� ����� ���, ������ ���
update()
end

function update()
    local fpath = os.getenv('TEMP') .. '\\Selary.json' -- ���� ����� �������� ��� ������ ��� ��������� ������
    downloadUrlToFile('https://raw.githubusercontent.com/ravskiy1/scripts/master/Selary.json', fpath, function(id, status, p1, p2) -- ������ �� ��� ������ ��� ���� ������� ������� � ��� � ���� ��� ����� ������ ����
      if status == dlstatus.STATUS_ENDDOWNLOADDATA then
      local f = io.open(fpath, 'r') -- ��������� ����
      if f then
        local info = decodeJson(f:read('*a')) -- ������
        updatelink = info.updateurl
        if info and info.latest then
          version = tonumber(info.latest) -- ��������� ������ � �����
        if version > tonumber(thisScript().version) then -- ���� ������ ������ ��� ������ ������������� ��...
            lua_thread.create(goupdate)
        else -- ���� ������, ��
            update = false
            sampAddChatMessage('[Tag]: ���������� {B70A0A}�� ����{FFFFFF} �������', -1)
        end
        end
      end
    end
  end)
  end

  function goupdate()
    sampAddChatMessage(('{FFFFFF}[Tag]:{53D229} ���������� {FFFFFF}����������. ��������...'), 0x6495ED)
    sampAddChatMessage(('{FFFFFF}[Tag]:{FFFFFF} ������� ������: '..thisScript().version..". ����� ������: "..version), 0x6495ED)
    wait(300)
    downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23) -- ������ ��� ������ � latest version
    if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
        sampAddChatMessage(('{FFFFFF}[Tag]:{FFFFFF} ���������� {53D229}���������! {FFFFFF} ����� ������ ��� ���� ��������� ��������� ������� /update'), 0x6495ED)
        thisScript():reload()
    end
  end)
  end