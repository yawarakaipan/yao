--[=====[
[[SND Metadata]]
author: yao
version: 1.0.0

[[End Metadata]]
--]=====]

function IsNearPosition(X, Y, Z, Threshold)
  Threshold = Threshold or 1
  local Position = Player.Entity.Position
  return Threshold >= math.max(math.abs(Position.X - X), math.abs(Position.Y - Y), math.abs(Position.Z - Z))
end

function VnavMoveTo(X, Y, Z, Threshold)
  Threshold = Threshold or 1
  while not Player.IsMoving do
    yield("/vnav moveto " .. X .. " " .. Y .. " " .. Z)
    yield("/wait 0.25")
  end
  while not IsNearPosition(X, Y, Z, Threshold) do
    yield("/wait 0.25")
  end
  while IPC.vnavmesh.IsRunning() do
    yield("/vnav stop")
    yield("/wait 0.1")
  end
end

local CurrentContentId = InstancedContent.GetCurrentContentId()

if CurrentContentId ~= 45 and CurrentContentId ~= 46 then
  yield("/e [SND] このマクロは特定のコンテンツ内でのみ動作します")
  return
end

local CampX, CampY, CampZ, CampThreshold, InnerAetheryte, OuterAetheryte

if CurrentContentId == 45 then
  CampX = 830.7
  CampY = 72.9
  CampZ = -696.0
  CampThreshold = 30
  InnerAetheryte = "水晶洞窟前"
  OuterAetheryte = "古樹の湿原前"
end

if CurrentContentId == 46 then
  CampX = 880.0
  CampY = 259.7
  CampZ = 880.0
  CampThreshold = 40
  InnerAetheryte = "妖火の漁村"
  OuterAetheryte = "沈んだ聖堂前"
end

if Entity.Player.IsInCombat then
  while Entity.Player.IsInCombat do
    yield("/wait 0.5")
  end
  yield("/wait 1")
end

yield("/bocchi illegal off")

local BossmodPresetName = IPC.BossMod.GetActive()

IPC.BossMod.ClearActive()

if not IsNearPosition(CampX, CampY, CampZ, CampThreshold) then
  yield("/ac デジョン")
  yield("/wait 8")
end

local BeforeSupportJob = InstancedContent.OccultCrescent.OccultCrescentState.CurrentSupportJob

if BeforeSupportJob == 0 then
  InstancedContent.OccultCrescent.OccultCrescentState:ChangeSupportJob(1)
  yield("/wait 1")
end

InstancedContent.OccultCrescent.OccultCrescentState:ChangeSupportJob(0)
yield("/wait 1")

if Actions.GetActionInfo(41651).RecastTime <= 10 then
  yield("/ac コンテンツアクション2")
  yield("/wait 0.25")
  yield("/ac コンテンツアクション1")
  yield("/wait 1")
end

if BeforeSupportJob ~= 0 then
  InstancedContent.OccultCrescent.OccultCrescentState:ChangeSupportJob(BeforeSupportJob)
  yield("/wait 1")
end

VnavMoveTo(CampX, CampY, CampZ, 3)

yield("/wait 1")
yield("/pdr ptp " .. InnerAetheryte)
yield("/wait 5")
yield("/pdr ptreasure 内回り")

while not IsNearPosition(CampX, CampY, CampZ, CampThreshold) do
  yield("/wait 0.5")
end

yield("/e [SND] 内回りが完了しました")

VnavMoveTo(CampX, CampY, CampZ, 3)

yield("/wait 1")
yield("/pdr ptp " .. OuterAetheryte)
yield("/wait 5")
yield("/pdr ptreasure 外回り")

while not IsNearPosition(CampX, CampY, CampZ, CampThreshold) do
  yield("/wait 0.5")
end

yield("/e [SND] 外回りが完了しました")

yield("/bocchi illegal on")

if BossmodPresetName then
  IPC.BossMod.SetActive(BossmodPresetName)
end
