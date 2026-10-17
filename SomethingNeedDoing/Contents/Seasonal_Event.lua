--[=====[
[[SND Metadata]]
author: yao
version: 1.0.0
description: 守護天節 2026

[[End Metadata]]
--]=====]

function IsNearPosition(X, Y, Z, Threshold)
  local Position = Player.Entity.Position
  return Threshold >= math.max(math.abs(Position.X - X), math.abs(Position.Y - Y), math.abs(Position.Z - Z))
end

function VnavMoveTo(X, Y, Z, Name, Emote)
  local Threshold = Name == "エーテライト" and 5 or 2.5
  if not IsNearPosition(X, Y, Z, Threshold) then
    while not Player.IsMoving do
      yield("/vnav moveto " .. X .. " " .. Y .. " " .. Z .. " <wait.0.25>")
    end
    if not Entity.Player.IsMounted then
      yield("/action マウント・ルーレット <wait.1.5>")
    end
    while not IsNearPosition(X, Y, Z, Threshold) do
      yield("/wait 0.25")
    end
    if Name and Entity.Player.IsMounted then
      while Entity.Player.IsMounted do
        yield("/mount <wait.0.75>")
      end
    end
    while IPC.vnavmesh.IsRunning() do
      yield("/vnav stop <wait.0.25>")
    end
  end
  if Name and Name ~= "エーテライト" then
    local Command = Emote and (Emote .. " motion") or "interact"
    while not Entity.Target or Entity.Target.Name ~= Name do
      yield("/target " .. Name .. " <wait.0.25>")
    end
    yield("/lockon on <wait.0.25>")
    yield("/" .. Command .. " <wait.0.1>")
    yield("/" .. Command .. " <wait.0.25>")
    yield("/lockon off <wait.0.1>")
    yield("/lockon off")
  end
  while Entity.Target do
    yield("/wait 0.5")
  end
  yield("/wait 0.5")
end

function TelepoTo(aetheryteId)
  while Entity.Target or Player.IsMoving do
    yield("/wait 0.5")
  end
  Actions.Teleport(aetheryteId)
  while not Entity.Player.IsCasting do
    yield("/wait 0.25")
  end
  yield("/wait 5")
  while Entity.Player.IsCasting do
    yield("/wait 0.25")
  end
  yield("/wait 5")
end

if not IPC.TextAdvance.IsEnabled() then
  yield("/at")
end

TelepoTo(2)
VnavMoveTo(32.9, 2.6, 30.0, "エーテライト")
IPC.Lifestream.AethernetTeleport("ミィ・ケット野外音楽堂")
yield("/wait 8")
VnavMoveTo(-50.1, 6.5, -88.5, "パンプキンヘッドの女")
VnavMoveTo(-117.3, 6.7, -189.6, "パンプキンヘッドの女")
VnavMoveTo(-166.0, 7.3, -82.6, "浮かれた冒険者")
VnavMoveTo(-74.0, 7.9, -140.2)
IPC.Lifestream.AethernetTeleport("園芸師ギルド前")
yield("/wait 8")
VnavMoveTo(-232.2, 6.1, -161.5, "熱心な冒険者")
VnavMoveTo(-311.1, 7.9, -177.1)
IPC.Lifestream.AethernetTeleport("ミィ・ケット野外音楽堂")
yield("/wait 8")
VnavMoveTo(-51.9, 6.5, -88.6, "パッティン")
VnavMoveTo(-51.9, 6.5, -88.6, "パッティン")
VnavMoveTo(-45.6, 6.1, -104.1, "廃墓所の案内人")
yield("/wait 8")
VnavMoveTo(-54.9, 44.3, -86.3, "ベア")
VnavMoveTo(62.2, 39.2, -71.8)
yield("/target 怪しげな着ぐるみ")
yield("/e [SND] ターゲットに「見破りカボチャ玉」を使用してください <se.1>")
while Entity.Target and Entity.Target.Name == "怪しげな着ぐるみ" do
  yield("/wait 0.25")
end
VnavMoveTo(-9.7, 30.8, -16.6)
yield("/target 怪しげな着ぐるみ")
yield("/e [SND] ターゲットに「見破りカボチャ玉」を使用してください <se.1>")
while Entity.Target and Entity.Target.Name == "怪しげな着ぐるみ" do
  yield("/wait 0.25")
end
VnavMoveTo(16.5, 27.4, 25.0)
yield("/target 怪しげな着ぐるみ")
yield("/e [SND] ターゲットに「見破りカボチャ玉」を使用してください <se.1>")
while Entity.Target and Entity.Target.Name == "怪しげな着ぐるみ" do
  yield("/wait 0.25")
end
VnavMoveTo(21.6, 23.4, 81.7)
yield("/target 怪しげな着ぐるみ")
yield("/e [SND] ターゲットに「見破りカボチャ玉」を使用してください <se.1>")
while Entity.Target and Entity.Target.Name == "怪しげな着ぐるみ" do
  yield("/wait 0.25")
end
VnavMoveTo(-154.2, 16.6, 107.1)
yield("/target 怪しげな着ぐるみ")
yield("/e [SND] ターゲットに「見破りカボチャ玉」を使用してください <se.1>")
while Entity.Target and Entity.Target.Name == "怪しげな着ぐるみ" do
  yield("/wait 0.25")
end
VnavMoveTo(-51.6, 14.6, -17.2)
yield("/target 怪しげな着ぐるみ")
yield("/e [SND] ターゲットに「見破りカボチャ玉」を使用してください <se.1>")
while Entity.Target and Entity.Target.Name == "怪しげな着ぐるみ" do
  yield("/wait 0.25")
end
VnavMoveTo(-55.7, 44.3, -84.9, "ドッド")
yield("/wait 3")
VnavMoveTo(-51.9, 6.5, -88.6, "パッティン")
VnavMoveTo(-74.0, 7.9, -140.2)
IPC.Lifestream.AethernetTeleport("グリダニア・ランディング")
yield("/wait 8")
VnavMoveTo(23.6, -8.2, 100.0, "アントアノ")
yield("/wait 3")
VnavMoveTo(-4.3, 0.0, -4.5)
yield("/e [SND] マクロ完了 <se.1>")
VnavMoveTo(-5.2, -0.1, -4.5, "ミラージュドレッサー")
