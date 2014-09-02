# front-end logic for postings/votes
# vote info is added via AJAX after

$ ->
	# add links
	# $("<a>",
	#   text: "up"
	#   href: "http://www.google.com"
	#   click: ->
	#     alert "test"
	#     # false
	# )


	$.each $(".posting-info"), (k, v) ->
		if $(v).data('voteId')
			console.log "voted for: ", v
		else
			console.log "no votes: ", v




	# attach event handlers

# vote cast
	# AJAX
	# update count
	# update data()

# vote destroyed
	# AJAX
	# update count
	# update data()



# call up/down vote via AJAX, update view and data()
# cast_vote = (postingLink, up) ->
# 	# link clicked to vote
# 	postingInfo = postingLink.parent().parent().parent()
# 	postingData = postingInfo.data() 
# 	postingId = postingData['postingId']

# 	# up or down?
# 	if up == true
# 		url = 'votes/up_vote'
# 	else
# 		url = 'votes/down_vote'

# 	$.ajax
# 		url: url
# 		type: 'POST'
# 		data:
# 			item_id: postingId
# 			name: 'posting'
# 		success: (vote_data) ->
# 			alert vote_data.id
# 			# update .data()
# 			postingInfo.data('voteId', vote_data.id)
# 			# remove up/down vote links
# 			postingLink.closest('.no_vote').remove()
# 			# TODO: add the delete vote link and thumbs up/down

# 		error: ->
# 			alert 'js voting error'
# 	false


# # TODO: remove_vote button functions

# # TODO: update vote_score values labels after click


# # document ready
# $ ->

# 	# TODO: add voting button

# 	# voting functionality handler for postings
# 	$(".test_button_up").click ->
# 		# data stored in posting-footer hash
# 		cast_vote $(this), true

# 	$(".test_button_down").click ->
# 		cast_vote $(this), false