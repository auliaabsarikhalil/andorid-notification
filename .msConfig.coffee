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
		kue:
			interval: 2000
			maxActiveJobs: 30
			attempts : 3
			backoff:
				type: "exponential"

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