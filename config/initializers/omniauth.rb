Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
    scope: 'email', display: 'popup', local: 'ja_JP', info_fields: "id, name, gender"
end