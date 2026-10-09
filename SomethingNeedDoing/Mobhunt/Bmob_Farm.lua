--[=====[
[[SND Metadata]]
author: yao
version: 1.0.1

[[End Metadata]]
--]=====]

if IPC.Lifestream.GetRealTerritoryType() ~= 147 then
  yield("/e [SND] このマクロは北ザナラーンでのみ動作します")
  return
end

if not Player.Job.IsRangedDPS then
  yield("/e [SND] このマクロは現在のジョブが遠隔物理DPSの場合のみ動作します")
  return
end

local RouteName = nil
if 33.0 < Player.Entity.Position.Z then
  RouteName = "South"
  yield("/e [SND] 南ルートを巡回します")
else
  RouteName = "North"
  yield("/e [SND] 北ルートを巡回します")
end

function SearchMob(X, Y, Z)
  local MobName = "不滅のフェランド闘軍曹"
  local IsMobFound = false

  IPC.BossMod.ClearActive()

  while not Entity.Player.IsMounted do
    yield("/action マウント・ルーレット")
    yield("/wait 1.5")
  end

  while not Player.IsMoving do
    yield("/vnav moveto " .. X .. " " .. Y .. " " .. Z)
    yield("/wait 0.25")
  end

  while IPC.vnavmesh.IsRunning() or Player.IsMoving do
    local Mob = Entity.GetEntityByName(MobName)
    if Mob and Mob.CurrentHp > 0 then
      IsMobFound = true
      while IPC.vnavmesh.IsRunning() do
        yield("/vnav stop")
      end
    elseif not Entity.Player.IsMounted then
      yield("/action マウント・ルーレット")
      yield("/wait 1.5")
    end
    yield("/wait 0.25")
  end

  if IsMobFound then
    local Mob = Entity.GetEntityByName(MobName)

    while not Player.IsMoving do
      yield("/vnav moveto " .. Mob.Position.X .. " " .. Mob.Position.Y .. " " .. Mob.Position.Z)
      yield("/wait 0.25")
    end

    while IPC.vnavmesh.IsRunning() or Player.IsMoving do
      yield("/wait 0.25")
    end

    while Entity.Player.IsMounted do
      yield("/mount")
      yield("/wait 0.25")
    end

    while not Entity.Target or not Entity.Target.Name do
      yield("/target " .. Mob.Name)
      yield("/wait 0.25")
    end

    while not IPC.BossMod.GetActive() do
      IPC.BossMod.SetActive("VBM Default")
      yield("/wait 0.25")
    end

    while
      Entity.GetEntityByName(MobName) and Entity.GetEntityByName(MobName).CurrentHp > 0 do
      yield("/ac オートアタック")
      yield("/wait 0.25")
    end

    while Entity.Player.IsInCombat do
      yield("/wait 0.25")
    end

    while IPC.BossMod.GetActive() do
      IPC.BossMod.ClearActive()
      yield("/wait 0.25")
    end
  end
end

while true do
  if RouteName == "South" then
    SearchMob(-39.7, 5.7, 316.3)
    SearchMob(39.0, 13.7, 279.2)
    SearchMob(96.6, 16.3, 243.7)
    SearchMob(107.0, 20.5, 195.7)
    SearchMob(-18.3, 23.1, 176.9)
    SearchMob(106.1, 20.1, 131.4)
    SearchMob(143.9, 22.5, 88.8)
    SearchMob(122.1, 28.2, 66.1)
  end
  if RouteName == "North" then
    SearchMob(-258.7, 69.6, -102.5)
    SearchMob(-302.1, 79.1, -144.7)
    SearchMob(-161.5, 75.9, -198.5)
    SearchMob(-137.3, 69.7, -171.3)
    SearchMob(-122.8, 73.4, -230.3)
    SearchMob(-233.9, 80.4, -223.2)
    SearchMob(-205.4, 83.2, -284.2)
    SearchMob(-272.9, 83.9, -342.4)
    SearchMob(-270.4, 84.6, -271.5)
  end
end
