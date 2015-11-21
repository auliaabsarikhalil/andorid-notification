debug = require('debug')('Android')
gcm = require 'node-gcm'
config = require '../.config'

class Android

	constructor: (data) ->

		debug "Creating Android Object"

		return throw new Error "Initialize parameter can not be empty" if not data

		@data = data	

	validate: () ->

		debug "Validating parameter"

		data 		= @data
		errors 		= []
		required 	= ['notificationOptions', 'tokens']

		required.forEach (key) ->

			if typeof data["#{key}"] is "undefined"
				errors.push "#{key} is required"

			if data["#{key}"] and typeof data["#{key}"] is not "object"
				errors.push "#{key} type is invalid, type should be object"

		return true if errors.length == 0

		return errors  

	send: (cb) ->

		response = @validate()

		return cb response if response isnt true

		debug "Sending a message"	

		data 			= @data
		key 			= config.android.key
		notifOptions 	= data.notificationOptions
		regTokens 		= data.tokens
		
		sender 			= new gcm.Sender key
		messageOptions 	= config.android.messageOptions

		message 		= new gcm.Message messageOptions			
		message.addNotification notifOptions
		
		sender.send message, regTokens, (err, result)->
			if err
				debug "Status : error | message : #{err}"
				return cb err 

			debug "Status : Success | MulticastId : #{result.multicast_id} | Total Devices : #{result.success}"
			return cb null, result

module.exports = Android