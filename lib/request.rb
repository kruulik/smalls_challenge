class Request 

    def initialize(url)
        @base_url = url
    end

    def get_resource(resource, id)
        response = HTTParty.get(@base_url + '/' + resource + '/' + id)
    end
    
    def list_resources(resource)
        response = HTTParty.get(@base_url + '/' + resource)
    end

end