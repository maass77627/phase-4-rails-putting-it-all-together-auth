class RecipesController < ApplicationController
    before_action :authorize
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index 
        recipes = Recipe.all
        render json: recipes
       
    end

    def create
            user_id = session[:user_id]
            user = User.find(user_id)
            recipe = user.recipes.create!(recipe_params)
            render json: recipe, status: :created

    end

    private

    def recipe_params
        params.permit(:user_id, :title, :instructions, :minutes_to_complete)

    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def authorize
        return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id

    end
end
