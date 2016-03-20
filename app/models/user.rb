class User < ActiveRecord::Base
	has_many :tasks, dependent: :destroy
	has_many :group_members, dependent: :destroy
	has_many :groups, through: :group_members
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.register_from_emails(emails,current_group)
    if emails.any?
      valid_emails = check_emails(emails)
      if valid_emails.any?
      	transaction do
	        valid_emails.each do |email|
	          current_group.members << User.find_by(email: email)
	        end
	        valid_emails
	      end
	    else
	      nil
      end
    else
      nil
    end
  end

  private
	  def self.check_emails(emails)
	  	emails.reduce([]) do |valid_emails, email|
	  		valid_emails << email if exists?(email: email)
	  		valid_emails
	  	end
	  end
end
