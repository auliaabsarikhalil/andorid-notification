Android 	= require './classes/Android'
config 		= require './.config'
bodyParser 	= require 'body-parser'
express 	= require 'express'
kue 		= require "kue"
kueUI		= require "kue-ui"
app 		= express()
queue		= kue.createQueue()

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
#     "tokens":["TOKEN_1", "TOKEN_2"],
#	  "queue" : true,
# 	  "priority" : "normal"
# }
#
##########################################################################################

app.use '/kue', kue.app
app.use '/kue-ui', kueUI.app

kueUI.setup({
    apiURL: '/kue',
    baseURL: '/kue-ui',
    updateInterval: config.kue.interval
})

app.post "/send", (req, res) ->
	data = req.body
	
	android = new Android data
	validated = android.validate()
	return res.status(400).json({status:"error", message:validated }) if validated isnt true

	if data.queue
		job = queue.create "android-notification", data
		job = job.priority data.priority if data.priority
		job.attempts(config.kue.attempts).backoff(config.kue.backoff).save()	
		return res.json({status:"success", message:"Successfully push into queue" })
	else
		android.send (err, results)->
			return res.status(400).json({status:"error", message:err}) if err
			return res.json({status:"success", message:results })

queue.process "android-notification", config.kue.maxActiveJobs, (job, done) ->
	android = new Android job.data
	android.send done

server = app.listen config.port, config.host ,() ->
	host = server.address().address
	port = server.address().port
	console.log "Android Notification listening at http://#{host}:#{port}"