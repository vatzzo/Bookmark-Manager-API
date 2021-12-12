class User < ApplicationRecord
  has_secure_password

  has_many :folders

  validates :login, presence: true, length: { in: 6..20 }, uniqueness: { case_sensitive: true },
                    format: { with: /[\w]*/, message: "only letters and numbers are allowed." }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'wrong email address.' }
  validates :password, presence: true, length: { in: 8..20 }
  validate :password_requirements

  def password_requirements
    rules = {
      " must contain at least one lowercase letter" => /[a-z]+/,
      " must contain at least one uppercase letter"  => /[A-Z]+/,
      " must contain at least one special character" => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add(:password, message) unless password.match(regex)
    end
  end
end
