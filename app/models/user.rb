class User < ActiveRecord::Base
  has_secure_password
    
  validates :email, uniqueness: { case_sensitive: false }
  validates :name, :email, presence: true
  validates :password_digest, presence: true, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    stripped_email = email.strip
    
    user = User.find_by(email: stripped_email) 
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
