class User < ApplicationRecord
    validates :email, presence:true, uniqueness:true
    validates :password_digest, presence:true
    validate :session_token, presence:true, uniqueness:true
    validates :password, length: { minimum: 6 }, allow_nil:true

    before_validation :ensure_session_token
end