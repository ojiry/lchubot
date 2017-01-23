# Description:
#   説明書を表示します
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   chiyochan 説明書
#
# Author:
#   Ryoji Yoshioka

module.exports = (robot) ->
  robot.respond /説明書/i, (res) ->
    res.send """
説明書はこちらになります

部員一覧表示:
  chiyochan 部員一覧
部員詳細表示:
  chiyochan 部員詳細 <部員名>

ちよちゃんの反応するフレーズ一覧:
  ちよちゃんはなんでとぶのん
  このガキ海にたたきこめ
  どうしたの
  パソコンは慣れた
  泳げないの
  保健所
  この犬は
    """
