Spree.user_class.class_eval do
  has_many :user_authentications, dependent: :destroy

  devise :omniauthable

  def apply_omniauth(omniauth)
    if omniauth.fetch('info', {})['email'].present?
      self.email = omniauth['info']['email'] if email.blank?
    end
    user_authentications.build(provider: omniauth['provider'], uid: omniauth['uid'])
  end

  def password_required?
    (user_authentications.empty? || !password.blank?) && super
  end
end