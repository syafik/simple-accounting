p "creaet user"
User.find_or_create_by_email!(:email => 'admin@pushjaw.com', :password => '1Pushjaw')
p "finish"