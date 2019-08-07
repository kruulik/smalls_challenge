class ResourcesController < ApplicationController 

    def parse_resource(resource)
        parsedResource = {
            attributes: {},
            relationships: {}
        }
        resource.each do |key, value| 
            if (value.instance_of? Array) || (value.include?("swapi.co/api"))
                parsedResource[:relationships][key] = {
                    links: value
                }
            else
                parsedResource[:attributes][key] = value
            end
        end
        return parsedResource
    end
    
    def parse_list(list) 
        parsed = []
        list.each do |item|
            parsed << parse_resource(item)
        end 
        return {data: parsed}
    end

    def get_resource
        response_object = Request.new('https://swapi.co/api')
        @resource  = response_object.get_resource(params[:resource], params[:id])
        parsed = parse_resource(@resource)
        render json: {data: parsed}
    end
    
    def list_resources
        response_object = Request.new('https://swapi.co/api')
        @resource = response_object.list_resources(params[:resource])["results"]
        parsed = parse_list(@resource)
        render json: parsed
    end
end
