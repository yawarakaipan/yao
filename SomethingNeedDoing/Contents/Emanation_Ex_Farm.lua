--[=====[
[[SND Metadata]]
author: yao
version: 1.0.0

[[End Metadata]]
--]=====]

IsPartyLeader = true

if not Player.Job.IsTank then
  yield("/echo [SND] タンクに着替えてください")
  while not Player.Job.IsTank do
    yield("/wait 0.5")
  end
  yield("/echo [SND] タンクに着替えたことを確認しました")
end

if IsPartyLeader and not Instances.DutyFinder.IsUnrestrictedParty then
  yield("/echo [SND] 制限解除を有効にしてください")
  yield("/contentsfinder")
  while not Instances.DutyFinder.IsUnrestrictedParty do
    yield("/wait 0.5")
  end
  yield("/echo [SND] 制限解除が有効になったことを確認しました")
end

yield("/pdr load AutoCommenceDuty")

yield("/vbm ai on")

while true do
  if IsPartyLeader then
    Instances.DutyFinder:QueueDuty(264)
  end

  while not Player.IsInDuty do
    yield("/wait 0.5")
  end

  while not Entity.Target do
    yield("/target テンパード・クシャトリア <wait.0.5>")
  end

  yield("/vnav movetarget")

  while not Player.Entity.IsInCombat do
    yield("/wait 0.5")
  end

  while Player.Entity.IsInCombat do
    yield("/wait 0.5")
  end

  TargetX = -0.1
  TargetY = -0.1
  TargetZ = -8.1
  PositionThreshold = 1

  yield(string.format("/vnav moveto %f %f %f", TargetX, TargetY, TargetZ))

  while math.abs(Player.Entity.Position.X - TargetX) > PositionThreshold
    or math.abs(Player.Entity.Position.Y - TargetY) > PositionThreshold
    or math.abs(Player.Entity.Position.Z - TargetZ) > PositionThreshold
  do
    yield("/wait 0.25")
  end

  yield("/vnav stop")
  yield("/wait 3")

  if InstancedContent.CanLeaveCurrentContent() then
    InstancedContent.LeaveCurrentContent()
  end

  while Player.IsInDuty do
    yield("/wait 0.5")
  end

  yield("/wait 5")
end
