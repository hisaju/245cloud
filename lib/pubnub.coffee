if location.href.match(/245cloud.com/)
  pubnub_setup = {
    channel       : '245cloud_prod',
    publish_key: 'pub-c-3a4bd949-4c5d-4803-86a4-503439a445dc',
    subscribe_key: 'sub-c-449d11bc-67c1-11e4-814d-02ee2ddab7fe'
  }
else
  pubnub_setup = {
    channel       : '245cloud_dev',
    publish_key: 'pub-c-125047a4-ec8e-47c1-a6ce-53af1013ee60',
    subscribe_key: 'sub-c-a3cb1222-77c7-11e4-af64-02ee2ddab7fe'
  }

@socket = io.connect( 'http://pubsub.pubnub.com', pubnub_setup )

@socket.on( 'connect', () ->
  console.log('Connection Established! Ready to send/receive data!')
)

@socket.on( 'message', (params) ->
  console.log 'pubnub', params
  if params.type == 'comment'
    @addComment(params.id, params.comment, params.is_countup)
  else if params.type == 'doing'
    @addDoing(params.workload)
  else if params.type == 'chatting'
    @addChatting(params.workload)
  else if params.type == 'finish'
    @stopUser(params.workload.user.objectId)
)

@socket.on( 'disconnect', () ->
  console.log('my connection dropped')
)

@socket.on( 'reconnect', () ->
  console.log('my connection has been restored!')
)

