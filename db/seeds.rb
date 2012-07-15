# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

modules_to_load = [
  Authlogic::ActsAsAuthentic::SingleAccessToken::Methods::InstanceMethods,
  Authlogic::ActsAsAuthentic::SingleAccessToken::Methods,
  Authlogic::ActsAsAuthentic::SessionMaintenance::Methods,
  Authlogic::ActsAsAuthentic::PersistenceToken::Methods::InstanceMethods,
  Authlogic::ActsAsAuthentic::PersistenceToken::Methods,
  Authlogic::ActsAsAuthentic::PerishableToken::Methods::InstanceMethods,
  Authlogic::ActsAsAuthentic::PerishableToken::Methods,
  Authlogic::ActsAsAuthentic::Password::Methods::InstanceMethods,
  Authlogic::ActsAsAuthentic::Password::Methods,
  Authlogic::ActsAsAuthentic::Password::Callbacks,
  Authlogic::ActsAsAuthentic::MagicColumns::Methods,
  Authlogic::ActsAsAuthentic::Login::Methods,
  Authlogic::ActsAsAuthentic::LoggedInStatus::Methods::InstanceMethods,
  Authlogic::ActsAsAuthentic::LoggedInStatus::Methods,
  Authlogic::ActsAsAuthentic::Email::Methods
].reject{ |m| User.included_modules.include? m }
User.send :include, *modules_to_load
