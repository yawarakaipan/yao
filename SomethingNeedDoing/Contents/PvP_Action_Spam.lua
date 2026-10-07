--[=====[
[[SND Metadata]]
author: yao
version: 1.0.0

[[End Metadata]]
--]=====]

if InstancedContent.GetCurrentContentId() == 0 then
  yield("/e [SND] このマクロはコンテンツ内でのみ動作します")
  return
end

function GetCurrentJobActionName(CurrentJobId)
  if CurrentJobId == 23 then return "パワーショット"
  elseif CurrentJobId == 31 then return "チャージブラスト"
  elseif CurrentJobId == 38 then return "コンボ：ファウンテン"
  elseif CurrentJobId == 20 then return "コンボ：夢幻闘舞"
  elseif CurrentJobId == 22 then return "コンボ：雲蒸竜変"
  elseif CurrentJobId == 30 then return "コンボ：旋風刃"
  elseif CurrentJobId == 34 then return "コンボ：花車"
  elseif CurrentJobId == 39 then return "コンボ：インファナルスライス"
  elseif CurrentJobId == 41 then return "コンボ：牙の構え"
  elseif CurrentJobId == 25 then return "ファイア"
  elseif CurrentJobId == 27 then return "ルインガ"
  elseif CurrentJobId == 35 then return "ジョルガ"
  elseif CurrentJobId == 42 then return "レッドファイア"
  elseif CurrentJobId == 19 then return "コンボ：ロイヤルアソリティ"
  elseif CurrentJobId == 21 then return "コンボ：シュトルムヴィント"
  elseif CurrentJobId == 32 then return "コンボ：ソウルイーター"
  elseif CurrentJobId == 37 then return "コンボ：バーストストライク"
  elseif CurrentJobId == 24 then return "グレアガ"
  elseif CurrentJobId == 28 then return "極炎法"
  elseif CurrentJobId == 33 then return "フォールマレフィク"
  elseif CurrentJobId == 40 then return "ドシスIII"
  else return "" end
end

function GetCurrentJobActionRange(CurrentJobId)
  if Player.GetJob(CurrentJobId).IsTank or Player.GetJob(CurrentJobId).IsMeleeDPS then
    return 5
  elseif Player.GetJob(CurrentJobId).IsHealer or Player.GetJob(CurrentJobId).IsRangedDPS or Player.GetJob(CurrentJobId).IsMagicDPS then
    return 25
  else
    return 0
  end
end

yield("/e [SND] スキル回しを開始します")

local CurrentJobId = Player.Job.Id

local CurrentJobActionName = GetCurrentJobActionName(CurrentJobId)

local CurrentJobActionRange = GetCurrentJobActionRange(CurrentJobId)

while InstancedContent.GetCurrentContentId() > 0 do
  IsGuarding = false
  if Player.Status then
    for i = 1, 30 do
      Status = Player.Status[i]
      if Status and Status.StatusId == 3054 then
        IsGuarding = true
        break
      end
    end
  end
  if not IsGuarding then
    if CurrentJobId ~= Player.Job.Id then
      CurrentJobId = Player.Job.Id
      CurrentJobActionName = GetCurrentJobActionName(CurrentJobId)
      CurrentJobActionRange = GetCurrentJobActionRange(CurrentJobId)
    end
    if Entity.Target then
      if
        Entity.Target.Name ~= Entity.Player.Name
        and tostring(Entity.Target.Type) == "Pc: 1"
        and Entity.Target.DistanceTo <= CurrentJobActionRange - 2
      then
        yield("/pvpac " .. CurrentJobActionName)
      end
    end
  end
  yield("/wait 0.2")
end

yield("/e [SND] コンテンツ退出を検知したためマクロを終了します")
