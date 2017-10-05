# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Admin.find_or_initialize_by(email: 'jsmith@example.com')
admin.first_name = "John"
admin.last_name = "Smith"
admin.password = "a"
admin.is_super_admin = true
admin.save!