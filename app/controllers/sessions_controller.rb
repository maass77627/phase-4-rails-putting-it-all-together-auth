class SessionsController < ApplicationController
    # before_action :authorize
    
    def create 
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
        session[:user_id] = user.id
        render json: user
        else
            render json: {errors: ["Unauthorized"]}, status: 401
        end
    end

    def destroy
        if session.include? :user_id
        session.delete :user_id
        head :no_content
        else
            render json: {errors: ["Unauthorized"]}, status: 401
        end

    end

    private

    # def authorize
    #     return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id

    # end
end
