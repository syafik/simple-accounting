p "creaet user"
User.find_or_create_by_email!(:email => 'admin@pushjaw.com', :first_name => "Admin", :last_name => "pushjaw", :telephone => "0987654321", :address => "mig 1", :role_id => 2, :password => '1Pushjaw')
p "finish"