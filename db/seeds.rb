# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
['user', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end
admin_role = Role.find_by_name('admin')
User.create(email: 'hr@spericorn.com', password: 'demo123', role: admin_role) unless User.exists?(email: 'hr@spericorn.com')