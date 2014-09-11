p "creaet user"
User.find_or_create_by_email!(:email => 'admin@pushjaw.com', :password => '1Pushjaw')
User.find_or_create_by_email!(:email => 'herlangga@pushjaw.com', :password => '1Pushjaw')
p "finish"