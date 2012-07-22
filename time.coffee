###*
 Time module
 @author Jacob Carlsson (Halmhatt)
###

time = do ->
	my = {}
	# References
	floor = Math.floor
	round = Math.round
	ceil = Math.ceil
	
	# Constants
	SECOND = 1000
	MINUTE = SECOND * 60
	HOUR = MINUTE * 60
	DAY = HOUR * 24
	
	# Defaults
	defaults =	
		format: '${0} ${0.label}'
		
	# Labels
	labels = 
		milliseconds: 'millisecond/milliseconds'
		seconds: 'second/seconds'
		minutes: 'minute/minutes'
		hours: 'hour/hours'
		days: 'day/days'
	
	# Calculate difference
	diff = (date1, date2 = new Date()) -> date2.getTime() - date1.getTime()

	# Milliseconds
	milliseconds = (ms) -> ms
	
	# Seconds
	seconds = (ms) -> ms / 1000
	
	# Minutes
	minutes = (ms) -> seconds(ms) / 60
	
	# Hours
	hours = (ms) -> minutes(ms) / 60
	
	# Days
	days = (ms) -> hours(ms) / 24
	
	# Format string
	format = (str, labelName, value) ->
		str.replace('${' + labelName + '}', value)
		
	# Format label
	label = (label, num) -> 
		labelArr = labels[label].split('/')
	
		if(num is 1)
			labelArr[0]
		else
			labelArr[1]
			
	# Format numbers
	formatTime
			
	# Format labels
	
	# Format most significant
	
	# Format most significant labels
			
	# Format Object
	formatObj = (diffObj, formatStr) ->
		for key, labelStr of labels
			format(formatStr, key, label(labelStr))
	
	###
	 APIs
	###
	
	# Return diff as Object
	my.toObject = (date1, date2) ->
		# Diff in milliseconds
		diff = diff(date1, date2)
		
		# Return object
		milliseconds: floor(milliseconds(diff))
		seconds: floor(seconds(diff))
		minutes: floor(minutes(diff))
		hours: floor(hours(diff))
		days: floor(days(diff))
		
	# Return diff as relative Object
	my.toRelativeObject = (date1, date2) ->
		# Diff in milliseconds
		diff = diff(date1, date2)
		
		# Calculate differences
		days = floor(days(diff))
		diff -= days * DAY
		
		hours = floor(hours(diff))
		diff -= hours * HOUR
		
		minutes = floor(minutes(diff))
		diff -= minutes * MINUTE
		
		seconds = floor(seconds(diff))
		diff -= seconds * SECOND
		
		# Return object
		milliseconds: diff
		seconds: seconds
		minutes: minutes
		hours: hours
		days: days
		
	# Return diff as String
	my.toString = (date1, date2, format = defaults.format) -> 
		# Calculate diff as Object. Then go through all possible format specifiers
		diffObj = my.toObject(date1, date2)
		
		# Return formated object
		formatObj(diffObj, format)
		
	# Return diff as relative String
	my.toRelativeString = (date1, date2, format = defaults.format) ->
		diffObj = my.toRelativeObject(date1, date2)
		
		# Return formated object
		formatObj(diffObj, format)
		
	return my
