class Profile < ActiveRecord::Base
  belongs_to :user

  validates :gender, :inclusion => { :in => %w(male female) }
  validate :first_last_name_not_all_null, :no_male_named_sue

  def first_last_name_not_all_null
    if first_name == nil and last_name == nil
      errors.add(:base, 'first_name and ast_name cannot be both nil')
    end
  end

  def no_male_named_sue
    if gender == 'male' and first_name == 'Sue'
      errors.add(:base, 'A male cannot have first name as "Sue"')
    end
  end

  def self.get_all_profiles(min, max)
    Profile.where(birth_year: min..max).order(birth_year: :asc)
  end
end
