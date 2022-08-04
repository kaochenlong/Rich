class User < ApplicationRecord
  # relationships
  has_many :articles

  # validatations
  validates :email,
            presence: true,
            uniqueness: true

  validates :password,
             presence: true,
             length: { minimum: 6},
             confirmation: true

  # callback
  before_create :encrypt_password

  def self.login(user_params)
    email = user_params[:email]
    password = user_params[:password]

    hashed_password = Digest::SHA1.hexdigest("xx-------#{password}-yy")

    find_by(email: email, password: hashed_password)
  end

  private

  def encrypt_password
    # 加鹽 salting
    pw = "xx-------#{self.password}-yy"
    self.password = Digest::SHA1.hexdigest(pw)
  end
end