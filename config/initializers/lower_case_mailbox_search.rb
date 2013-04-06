module HasMailbox
  module Controllers
    module MethodHelpers

      def token
        query = "%" + params[:q] + "%"
        recipients = User.select("id, username").where("username ilike ?", query)
        respond_to do |format|
          format.json do 
            render :json => recipients.map { |u| { "id" => u.id, "name" => u.username } }
          end
        end
      end

    end
  end
end