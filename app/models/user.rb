class User < ActiveRecord::Base
  has_many :projects
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  protected

  def email_required? ; false ; end
end
