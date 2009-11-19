# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_timetracker_session',
  :secret      => '8778fb103840cddfa93b02f563fd9376a78588c98190d8ce7effc6814c39fee5aed18967e9b92675c1d82b1e925990ca2549020064ffa4db510764dfdb474ecc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
