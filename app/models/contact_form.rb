class ContactForm
  @to = APP_CONFIG[:contact_email]
  
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Translation
  extend ActiveModel::Naming
  
  attr_accessor :name, :email, :message
  
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :message
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_length_of :message, :maximum => 500
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def read_attribute_for_validation(key)
    send(key)
  end
  
  def to
    self.class.instance_variable_get("@to")
  end
  
  def from
    "#{name} <#{email}>"
  end
  
  def persisted?
    false
  end
  
  def save
    if valid?
      AppMailer.contact_form(self).deliver
    else
      return false
    end
  end
end
