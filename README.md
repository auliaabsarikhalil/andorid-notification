# Android Notification
This is the service for sending push notification to android devices

## Setup

Everything you need to setup before run the code:

1. [Install and setup coffee](https://www.npmjs.com/package/coffee-script)
2. [Install and setup redis](http://redis.io/)
3. Install all required modules : `npm install`
4. Setup app config at `.msConfig.coffee` , see the sample code below
5. Create `.env` file, just rename `.env.example` and define your environment

```coffeescript

module.exports =
	# Choose based on your environment
	common:
		port: 1593
		host:"localhost"
		android:
			key : "YOUR_KEY"
			messageOptions:
				timeToLive: 3
				delayWhileIdle: true
				collapseKey: 'demo'
				data: 
					key1: "test"
		kue:
			interval: 2000
			maxActiveJobs: 30
			attempts : 3
			backoff:
				type: "exponential"

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
    "queue" : true,
    "priority" : "high",
    "tokens":["TOKEN_1", "TOKEN_2"]
}

```

## Params Glossary
| Params        | Type     | Description |
| ------------- |:-------------:| ------------|
| notificationOptions | Object | Data that will be used when the device receive this notification  |
| queue | Boolean | if true than your request will be push into queue |
| priority | String | define your queue priority `"low", "normal", "medium", "high"`, or `"critical"` . by default its `"normal"` |
| tokens | Array | list of device tokens |

## Monitor your queue
You can monitor your queue by accessing `/kue` and if you want to see it more beautiful you can access `/kue-ui`