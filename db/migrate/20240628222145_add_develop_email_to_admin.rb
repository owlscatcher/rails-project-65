class AddDevelopEmailToAdmin < ActiveRecord::Migration[7.1]
  def change
    user = User.find_or_initialize_by(email: 'collabsis.g@gmail.com')
    user.update(name: 'Service Admin', admin: true)
  end
end
