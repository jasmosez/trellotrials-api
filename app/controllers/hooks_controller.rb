
class HooksController < ApplicationController

  # supress logging of unpermitted parameters found
  ActionController::Parameters.action_on_unpermitted_parameters = :false

  def index
    render status: 200
  end

  def create
    type = hooks_params[:action][:type]
    board_name = hooks_params[:action][:data][:board][:name]
    
    if board_name == "Mother Earth" || "Satellite"

      # Create swtich statement
      # create card -- new Card
      # delete card -- delete Card
      # addLabelToCard -- add a Boss id to the card (and maybe make a new Boss)
      # removeLabelFromCard -- remove a Boss id

      if type == 'addLabelToCard' 
        # && if it is a label that means 'sync' which for now is any label
        Task.register_task(hooks_params)
    
      elsif type == 'removeLabelFromCard'
        # && if it is a label that means 'sync' which for now is any label
        Task.unregister_task(hooks_params)
      else
        puts "Nothing to do with type == " + type
      end
    end

    render status: 200

  end

  private

  def hooks_params
    params.require(:hook).permit(action: [:type, data: [label: [:name, :id], board: [:name, :id], card: [:name, :id]]])
  end

end
