class ApplicationController < ActionController::Base
     before_action :authenticate_tenant!   # authenticate user and sets up tenant
end
