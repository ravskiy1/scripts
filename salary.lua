local imgui = require 'imgui'
local key = require 'vkeys'
-- ��� ��� ����
script_version("1.5")
local color = 0x348cb2
-- ��� ����
local dlstatus = require('moonloader').download_status

local main_window_state = imgui.ImBool(false)
function imgui.OnDrawFrame()
  if main_window_state.v then
    imgui.SetNextWindowSize(imgui.ImVec2(150, 200), imgui.Cond.FirstUseEver)
    imgui.Begin('Testing update', main_window_state)
    if imgui.Button('UPDATE ME!') then
      printStringNow('Updating!', 1000)
      update()
    end
    imgui.Text("Now version "..thisScript().version)
    imgui.End()
  end
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
          lua_thread.create(goupdate) -- ������
        else -- ���� ������, ��
          update = false -- �� ��� ���������� 
          sampAddChatMessage(('[Testing]: � ��� � ��� ��������� ������! ���������� ��������'), color)
        end
      end
    end
  end
end)
end
--���������� ���������� ������
function goupdate()
sampAddChatMessage(('[Testing]: ���������� ����������. AutoReload ����� �������������. ����������...'), color)
sampAddChatMessage(('[Testing]: ������� ������: '..thisScript().version..". ����� ������: "..version), color)
wait(300)
downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23) -- ������ ��� ������ � latest version
  if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
  sampAddChatMessage(('[Testing]: ���������� ���������!'), color)
  thisScript():reload()
end
end)
end

-- �Ѩ!

function main()
  while true do
    wait(0)
    if wasKeyPressed(key.VK_X) then -- ��������� �� ������� ������� X
        main_window_state.v = not main_window_state.v -- ����������� ������ ���������� ����, �� �������� ��� .v
    end
    imgui.Process = main_window_state.v -- ������ �������� imgui.Process ������ ����� ���������� � ����������� �� ���������� ��������� ����
  end
end