Android = require './classes/Android'

data =
	notificationOptions :
		title: "test"
		body : "New Message"
		icon: 'app_icon'
		click_action: 'CLICK_TO_ACT'
		type : 'newmassage'
		content : "[TEST] new message"
	tokens : [
		'ENTER_TOKENS_HERE'
	]

android = new Android data

android.send (err, results)->
	if err
		console.dir err
		return
	console.dir results