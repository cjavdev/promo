desc "Refresh YouTube connections"
task :refresh_connections => :environment do
  puts "Refreshing YouTube Connections"
  RefreshYouTubeConnectionsJob.perform_later
  puts "done."
end
