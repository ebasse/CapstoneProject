class UsersController < ApplicationController
    
    def my_members
        @board = Board.find(params[:board])
    end
    
    def search
        if params[:search_param].blank?
            flash.now[:danger] = "Oops! Enter users name or email"
        else
            @users = User.search(params[:search_param])
            @users = current_user.except_current_user(@users)
            flash.now[:danger] = "No users match this search criteria" if @users.blank?
        end
        respond_to do |format|
            format.js { render partial: 'users/result' }
        end
    end
    
    def add_member
        @member = User.find(params[:member])
        @user = User.find(params[:user])
        @board=Board.find(@user.current_board)
        @board.users << @member

        if current_user.save
            flash[:notice] = "Member was successfully added"
        else
            flash[:danger] = "There was something wrong with the member request"
        end
        redirect_to my_members_path(board: @board.id)
    end
    
    def show
    end
end