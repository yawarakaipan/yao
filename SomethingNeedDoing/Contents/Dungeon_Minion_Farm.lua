--[=====[
[[SND Metadata]]
author: yao
version: 1.0.0

[[End Metadata]]
--]=====]

local ContentId = 786 

function VnavMoveTo(X, Y, Z, Name)
  -- 移動開始
  while not IPC.vnavmesh.IsRunning() or not Player.IsMoving do
    yield("/vnav moveto " .. X .. " " .. Y .. " " .. Z)
    yield("/wait 1")
  end
  -- 移動終了／戦闘終了まで待機
  while IPC.vnavmesh.IsRunning() or Player.IsMoving or Entity.Player.IsInCombat do
    yield("/wait 1")
  end
  -- ターゲットが指定されている場合
  if Name then
    -- ターゲットを試みる
    while not Entity.Target or Entity.Target.Name ~= Name do
      yield("/target " .. Name)
      yield("/wait 1")
    end
    -- 
    if tostring(Entity.Target.Type) == "EventObj: 7" then
      -- 
    end
  end
end

function WaitMoving()
  while not Player.IsMoving do
    yield("/wait 1")
  end
  while Player.IsMoving do
    yield("/wait 1")
  end
end

if not Instances.DutyFinder.IsUnrestrictedParty then
  yield("/echo [SND] 制限解除を有効にしてください")
  yield("/contentsfinder")
  while not Instances.DutyFinder.IsUnrestrictedParty do
    yield("/wait 0.5")
  end
  yield("/echo [SND] 制限解除が有効になったことを確認しました")
end

while true do
  Instances.DutyFinder:QueueDuty(ContentId)

  while not Player.IsInDuty do
    yield("/wait 1")
  end

  if ContentId == 786 then
    VnavMoveTo(-18.9, 200.1, 546.7)
    VnavMoveTo(-5.9, 188.1, 409.2)
    VnavMoveTo(47.1, 176.1, 463.5)
    VnavMoveTo(-6.1, 164.0, 461.5)
    VnavMoveTo(-6.0, 163.9, 466.2)
    while not Entity.GetEntityByName("エーテルの奔流") do
      yield("/wait 1")
    end
    yield("/vnav moveto -6.1 163.9 471.0")
    WaitMoving()
    VnavMoveTo(18.4, -200.5, 353.5)
    VnavMoveTo(-5.6, -212.1, 223.2)
    VnavMoveTo(11.0, -211.5, 134.0)
    VnavMoveTo(10.9, -211.5, 128.3)
    VnavMoveTo(12.9, -211.3, 91.9)
    yield("/automove on")
    yield("/wait 3")
    WaitMoving()
    VnavMoveTo(11.6, -212.0, -108.2)
    VnavMoveTo(10.2, -212.1, -121.9)
    yield("/wait 5")
    VnavMoveTo(19.8, -228.5, -197.6)
    VnavMoveTo(-15.1, -236.0, -219.2)
    VnavMoveTo(-18.5, -241.5, -321.1)
    yield("/wait 5")
    VnavMoveTo(-17.9, -238.5, -432.0)
    VnavMoveTo(11.0, -236.0, -492.8)
    VnavMoveTo(10.9, -236.1, -501.3)
  end

  yield("/wait 3")

  if InstancedContent.CanLeaveCurrentContent() then
    InstancedContent.LeaveCurrentContent()
  end

  while Player.IsInDuty do
    yield("/wait 0.5")
  end

  yield("/wait 5")

  if ContentId == 786 and Inventory.GetItemCount(35982) > 0 then
    break
  end
end
