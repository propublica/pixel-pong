# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pixeltracker_session',
  :secret      => 'b3c035c75f01407d60f6546be4a81bfff96e915ea60dfe8982ea5fc06fdd6669dcd4be07f9a788a60f3943630eb3c874d0d6df68153cb95e027f9933936c2ff6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
