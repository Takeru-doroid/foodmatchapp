User.find_or_create_by!(name: "管理者", email: "admin1@mail.com") do |user|
  user.password = "2023Adm1n1110"
  user.role = 1
end
