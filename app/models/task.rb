class Task < ApplicationRecord
  

  def self.unregister_task(hook_hash)
    puts "UNREGISTER TASK"
  end

  def self.register_task(hook_hash)
    Task.puts_hook_hash(hook_hash)

    card_id = hook_hash[:action][:data][:card][:id]
    board_name = hook_hash[:action][:data][:board][:name]

    if board_name == 'Mother Earth'
      task = Task.find_by(card_a_id: card_id)

      if !!task
        puts "THIS CARD (via Mother Earth) IS ALREADY IN THE DB"
      else
        card_title = hook_hash[:action][:data][:card][:name]
        new_card_id = Task.create_card_on_satellite(card_title)
        Task.create(title: card_title, card_a_id: card_id, card_b_id: new_card_id)
        puts "THIS IS A NEW CARD (via Mother Earth)"
        Task.add_label_to_card(new_card_id)
      end

    elsif board_name == 'Satellite'
      task = Task.find_by(card_b_id: card_id)

      if !!task
        puts "THIS CARD (via Satellite) IS ALREADY IN THE DB"
      else
        card_title = hook_hash[:action][:data][:card][:name]
        new_card_id = Task.create_card_on_mother_earth(card_title)
        Task.create(title: card_title, card_b_id: card_id, card_a_id: new_card_id)
        puts "THIS IS A NEW CARD (via Satellite)"
        Task.add_label_to_card(new_card_id)
      end

    end
  end
  
  def self.add_label_to_card(new_card_id)
    # create a POST request
    url = "https://api.trello.com/1/cards/#{new_card_id}"
    query_hash = {
      key: ENV["TRELLO_KEY"],
      token: ENV["TRELLO_TOKEN"],
      idLabels: "5ea700467669b22549ebda4b"
    }
    resp = Faraday.put(url, query_hash)

    return JSON.parse(resp.body)["id"]
  end

  def self.create_card_on_mother_earth(card_title)
    # create a POST request
    url = "https://api.trello.com/1/cards"
    query_hash = {
      key: ENV["TRELLO_KEY"],
      token: ENV["TRELLO_TOKEN"],
      name: card_title,
      pos: "bottom",
      idList: "5ea71d426c0532860ee9b0e4",
      # idLabels: "5ea700467669b22549ebda4b",
    }
    resp = Faraday.post(url, query_hash)

    return JSON.parse(resp.body)["id"]
  end
  
  def self.create_card_on_satellite(card_title)
    # create a POST request
    url = "https://api.trello.com/1/cards"
    query_hash = {
      key: ENV["TRELLO_KEY"],
      token: ENV["TRELLO_TOKEN"],
      name: card_title,
      pos: "bottom",
      idList: "5ea71d3cdebd2c09431c4f5c",
      # idLabels: "5ea700027669b22549e967e7",
    }
    resp = Faraday.post(url, query_hash)
    return JSON.parse(resp.body)["id"]


  end

  def self.puts_hook_hash(hook_hash)
    puts "-------------------------------------"
    puts "Action Type | " + hook_hash[:action][:type]
    puts "Board Name | " + hook_hash[:action][:data][:board][:name]
    puts "Board ID | " + hook_hash[:action][:data][:board][:id]
    puts "Card Name | " + hook_hash[:action][:data][:card][:name]
    puts "Card ID | " + hook_hash[:action][:data][:card][:id]
    if !!hook_hash[:action][:data][:label]
      puts "Label Name | " + hook_hash[:action][:data][:label][:name]
      puts "Label ID | " + hook_hash[:action][:data][:label][:id]
    else
      puts "Label N/A"
    end
    puts "-------------------------------------"
  end
end
