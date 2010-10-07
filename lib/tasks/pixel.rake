PID_FILE = "tmp/pids/pixel_ping.pid"
namespace :pixel do
  desc "start the node tracker"
  task :track do
    if File.exists? PID_FILE
      pid = File.read PID_FILE
      begin
        Process.kill("USR1", pid.to_i)
        sleep 1
        Process.kill("INT", pid.to_i)
      rescue
        puts "No matching process."
      end
    end
    launch_command = "pixel-ping #{Rails.root}/config/pixel-ping.#{Rails.env}.json"
    sh "nohup #{launch_command} > log/pixel_ping.log 2>&1 & echo $! > #{PID_FILE}"
  end
  
  desc "install the with-tracking-js branch of pixel-ping"
  task :install do
    todo = []
    todo << "git submodule update --init"
    todo << "cd vendor/pixel-ping"
    todo << "npm install ."
    sh todo.join(" && ")
  end
end
