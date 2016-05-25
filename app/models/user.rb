class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :validatable, :lockable
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]
  mount_uploader :avatar, AvatarUploader

  has_many :projects, foreign_key: "owner_id"
  has_many :comments
  has_many :surveysResponses, class_name: "SurveysResponse"
  has_many :likes
  has_many :interactions
  has_many :messages
  has_many :user_conversations
  has_many :conversations, through: :user_conversations
  
  
  validates_presence_of :city, :cp, :username, :email, :country, :territory_attachment, :first_name, :last_name, :message => "Ce champ est obligatoire"
  validates_uniqueness_of :email, :username, :message => "Déjà utilisé"
  validates :username, :first_name, :last_name, length: { maximum: 30, too_long: "Ce champ ne doit pas dépasser les %{count} caractères" }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
      user.remote_avatar_url = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.to_csv
   CSV.generate do |csv|
     csv << column_names
     all.each do |row|
       csv << row.attributes.values_at(*column_names)
     end
   end
  end

end
