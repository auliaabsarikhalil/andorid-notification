Android 	= require './classes/Android'
config 		= require './.config'
bodyParser 	= require 'body-parser'
express 	= require 'express'
app 		= express()

app.use bodyParser.json()
app.use bodyParser.urlencoded { extended: true }

##########################################################################################
#
# {
#     "notificationOptions": {
#       "title": "test",
# 		"body" : "New Message",
# 		"icon": "app_icon",
# 		"click_action": "OPEN_ACT",
# 		"type" : "newmessage",
# 		"content" : "[TEST] new message"
#     },
#     "tokens":["TOKEN_1", "TOKEN_2"]
# }
#
##########################################################################################

app.post "/send", (req, res) ->
	data = req.body
	android = new Android data
	android.send (err, results)->
		return res.status(500).json({status:"error", message:err}) if err
		return res.json({status:"success", message:results })

server = app.listen config.port, config.host ,() ->
	host = server.address().address
	port = server.address().port
	console.log "Android Notification listening at http://#{host}:#{port}"