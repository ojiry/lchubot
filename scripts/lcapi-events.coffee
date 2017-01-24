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
#   chiyochan 詳細 <event_id>
#   chiyochan 参加 <event_id>
#   chiyochan 不参加 <event_id>
#
# Author:
#   Ryoji Yoshioka

module.exports = (robot) ->
  headers = {
    'Accept': 'application/json',
    'Authorization': "Token #{process.env.ACCESS_TOKEN}"
    'Content-Type': 'application/json',
  }

  robot.respond /部活動/i, (res) ->
    robot.http('https://lcapi.herokuapp.com')
      .headers(headers)
      .path('events')
      .get() (err, resp, body) ->
        events = JSON.parse body
        if 0 < events.length
          event_details = []
          for event in events
            event_details.push(
              "#{event['id']}: #{event['name']} (#{event['scheduled_at']})\n"
            )
          res.send """
こんな部活動があるみたいですよ
#{event_details.join(', ')}
"""
        else
          res.send '部活動はありませんでしたー'

  robot.respond /募集 (.*) (.*) (.*)/i, (res) ->
    data = JSON.stringify({
      name: res.match[1],
      scheduled_at: res.match[2],
      place: res.match[3],
      username: res.message.user.name
    })
    robot.http('https://lcapi.herokuapp.com')
      .headers(headers)
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
    event_id = res.match[1]
    robot.http('https://lcapi.herokuapp.com')
      .headers(headers)
      .path("events/#{event_id}")
      .get() (err, resp, body) ->
        event = JSON.parse body
        res.send """
ID: #{event['id']}
部活名: #{event['name']}
日時: #{event['scheduled_at']}
場所: #{event['place']}
参加者: 
"""

  robot.respond /参加 (.*)/i, (res) ->
    event_id = res.match[1]
    data = JSON.stringify({ username: res.message.user.name })
    robot.http('https://lcapi.herokuapp.com')
      .headers(headers)
      .path("events/#{event_id}/participate")
      .post(data) (err, resp, body) ->
        if resp.statusCode is 201
          res.send '受け付けましたー'
        else
          res.send '何かで失敗したみたいですー'

  robot.respond /不参加 (.*)/i, (res) ->
    event_id = res.match[1]
    data = JSON.stringify({ username: res.message.user.name })
    robot.http('https://lcapi.herokuapp.com')
      .headers(headers)
      .path("events/#{event_id}/decline")
      .delete(data) (err, resp, body) ->
        if resp.statusCode is 204
          res.send '残念ですけど仕方ないですね'
        else
          res.send '何かで失敗したみたいですー'
