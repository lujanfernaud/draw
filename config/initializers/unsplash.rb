Unsplash.configure do |config|
  config.application_id     = ENV["unsplash_application_id"]
  config.application_secret = ENV["unsplash_application_secret"]
  config.application_redirect_uri = "https://your-application.com/oauth/callback"
  config.utm_source = "draw"
end
