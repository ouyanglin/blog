require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :display_name, :email, :password, :password_confirmation,
    :access_token, :access_secret

  has_many :posts, :dependent => :destroy

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :display_name, :presence   => true,
                           :length     => { :maximum => 30 },
                           :uniqueness => true
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  validates :password, :confirmation => true,
                       :length       => { :within => 6..40 },
                       :if           => :check_password

  before_create :encrypt_password
  before_update :encrypt_password, :if => :check_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      default_password
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    def check_password
      @password != nil && @password_confirmation != nil
    end

    def default_password
      @password ||= "foobar"
      @password_confirmation ||= "foobar"
    end
end
