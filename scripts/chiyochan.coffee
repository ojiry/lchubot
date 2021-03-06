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

  new CronJob '0 0 8 * * 1-5', () ->
    robot.send { room: '#general' }, """
みなさんおはようございます！
今日も一生懸命おしごとがんばりましょう！
文藝部の今日の運勢は「#{random(['大吉', '大吉', '吉', '吉', '吉', '中吉', '中吉', '小吉', '凶', '大凶', 'うんこ'])}」です。
"""
  , null, true, 'Asia/Tokyo'

  robot.respond /あ/i, (res) ->
    res.reply '何か用事でしょうか？'

  robot.respond /おはよう/i, (res) ->
    res.reply """
おはようございます。
今日も一日、がんばってくださいね。
    """

  # new CronJob '0 0 9-20 * * *', () ->
  #   robot.send { room: "#general" }, random([
  #     'み 美浜ちよです よろしくお願いします',
  #     '同級生ですから…',
  #     '小学校は給食だったからお弁当は楽しいです',
  #     '日替わり定食ください',
  #     'バスガスばすはす バスがすばくはく がすばくはくはく',
  #     'えへへ',
  #     'あ あのうっかり忘れてて…',
  #     '…けんかしたのかな…',
  #     '学校の帰りに友達とマクドナルドも行ったことあるよ',
  #     'にゃ',
  #     '……へ？',
  #     'かわいいですねぇー',
  #     'あー逃げちゃったよぅー',
  #     '880円です',
  #     'でもフィッシュバーガーのセットではなくチーズバーガーのセットに変えれば860円になって20円安くすみます',
  #     'いらっしゃいませ',
  #     'え？ジャガーはジャガーですよ',
  #     'もしくは生きて帰りたいです',
  #     'ゆかり先生 とめてください とめてください もっと ちゃんと',
  #     'ごめんなさい すみません だめ 死にます',
  #     'にげてー!!',
  #     'き にゃー!!',
  #     'く くるま？',
  #     'あの…そろそろ…',
  #     'あーいい天気ですねぇ いい風ですねぇ',
  #     'ちがいます これはパンダじゃないですよ',
  #     '大丈夫です きっとすぐに友達もできます',
  #     '私 晴れ女だからイベントはずっと晴れるんですよー',
  #     'びっくりしてください！ びっくりしてください！ わーっ わーっ',
  #     'ここは「おせんみこちゃ」と呼ばれたお祈りの部屋なんだって'
  #   ])
  # , null, true, "Asia/Tokyo"

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
