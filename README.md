# Android Notification
This is the service for sending push notification to android devices

## Setup

Everything you need to setup before run the code:

1. [Install and setup coffee](https://www.npmjs.com/package/coffee-script)
2. Install all required modules : `npm install`
3. Setup app config at `.msConfig.coffee` , see the sample code below
4. Create `.env` file, just rename `.env.example` and define your environment

```coffeescript

module.exports =
	# Choose based on your environment
	common:
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

## Debug mode
For Debug Mode just run `DEBUG=Android coffee index.coffee`

## How to use it
1. run : `coffee index.coffee`
2. Send JSON data to `HOST:1593/send`, example:


```json

{
    "notificationOptions": {
       "title": "test",
 		"body" : "New Message",
 		"icon": "app_icon",
 		"click_action": "OPEN_ACT",
 		"type" : "newmessage",
 		"content" : "[TEST] new message"
    },
    "tokens":["TOKEN_1", "TOKEN_2"]
}

```