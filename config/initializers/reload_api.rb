if Rails.env.development?
  # 这里列出需要自动reload的类
  ActiveSupport::Dependencies.explicitly_unloadable_constants += [
    'Music::Store'
  ]

  api_files = Dir["#{Rails.root}/app/api/**/*.rb"]
  api_reloader = ActiveSupport::FileUpdateChecker.new(api_files) do
    Rails.application.reload_routes!
  end

  ActionDispatch::Callbacks.to_prepare do
    api_reloader.execute_if_updated
  end
end