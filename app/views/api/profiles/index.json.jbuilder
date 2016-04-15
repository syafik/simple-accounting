json.avatar (URI.parse(root_url) + @user.avatar.url(:small)).to_s
json.name @user.full_name
json.email @user.email
json.posisi @user.position
json.notlp @user.telephone
json.bank @user.bank_name
json.norek @user.account_number
json.cabang @user.account_branch_name
json.namaakun @user.account_name
