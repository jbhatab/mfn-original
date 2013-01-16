Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, '478770695502624', 'd1366793a80713eaa098eec8148b9a07'
end
