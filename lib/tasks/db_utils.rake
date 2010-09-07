namespace :db do
  desc "Dumps database to file in the db directory."
  task(:dbdump => :environment) do
    db_config = ActiveRecord::Base.configurations[RAILS_ENV]    
    sh "mysqldump -u #{db_config['username']} -p#{db_config['password']} -Q --add-drop-table --add-locks #{db_config['database']} > #{RAILS_ROOT}/db/#{db_config['database']}.sql"     
  end
  
  desc "Loads data from a previous mysql dump -- will drop existing table!"
  task(:dbload => :environment) do
    db_config = ActiveRecord::Base.configurations[RAILS_ENV]    
    sh "mysql -u #{db_config['username']} -p#{db_config['password']} #{db_config['database']} <  #{RAILS_ROOT}/db/#{db_config['database']}.sql"
  end
end
