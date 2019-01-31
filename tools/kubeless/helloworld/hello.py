def hello(event, context):
  print("event: {}".format(event))
  return event['data']