# front-end logic for postings/votes
# vote info is added via AJAX after

up_vote_link = $("<a>",
  text: "up"
  href: ""
  class: "no-vote up"
  )

down_vote_link = $("<a>",
  text: "down"
  href: ""
  class: "no-vote down"
  )

yes_thumb = $("<span>",
  class: "glyphicon glyphicon-thumbs-up voted-for"
  )

no_thumb = $("<span>",
  class: "glyphicon glyphicon-thumbs-down voted-for"
  )

del_vote_link = $("<a>",
  text: " x"
  href: ""
  class: "voted-for delete-vote"
  )

# call up/down vote via AJAX, update view and data()
cast_vote = (postingArea, up) ->
  # link clicked to vote
  postingInfo = postingArea.parent().parent()
  postingData = postingInfo.data() 
  postingId = postingData['postingId']

  # up or down?
  if up == true
    url = 'votes/up_vote'
  else
    url = 'votes/down_vote'

  $.ajax
    url: url
    type: 'POST'
    data:
      item_id: postingId
      name: 'posting'
    success: (vote_data) ->
      # console.log "vote id:", vote_data.id, ", up-voted?", up
      # update .data()
      postingInfo.data('voteId', vote_data.id)
      postingInfo.data('voteVal', vote_data.value)
      # remove up/down vote links
      postingInfo.children(".voting").empty()
      # add the delete vote link and thumbs up/down
      add_del_vote_link postingInfo.children(".voting"), up
      # attach event handler
      # console.log postingInfo.find(".delete-vote")
      postingInfo.find(".delete-vote").click (e) ->
        e.preventDefault()
        delete_vote $(this)

    error: ->
      console.log "js voting error"
  false
  
delete_vote = (postingArea) ->
  # link clicked to destroy vote
  postingInfo = postingArea.parent().parent()
  postingData = postingInfo.data() 
  voteId = postingData['voteId']

  # ajax
  $.ajax
    url: "votes/" + voteId
    type: "DELETE"
    data: 
      id: voteId
    success: ->
      # console.log "deleted vote id:", voteId
      postingInfo.removeData('voteId')
      postingInfo.removeData('voteVal')
      postingInfo.children(".voting").empty()
      add_cast_vote_links postingInfo.children(".voting")
      # console.log postingInfo.find(".no-vote")
      postingInfo.find(".no-vote").click (e) ->
        e.preventDefault()
        if $(this).hasClass("up")
          cast_vote $(this), true
        else
          cast_vote $(this), false
    error: ->
      console.log "js vote deletion error"
  false

add_del_vote_link = (vote_area, up) ->
  if up
    yes_thumb.clone().appendTo vote_area
  else
    no_thumb.clone().appendTo vote_area
  del_vote_link.clone().appendTo vote_area

add_cast_vote_links = (vote_area) ->
  up_vote_link.clone().appendTo vote_area
  vote_area.append " | "
  down_vote_link.clone().appendTo vote_area

$ ->
  # add links to postings
  $.each $(".posting-info"), (key, val) ->
    post_area = $(val)
    vote_area = $(val).children(".voting")
    if post_area.data("voteId")
      # console.log "voted for: ", val
      add_del_vote_link vote_area, post_area.data("voteVal") > 0
    else
      # console.log "no votes: ", val
      add_cast_vote_links vote_area

  # add event handlers
  $(".no-vote").click (e) ->
    e.preventDefault()
    if $(this).hasClass("up")
      cast_vote $(this), true
    else
      cast_vote $(this), false

  $(".delete-vote").click (e) ->
    e.preventDefault()
    delete_vote $(this)

# TODO: vote count updates
