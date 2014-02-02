Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
   # provider :facebook, [APP ID], [SECRET KEY], {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
   provider :facebook, "199279863613884", "5b0ecbdb8398cb870fc42d777300e384"
  # If you want to also configure for additional login services, they would be configured here.
end
