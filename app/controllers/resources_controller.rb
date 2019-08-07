class ResourcesController < ApplicationController 

    def parse_resource(resource)
        parsedResource = {
            data: {
                attributes: {},
                relationships: {}
            },
        }
        resource.each do |key, value| 
            if (value.instance_of? Array) || (value.include?("swapi.co/api"))
                parsedResource[:data][:relationships][key] = {
                    links: value
                }
            else
                parsedResource[:data][:attributes][key] = value
            end
        end
        parsedResource
    end

    def get_resource
        response_object = Request.new('https://swapi.co/api')
        @resource  = response_object.get_resource(params[:resource], params[:id])
        parsed = parse_resource(@resource)
        render json: parsed
    end
    
    def list_resources
        response_object = Request.new('https://swapi.co/api')
        @resource  = response_object.list_resources(params[:resource])
        render json: @resource
    end
end
