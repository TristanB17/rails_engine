Swagger::Docs::Config.register_apis({

  "1.0" => {

    :api_file_path => "/public",
    :base_path => "http://localhost:3000",
    :clean_directory => true,
    :base_api_controller => ActionController::API,
    :attributes => {
      :info => {
        "title" => "Rails Engine",
        "description" => "A versioned API designed to conduct business intelligence using objects seeded in the database",
        "contact" => "example@example.com",
        "license" => "Apache 2.0",
        "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
      }
    }
  }
})
