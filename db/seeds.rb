# This file should create items for every card on board A with the correct labels on the correct lists and every card on board B with the correct lables on the correct lists. 


start_ngrok = './ngrok http 3000 -subdomain="trellotrials-api"'
callback_route = "https://trellotrials-api.ngrok.io/hooks"
create_webhook_POST = `https://api.trello.com/1/tokens/#{ENV["TRELLO_TOKEN"]}/webhooks?callbackURL=https://trellotrials-api.ngrok.io/hooks&idModel=#{idModel}&key=#{ENV["TRELLO_KEY"]}`
get_webhooks = "https://api.trello.com/1/tokens/5e591afe21ab42477e8bf4f2/webhooks"
delete_webhook_DELETE `https://api.trello.com/1/tokens/#{token}/webhooks/#{idWebhook}`

# REFERENCE SECTION
board1_id = '59da9a5902544e752e87327b' # JMS Priorities
board2_id = '5e471f348428442798e5689a' # Profesh

# Get actions of a board
# GET /1/boards/{boardId}/actions
api = "https://api.trello.com/1/boards/#{board_id}?fields=name,url&key=#{ENV["TRELLO_KEY"]}&token=#{ENV["TRELLO_TOKEN"]}"
api_literal_board = "https://api.trello.com/1/boards/5e471f348428442798e5689a?fields=name,url&key=#{ENV["TRELLO_KEY"]}&token=#{ENV["TRELLO_TOKEN"]}"
api_literal_card = "https://api.trello.com/1/cards/5e591afe21ab42477e8bf4f2?fields=name,url&key=#{ENV["TRELLO_KEY"]}&token=#{ENV["TRELLO_TOKEN"]}"


