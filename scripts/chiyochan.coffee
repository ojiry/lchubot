# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

CronJob = require('cron').CronJob
random = require('hubot').Response::random

module.exports = (robot) ->

  robot.hear /草野/i, (res) ->
    res.send 'こ、この生き方はだめです'

  robot.hear /ちよちゃんはなんでとぶのん/i, (res) ->
    res.send '10歳ですけどー'

  robot.hear /このガキ海にたたきこめ/i, (res) ->
    res.send 'キャー'

  robot.hear /どうしたの/i, (res) ->
    res.send 'あ あのっ 私 コンピュータって全然触ったことなくてっ'

  robot.hear /パソコンは慣れた/i, (res) ->
    res.send 'あ はい おかげさまで'

  robot.hear /泳げないの/i, (res) ->
    res.send '犬かきならなんとか'

  robot.hear /保健所/i, (res) ->
    res.send 'そ そんな… あ あう…'

  robot.hear /この犬は/i, (res) ->
    res.send 'うちで飼ってる忠吉さんです'

  new CronJob '0 0 8-20 * * *', () ->
    robot.send { room: "#general" }, random([
      'み 美浜ちよです よろしくお願いします',
      '同級生ですから…',
      '小学校は給食だったからお弁当は楽しいです',
      '日替わり定食ください',
      'バスガスばすはす バスがすばくはく がすばくはくはく',
      'えへへ',
      'あ あのうっかり忘れてて…',
      '…けんかしたのかな…',
      '学校の帰りに友達とマクドナルドも行ったことあるよ',
      'にゃ',
      '……へ？',
      'かわいいですねぇー',
      'あー逃げちゃったよぅー',
      '880円です',
      'でもフィッシュバーガーのセットではなくチーズバーガーのセットに変えれば860円になって20円安くすみます',
      'いらっしゃいませ',
      'え？ジャガーはジャガーですよ',
      'もしくは生きて帰りたいです',
      'ゆかり先生 とめてください とめてください もっと ちゃんと',
      'ごめんなさい すみません だめ 死にます',
      'にげてー!!',
      'き にゃー!!',
      'く くるま？',
      'あの…そろそろ…',
      'あーいい天気ですねぇ いい風ですねぇ',
      'ちがいます これはパンダじゃないですよ',
      '大丈夫です きっとすぐに友達もできます',
      '私 晴れ女だからイベントはずっと晴れるんですよー',
      'びっくりしてください！ びっくりしてください！ わーっ わーっ'
    ])
  , null, true, "Asia/Tokyo"

  robot.respond /users all/i, (res) ->
    robot.http('http://lcapi.herokuapp.com')
      .headers('Accept': 'application/json', 'Authorization': "Token #{process.env.ACCESS_TOKEN}")
      .path('users')
      .get() (err, resp, body) ->
        users = JSON.parse body
        usernames = []
        for user in users
          usernames.push(user['username'])
        res.send usernames.join(', ')

  robot.respond /users (.*)/i, (res) ->
    username = res.match[1].replace(/@/g, '')
    unless username == 'all'
      robot.http('http://lcapi.herokuapp.com')
        .headers('Accept': 'application/json', 'Authorization': "Token #{process.env.ACCESS_TOKEN}")
        .path("users/#{username}")
        .get() (err, resp, body) ->
          user = JSON.parse body
          res.send "#{user['username']}: #{user['email']}"

  robot.respond /events all/i, (res) ->
    robot.http('http://lcapi.herokuapp.com')
      .headers('Accept': 'application/json', 'Authorization': "Token #{process.env.ACCESS_TOKEN}")
      .path('events')
      .get() (err, resp, body) ->
        events = JSON.parse body
        if 0 < events.length
          titles = []
          for event in events
            titles.push(event['title'])
          res.send titles.join(', ')
        else
          res.send 'イベントはありませんでしたー'

  robot.respond /events create (.*) (.*) (.*)/i, (res) ->
    data =
      'event[title]': res.match[1],
      'event[scheduled_at]': res.match[2],
      'event[place]': res.match[3]
    robot.http('http://lcapi.herokuapp.com')
      .headers('Accept': 'application/json', 'Authorization': "Token #{process.env.ACCESS_TOKEN}")
      .path('events')
      .post(data) (err, resp, body) ->
        if resp.statusCode isnt 200
          res.send 'イベントの作成に失敗しちゃいました'
        else
          res.send 'イベントを作成しました！'

  # robot.hear /badger/i, (res) ->
  #   res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  #
  # robot.respond /open the (.*) doors/i, (res) ->
  #   doorType = res.match[1]
  #   if doorType is "pod bay"
  #     res.reply "I'm afraid I can't let you do that."
  #   else
  #     res.reply "Opening #{doorType} doors"
  #
  # robot.hear /I like pie/i, (res) ->
  #   res.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (res) ->
  #   res.send res.random lulz
  #
  # robot.topic (res) ->
  #   res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (res) ->
  #   res.send res.random enterReplies
  # robot.leave (res) ->
  #   res.send res.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (res) ->
  #   unless answer?
  #     res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   res.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (res) ->
  #   setTimeout () ->
  #     res.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   res.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     res.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, res) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if res?
  #     res.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (res) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     res.reply "I'm too fizzy.."
  #
  #   else
  #     res.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (res) ->
  #   robot.brain.set 'totalSodas', 0
  #   res.reply 'zzzzz'
