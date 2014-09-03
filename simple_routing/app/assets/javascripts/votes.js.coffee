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
    voteVal = 1
    url = '/votes/up_vote'
  else
    voteVal = -1
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
      # update the score/coloration
      update_score $(itemInfo.children(".score")), voteVal
      # attach event handler
      itemInfo.find(".delete-vote").click (e) ->
        e.preventDefault()
        delete_vote $(this)

    error: ->
      console.log "AJAX vote casting error"
  false
  
delete_vote = (itemArea) ->
  # link clicked to destroy vote
  itemInfo = itemArea.parent().parent()
  itemData = itemInfo.data() 
  voteId = itemData['voteId']
  voteVal = parseInt(itemData['voteVal']) * -1

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
      update_score $(itemInfo.children(".score")), voteVal
      itemInfo.find(".no-vote").click (e) ->
        e.preventDefault()
        if $(this).hasClass("up")
          cast_vote $(this), true
        else
          cast_vote $(this), false
      console.log $(itemInfo.children(".score")).html()

    error: ->
      console.log "AJAX vote deletion error"
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

# lowers or raises score value/color codes label
update_score = (score_elem, vote_value) ->
  score_elem.html(parseInt(score_elem.html()) + vote_value)
  color_code_score score_elem

# changes the label coloration
HIGH = 2
MEDIUM = 1
LOW = -1
color_code_score = (score_elem) ->
  # TODO: regex
  score_elem.removeClass("label")
  score_elem.removeClass("label-success")
  score_elem.removeClass("label-primary")
  score_elem.removeClass("label-default")
  score_elem.removeClass("label-warning")
  score_elem.removeClass("label-danger")

  score_elem.addClass("label")
  score = parseInt(score_elem.html())
  if score >= HIGH
    score_elem.addClass("label-success")
  else if score < HIGH and score >= MEDIUM
    score_elem.addClass("label-primary")
  else if score < MEDIUM and score >= 0
    score_elem.addClass("label-default")
  else if score < 0 and score >= LOW
    score_elem.addClass("label-warning")
  else
    score_elem.addClass("label-danger")


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

  # color code scores
  $.each $(".score"), (key, score_elem) ->
    color_code_score $(score_elem)

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
