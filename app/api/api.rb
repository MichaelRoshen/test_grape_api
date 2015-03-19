class API < Grape::API
  prefix 'api'
  version 'v1', using: :path

  format :json
  default_format :json

  rescue_from ActiveRecord::RecordNotFound do |e|
    Rack::Response.new({
      error_code: 404,
      error_message: e.message
      }.to_json, 404).finish
  end

  rescue_from :all do |e|
    Rack::Response.new({
      error_code: 500,
      error_message: e.message
      }.to_json, 500).finish
  end

  before do 
    puts "before request -----"
  end
  after do 
    puts "after  request -----"
  end

  mount Music::Store

  # 文档相关
  add_swagger_documentation mount_path: "/docs",
                            api_version:'v1',
                            hide_documentation_path: true unless Rails.env.production?
end
