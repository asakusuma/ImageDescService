class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessor :login, :new_library, :use_new_library, :current_user, :from_signup
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, 
                   :remember_me, :username, :role_ids, :subject_expertise_ids,  :other_subject_expertise, :library_ids, :new_library, :use_new_library, :from_signup, :agreed_tos
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles
  
  has_many :user_libraries, :dependent => :destroy
  has_many :libraries, :through => :user_libraries
  validates_presence_of :libraries #,  :if => lambda{|user| !user.new_record?}
  
  has_many :user_subject_expertises, :dependent => :destroy
  has_many :subject_expertises, :through => :user_subject_expertises
  
  validates_length_of :email, :within => 6..250 
  validates_uniqueness_of :email
  validates_presence_of  :email

  validates_length_of :username, :within => 5..40 
  validates_uniqueness_of :username 
  validates_presence_of  :username

  validates_presence_of :password, :if => lambda {|user| user.new_record? }
  validates_length_of :password, :within => 6..40, :if => lambda {|user| !user.password.blank? }
  validates_confirmation_of :password
  
  validates_presence_of  :first_name
  validates_presence_of  :last_name
  
  before_save :populate_new_library
  before_validation_on_create :set_demo_library
  validates_acceptance_of :agreed_tos, :accept => true, :message => "To Sign up you must accept our Terms of Service", :if => lambda {|user| user.from_signup }
   
  
  def full_name
    [first_name, last_name].compact.join ' '
  end
 
  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
  
  def admin?
    has_role? :admin
  end

  def moderator?
    has_role? :moderator
  end
  
  def describer?
     has_role? :describer
  end
  
  def screener?
     has_role? :screener
  end
  
  protected

   def self.find_for_database_authentication(warden_conditions)
     conditions = warden_conditions.dup
     login = conditions.delete(:login)
     where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
   end

   # Attempt to find a user by it's email. If a record is found, send new
   # password instructions to it. If not user is found, returns a new user
   # with an email not found error.
   def self.send_reset_password_instructions(attributes={})
     recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
     recoverable.send_reset_password_instructions if recoverable.persisted?
     recoverable
   end

   def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
     (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

     attributes = attributes.slice(*required_attributes)
     attributes.delete_if { |key, value| value.blank? }

     if attributes.size == required_attributes.size
       if attributes.has_key?(:login)
          login = attributes.delete(:login)
          record = find_record(login)
       else
         record = where(attributes).first
       end
     end

     unless record
       record = new
       required_attributes.each do |key|
         value = attributes[key]
         record.send("#{key}=", value)
         if login
           record.errors.add(key, value.present? ? error : "has not been previously registered")
         else
           record.errors.add(key, value.present? ? error : :blank)
         end
       end
     end
     record
   end

   def self.find_record(login)
     where(["username = :value OR email = :value", { :value => login }]).first
   end
   

   def populate_new_library
     if use_new_library.eql? "1"
        library = Library.where(:name => new_library).first
        if (!library)
          library = Library.create :name => new_library
        end   
        self.libraries = [library]   
     end
   end
   
  def set_demo_library
     if libraries.blank?
       library = Library.where(:name => 'Demo').first
       self.libraries = [library]
     end
   end
   
end

