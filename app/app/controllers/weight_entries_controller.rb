class WeightEntriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_weight_entry, only:[:show, :edit, :update, :destroy]

    def index
        @weight_entries = current_user.weight_entries.order(date: :desc)
    end

    def show
        # Le before_action :set_weight_entry trouvera l'entrée spécifique
    end
      

    def update
        if @weight_entry.update(weight_entry_params)
          redirect_to weight_entries_path, notice: 'Votre suivi de poids a été mis à jour avec succès !'
        else
          render :edit
        end
    end

    def edit
    end

    def new 
        @weight_entry = current_user.weight_entries.new
    end     
    
    def create 
        @weight_entry = current_user.weight_entries.new(weight_entry_params)

        if @weight_entry.save
            redirect_to weight_entries_path, notice: 'Votre suivi de poids a été ajouté avec succés !'
        else 
            render :new
        end
    end     

    def destroy
        @weight_entry.destroy
        redirect_to weight_entries_path, notice: 'Votre suivi de poids a été supprimé avec succès !'
    end

    private
        def weight_entry_params 
            params.require(:weight_entry).permit(:weight, :date)
        end

        def set_weight_entry
            @weight_entry = current_user.weight_entries.find(params[:id])
        end

end
