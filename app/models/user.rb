class User < ActiveRecord::Base
  validates :name, presence: true,
                   uniqueness: true,
                   format: {with: /(?=[a-zA-Z]{6,})/,
                            message: 'must be ay least 8 characters and contain only upper and lowercase letters'
                   }
  validates :password, format: {
    with: /^.*(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[\d]).*$/,
    message: 'must be ay least 8 characters long and contain at least one uppercase letter, one lowercase letter and one digit'
  }
  has_secure_password
  after_destroy :ensure_an_admin_remains

  private

    def ensure_an_admin_remains
      raise "Can't delete last user" if User.count.zero?
    end
end
