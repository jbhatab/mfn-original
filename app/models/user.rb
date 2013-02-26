class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, 
         :validatable, :omniauthable
  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :first, :last, :password, :provider, :uid
  # attr_accessible :title, :body
  

  has_many :lineups

  #has many through
  has_many :festivals, through: :lineups

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

### This is the correct method you override with the code above
###  def self.find_for_database_authentication(warden_conditions)
###  end 

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      if auth.provider == 'facebook'
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.username = auth.info.first_name+' '+auth.info.last_name
      elsif auth.provider == 'twitter'
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.nickname
      end
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  
  #validation stuff
  #validates_confirmation_of :password
  #validates_presence_of :password, :on => :create
  #validates_presence_of :username
  #validates_uniqueness_of :username
  #validates_format_of :email, :with => /^.+@.+$/, :allow_blank => true
  #validates_uniqueness_of :festivals

  has_many :comments


end
