p "creaet user"
User.find_or_create_by_email!(:email => 'admin@pushjaw.com', :first_name => "Admin", :last_name => "pushjaw", :telephone => "0987654321", :address => "mig 1", :role_id => 2, :password => '1Pushjaw', :birth_date => "1993-04-09", :position => "Admin", :account_number => "12345", :bank_name => "BCA", :account_branch_name => "Cianjur", :account_name => "nama akun")
User.find_or_create_by_email!(:email => 'user@pushjaw.com', :first_name => "User", :last_name => "pushjaw", :telephone => "0987654321", :address => "mig 1", :role_id => 1, :password => 'password', :birth_date => "1993-04-09", :position => "programmer", :account_number => "12345", :bank_name => "BCA", :account_branch_name => "Cianjur", :account_name => "nama akun")
Role.find_or_create_by_name!(:name => 'user')
Role.find_or_create_by_name!(:name => 'admin')

p "finish"