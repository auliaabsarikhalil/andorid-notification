# Android Notification
Code sample for android push nofication using node-gcm

## How to run it
1. [Install and setup coffee](https://www.npmjs.com/package/coffee-script)
2. Install all required modules : `npm install`
3. Setup app config at `.config.coffee` , see the sample code below
4. run : `coffee index.coffee`
5. Debug Mode : `DEBUG=Android index.coffee`

```coffeescript

module.exports =
	android:
		key : "YOUR_KEY"
		messageOptions:
			timeToLive: 3
			delayWhileIdle: true
			collapseKey: 'demo'
			data: 
			key1: "test"

```

## How to test it
1. Setup data variable at `test/android.coffee`, see the sample code below
2. run `npm test`

```coffeescript

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

```