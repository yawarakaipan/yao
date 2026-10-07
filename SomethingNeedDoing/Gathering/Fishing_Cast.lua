--[=====[
[[SND Metadata]]
author: yao
version: 1.0.0

[[End Metadata]]
--]=====]

if Player.Job.Id ~= 18 then
  yield("/e [SND] このマクロは現在のジョブが漁師の場合のみ動作します")
  return
end

yield("/pdr load AutoEliminateFishAwareness")

yield("/e [SND] コンテンツ突入／退出の監視を開始します")

while Player.Job.Id == 18 do
  if Player.IsInDuty then
    yield("/e [SND] コンテンツへの突入を検知しました")
    while Player.IsInDuty do
      yield("/wait 1")
    end
    yield("/e [SND] コンテンツからの退出を検知しました")
    yield("/wait 5")
    yield("/ac キャスティング")
    yield("/e [SND] キャスティングを実行しました")
  end
  yield("/wait 1")
end

yield("/e [SND] ジョブの変更を検知したためマクロを終了します")
