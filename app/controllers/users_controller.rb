class UsersController < ApplicationController

 def show
  @nickname = current_user.nickname
 end

 def logout
 end

 def payment
 end
end
