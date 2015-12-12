module.exports =
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

	development:
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

	production:
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