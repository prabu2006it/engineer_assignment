class User < ApplicationRecord
  has_many :phone_numbers, dependent: :destroy
  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def get_access_token
  	app_id = Doorkeeper::Application.last
    access_token = Doorkeeper::AccessToken.find_or_create_for(app_id, self.id, 'user read and write preference', 8.hours, true)
    return access_token
  end

end
