require 'rufus-scheduler'

Rufus::Scheduler.parse('00 12 L * *').next_time do
  User.update_all(:point => 0)
end
