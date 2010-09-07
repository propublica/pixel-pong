PID_FILE = "tmp/pids/pixel_ping.pid"
namespace :pixel do
  desc "start the node tracker"
  task :track => :environment do
    if File.exists? PID_FILE
      pid = File.read PID_FILE
      Process.kill("USR1", pid.to_i)
    end
    launch_command = "pixel-ping #{Rails.root}/config/pixel-ping.#{Rails.env}.json"
    sh "nohup #{launch_command} > log/pixel_ping.log 2>&1 & echo $! > #{PID_FILE}"
  end
end
