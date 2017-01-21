# Description:
#   部員の一覧と詳細を返します
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   chiyochan 部員一覧
#   chiyochan 部員詳細 <username>
#
# Author:
#   Ryoji Yoshioka

module.exports = (robot) ->
  robot.respond /部員一覧/i, (res) ->
    robot.http('http://lcapi.herokuapp.com')
      .headers(
        'Accept': 'application/json',
        'Authorization': "Token #{process.env.ACCESS_TOKEN}"
      )
      .path('users')
      .get() (err, resp, body) ->
        users = JSON.parse body
        usernames = []
        for user in users
          usernames.push(user['username'])
        res.send """
部員さんですねー こちらになります
#{usernames.join(', ')}
        """

  robot.respond /部員詳細 (.*)/i, (res) ->
    username = res.match[1].replace(/@/g, '')
    robot.http('http://lcapi.herokuapp.com')
      .headers('Accept': 'application/json', 'Authorization': "Token #{process.env.ACCESS_TOKEN}")
      .path("users/#{username}")
      .get() (err, resp, body) ->
        user = JSON.parse body
        res.send """
#{user['username']} さんですねー
連絡先はこちらみたいです
email: #{user['email']}
        """
