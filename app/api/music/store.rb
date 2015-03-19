module Music
  class Store < Grape::API

      helpers do
        def logger
          Store.logger
        end
      end

    resource :music_stores do

      ##
      ## API code will go here
      ##
      desc "List all music stores"
      get do
        logger.info "grape api logger............"
        MusicStore.all
      end

      desc "Create a music store"
      params do
        requires :name, type: String, desc: "Store name"
        optional :address, type: String, desc: "Store address"
        optional :lat, type: Float, desc: "Store latitude"
        optional :lon, type: Float, desc: "Store longitude"
        optional :stars, type: Integer, regexp: /^[0-5]$/, desc: "Store rating (0-5)"
      end
      post do
        MusicStore.create!({
          name:params[:name],
          address:params[:address],
          lat:params[:lat],
          lon:params[:lon],
          stars:params[:stars]
        })
      end

      desc "Update a music store"
      params do
        requires :id, type: String, desc: "Store ID"
        requires :stars, type: Integer, regexp: /^[0-5]$/, desc: "Store rating"
      end
      put ':id' do
        MusicStore.find(params[:id]).update_attribute(:stars,params[:stars])
      end

      desc "Delete a music store"
      params do
        requires :id, type: String, desc: "Store ID"
      end
      delete ':id', requirements: { id: /[0-9]*/ } do
        MusicStore.find(params[:id]).destroy
      end

      desc "Rate the store"
      params do
        requires :id, type: String, desc: "Store ID"
        requires :stars, type: Integer, regexp: /^[0-5]$/, desc: "Store rating"
      end
      put ':id/rate/:stars' do
        MusicStore.find(params[:id]).update_attribute(:stars,params[:stars])
      end
      
    end
  end
end