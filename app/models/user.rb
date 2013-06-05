class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :omniauthable
  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :full_name

  has_mailbox
  validates :password, :presence => true, :if => :password_required?
  
  has_many :reviews
  accepts_nested_attributes_for :reviews
  has_many :comments
  acts_as_voter

  has_many :authentications
  has_many :blogs
  
  
  #allows users to have events (festival lineup)
  has_many :events_users, :dependent => :destroy
  has_many :events, through: :events_users

  has_many :rides, :dependent => :destroy

  #login instead of email replacement that is necessary
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      return where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      return from_omniauth(warden_conditions)
    end
  end

  ### This is the correct method you override with the code above
  ###  def self.find_for_database_authentication(warden_conditions)
  ###  end 
  def self.from_omniauth(auth_hash)
    authentication = Authentication.find_by_provider_and_uid auth_hash[:provider], auth_hash[:uid]

    return authentication.user unless authentication.nil?

    user = User.create! do |user|
      user.authentications.build(:uid => auth_hash.uid, :provider => auth_hash.provider)
      if auth_hash.provider == 'facebook'
        user.email = auth_hash.info.email
        user.username = auth_hash.info.first_name+' '+auth_hash.info.last_name
      elsif auth_hash.provider == 'twitter'
        user.username = auth_hash.info.nickname
      end
    end

    return user
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
    !authentications.any?
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
  


end
