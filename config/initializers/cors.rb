Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: false, logger: (-> {Rails.logger}) do
	allow do
                 	origins '*'
              	resource '*', :headers => :any,
              	:methods => [:GET, :POST, :PUT, :DELETE]
	end
end
