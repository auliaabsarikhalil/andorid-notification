should = require 'should'
expect = require 'expect.js'
Android = require '../classes/Android'

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

clone = (obj) ->

	return obj if obj == null or typeof obj != 'object'
	
	temp = obj.constructor()

	for key of obj
		temp[key] = clone(obj[key])
	
	temp

describe "Android", () ->

	@timeout 1500000

	it "should receive error when `notificationOptions` is not in the parameter", (done) ->
		
		passData = clone data

		delete passData.notificationOptions

		android = new Android passData

		android.send (err, results) ->
			expect('notificationOptions is required' in err).to.eql(true)
			done()

	it "should receive error when `tokens` is not in the parameter", (done) ->
		
		passData = clone data

		delete passData.tokens

		android = new Android passData

		android.send (err, results) ->
			expect('tokens is required' in err).to.eql(true)
			done()

	it "should receive error when `notificationOptions` is not a object", () ->
		
		passData = clone data

		passData.notificationOptions = ""

		android = new Android passData

		android.send (err, results) ->
			expect('notificationOptions type is invalid, type should be object' in err).to.eql(true)

	it "should receive error when `tokens` is not a object", () ->
		
		passData = clone data

		passData.tokens = ""

		android = new Android passData

		android.send (err, results) ->
			expect('tokens type is invalid, type should be object' in err).to.eql(true)
			done()

	it "should receive success not equal zero when send push notif is success", () ->
		
		passData = clone data

		android = new Android passData

		android.send (err, results) ->

			expect(err).to.eql(null)
			expect(results.multicast_id).not.to.eql(undefined)
			expect(results.success).not.to.eql(0)
			

	it "should receive failure not equal zero when all notif not send to all devices", () ->
		
		passData = clone data

		passData.tokens.push 'XXXX'

		android = new Android passData

		android.send (err, results) ->
			expect(err).to.eql(null)
			expect(results.multicast_id).not.to.eql(undefined)
			expect(results.failure).not.to.eql(0)