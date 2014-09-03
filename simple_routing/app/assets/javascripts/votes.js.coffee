# front-end logic for postings/comments/votes
# generit item labels apply to both postings and comments
# vote info is added via AJAX after

up_vote_link = $("<a>",
  href: ""
  class: "glyphicon glyphicon-thumbs-up no-vote up"
  )

down_vote_link = $("<a>",
  href: ""
  class: "glyphicon glyphicon-thumbs-down no-vote down"
  )

yes_arrow = $("<span>",
  class: "glyphicon glyphicon-arrow-up voted-for"
  )

no_arrow = $("<span>",
  class: "glyphicon glyphicon-arrow-down voted-for"
  )

del_vote_link = $("<a>",
  href: ""
  class: "glyphicon glyphicon-remove voted-for delete-vote"
  )

# call up/down vote via AJAX, update view and data()
cast_vote = (itemArea, up) ->
  # link clicked to vote
  itemInfo = itemArea.parent().parent()
  itemData = itemInfo.data() 
  itemId = itemData['itemId']
  itemName = itemData['name']

  # up or down?
  if up == true
    url = '/votes/up_vote'
  else
    url = '/votes/down_vote'

  $.ajax
    url: url
    type: 'POST'
    data:
      item_id: itemId
      name: itemName
    success: (vote_data) ->
      # console.log "vote id:", vote_data.id, ", up-voted?", up
      # update .data()
      itemInfo.data('voteId', vote_data.id)
      itemInfo.data('voteVal', vote_data.value)
      # remove up/down vote links
      itemInfo.children(".voting").empty()
      # add the delete vote link and thumbs up/down
      add_del_vote_link itemInfo.children(".voting"), up
      # attach event handler
      # console.log itemInfo.find(".delete-vote")
      itemInfo.find(".delete-vote").click (e) ->
        e.preventDefault()
        delete_vote $(this)

    error: ->
      console.log "js voting error"
  false
  
delete_vote = (itemArea) ->
  # link clicked to destroy vote
  itemInfo = itemArea.parent().parent()
  itemData = itemInfo.data() 
  voteId = itemData['voteId']

  # ajax
  $.ajax
    url: "/votes/" + voteId
    type: "DELETE"
    data: 
      id: voteId
    success: ->
      # console.log "deleted vote id:", voteId
      itemInfo.removeData('voteId')
      itemInfo.removeData('voteVal')
      itemInfo.children(".voting").empty()
      add_cast_vote_links itemInfo.children(".voting")
      # console.log itemInfo.find(".no-vote")
      itemInfo.find(".no-vote").click (e) ->
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
    yes_arrow.clone().appendTo vote_area
  else
    no_arrow.clone().appendTo vote_area
  del_vote_link.clone().appendTo vote_area

add_cast_vote_links = (vote_area) ->
  vote_area.append '&nbsp;'
  up_vote_link.clone().appendTo vote_area
  vote_area.append " | "
  down_vote_link.clone().appendTo vote_area

$ ->
  # add links to postings/comments
  $.each $(".item-info"), (key, val) ->
    item_area = $(val)
    vote_area = $(val).children(".voting")
    if item_area.data("voteId")
      # console.log "voted for: ", val
      add_del_vote_link vote_area, (item_area.data("voteVal") > 0)
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
