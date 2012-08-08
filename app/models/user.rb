class User < ActiveRecord::Base
#TODO add reset on next login
#TODO add email field
  validates :name, presence: true,
                   uniqueness: true,
                   format: {with: /(?=[a-zA-Z]{6,})/,
                            message: 'must be at least 6 characters and contain only upper and lowercase letters'
                   }
#  validates :password, format: {
#    with: /^.*(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[\d]).*$/,
#    message: 'must be ay least 8 characters long and contain at least one uppercase letter, one lowercase letter and one digit'
#  }

  validates :password, format: {
    with: /^.*(?=.{8,}).*$/,
    message: 'must be at least 8 characters long'
  }

  validates :password, format: {
    with: /^.*(?=.*[A-Z]).*$/,
    message: 'must contain at least one uppercase letter'
  }

  validates :password, format: {
    with: /^.*(?=.*[a-z]).*$/,
    message: 'must contain at least one lowercase letter'
  }

  validates :password, format: {
    with: /^.*(?=.*[\d]).*$/,
    message: 'must contain at least one digit (0-9)'
  }

  has_secure_password
  after_destroy :ensure_an_admin_remains

  private

    def ensure_an_admin_remains
      raise "Can't delete last user" if User.count.zero?
    end
end
