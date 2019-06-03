class User < ApplicationRecord
  rolify
  after_create :assign_default_role, :add_default_bio

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :complaints
  has_many :comments
  has_many :reports
  has_many :likes, dependent: :destroy
  has_one_attached :avatar

  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID   
    puts auth.info
    user = User.where(provider: auth.provider, uid: auth.uid).first
    if user
       if !user.avatar.attached?
           image = open(auth.info.image)
           user.avatar.attach(io:image, filename: auth.info.email + ".jpg")
       end
       return user
    else
       registered_user = User.where(email: auth.info.email).first
       if registered_user
          registered_user.provider = auth.provider
          registered_user.uid = auth.uid
          if !registered_user.avatar.attached?
             image = open(auth.info.image)
             registered_user.avatar.attach(io:image, filename: auth.info.email + ".jpg")
          end

          registered_user.save
          return registered_user
       else
          # Creamos el usuario
          # Avatar desde google
          # https://lh4.googleusercontent.com/-0jB5dX973yA/AAAAAAAAAAI/AAAAAAAAAAA/WAQ0E_cg-7Q/photo.jpg
          user = User.create(email: auth.email, 
                              provider: auth.provider, 
                              uid: auth.uid,
                              password: Devise.friendly_token[0,20],)
          image = open(auth.image)
          user.avatar.attach(io:image, filename: auth.email + ".jpg")
          user.save
          return user
       end
    end
  end

  def assign_default_role
    self.add_role(:registered) if self.roles.blank?
  end

  def add_default_bio
    self.bio = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  end

  def after_database_authentication
    self.touch(:last_access)
  end  

end
