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

部活動表示:
　chiyochan 部活動
部活動作成:
　chiyochan 募集 <部活動名> <2017-02-14T10:00> <場所名>
部活動詳細表示:
　chiyochan 詳細 <部活動ID>
部活動参加:
　chiyochan 参加 <部活動ID>
部活動不参加:
　chiyochan 不参加 <部活動ID>

ちよちゃんの反応するフレーズ一覧:
　ちよちゃんはなんでとぶのん
　このガキ海にたたきこめ
　どうしたの
　パソコンは慣れた
　泳げないの
　保健所
　この犬は
"""
