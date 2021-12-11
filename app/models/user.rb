class User < ApplicationRecord
  has_secure_password

  validates :login, presence: true, length: { in: 5..20 }, uniqueness: { case_sensitive: true },
                    format: { with: /[\w]*/, message: "Only letters and numbers are allowed." }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Wrong email address.' }
end
