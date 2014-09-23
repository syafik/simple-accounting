p "creaet user"
User.find_or_create_by_email!(:email => 'admin@pushjaw.com', :first_name => "Admin", :last_name => "pushjaw", :telephone => "0987654321", :address => "mig 1", :role_id => 2, :password => '1Pushjaw', :birth_date => "1993-04-09")
User.find_or_create_by_email!(:email => 'herlangga@pushjaw.com', :first_name => "Heralngga", :last_name => "pushjaw", :telephone => "0987654321", :address => "mig 1", :role_id => 1, :password => '12345678', :birth_date => "1993-04-09")
Role.find_or_create_by_name!(:name => 'non admin')
Role.find_or_create_by_name!(:name => 'admin')

p "finish"