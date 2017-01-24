# Description:
#   部活動に関連する処理を行います
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   chiyochan 部活動
#   chiyochan 募集 <name> <scheduled_at> <place>
#   chiyochan 詳細 <name>
#   chiyochan 参加 <name>
#   chiyochan 不参加 <name>
#
# Author:
#   Ryoji Yoshioka

module.exports = (robot) ->
  robot.respond /部活動/i, (res) ->
    robot.http('http://lcapi.herokuapp.com')
      .headers(
        'Accept': 'application/json',
        'Authorization': "Token #{process.env.ACCESS_TOKEN}"
      )
      .path('events')
      .get() (err, resp, body) ->
        events = JSON.parse body
        if 0 < events.length
          names = []
          for event in events
            names.push(event['name'])
            robot.brain.set event['name'], event['id']
          res.send """
こんなイベントがあるみたいです
#{names.join(', ')}
"""
        else
          res.send 'イベントはありませんでしたー'

  robot.respond /募集 (.*) (.*) (.*)/i, (res) ->
    data = JSON.stringify({
      name: res.match[1],
      scheduled_at: res.match[2],
      place: res.match[3],
      username: res.message.user.name
    })
    robot.http('http://lcapi.herokuapp.com')
      .headers(
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Token #{process.env.ACCESS_TOKEN}"
      )
      .path('events')
      .post(data) (err, resp, body) ->
        if resp.statusCode is 201
          res.send '募集を開始しました！'
        else
          res.send """
募集の方法を間違ってますよー
chiyochan 募集 飲み会 2017-01-25 秋葉原 
こんな感じでやってみてください
"""

  robot.respond /詳細 (.*)/i, (res) ->
    event_id = robot.brain.get res.match[1]
    if event_id?
      robot.http('http://lcapi.herokuapp.com')
        .headers(
          'Accept': 'application/json',
          'Authorization': "Token #{process.env.ACCESS_TOKEN}"
        )
        .path("events/#{event_id}")
        .get(data) (err, resp, body) ->
          event = JSON.parse body
          res.send "#{event['name']}"
    else
      res.send 'そんな名前の部活動はありませんー'

  robot.respond /参加 (.*)/i, (res) ->
    event_id = robot.brain.get res.match[1]
    if event_id?
      robot.http('http://lcapi.herokuapp.com')
        .headers(
          'Accept': 'application/json',
          'Authorization': "Token #{process.env.ACCESS_TOKEN}"
        )
        .path("events/#{event_id}/participate")
        .post(data) (err, resp, body) ->
          if resp.statusCode is 201
            res.send '受け付けましたー'
          else
            res.send '何かで失敗したみたいですー'
    else
      res.send 'そんな名前の部活動はありませんー'

  robot.respond /不参加 (.*)/i, (res) ->
    event_id = robot.brain.get res.match[1]
    if event_id?
      robot.http('http://lcapi.herokuapp.com')
        .headers(
          'Accept': 'application/json',
          'Authorization': "Token #{process.env.ACCESS_TOKEN}"
        )
        .path("events/#{event_id}/decline")
        .delete(data) (err, resp, body) ->
          if resp.statusCode is 204
            res.send '残念ですけど仕方ないですね'
          else
            res.send '何かで失敗したみたいですー'
    else
      res.send 'そんな名前の部活動はありませんー'