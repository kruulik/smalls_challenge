class ResourcesController < ApplicationController 

    def get_resource
        response_object = Request.new('https://swapi.co/api')
        @resource  = response_object.get_resource(params[:resource], params[:id])
        render json: @resource
    end
    
    def list_resources
        response_object = Request.new('https://swapi.co/api')
        @resource  = response_object.list_resources(params[:resource])
        render json: @resource
    end
end
