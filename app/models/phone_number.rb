class PhoneNumber < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :number
  validates_length_of :number, minimum: 12, maximum: 12, allow_blank: true

  def self.validate_and_generate_number(new_phone_number)
    phone_number = PhoneNumber.generate_number(new_phone_number)
    is_already_exist = PhoneNumber.where(number: phone_number).present?
    if is_already_exist
      phone_number = PhoneNumber.generate_number(new_phone_number)
    end
    return phone_number
  end

  def self.generate_number(new_phone_number)
    if new_phone_number.present?
      is_already_exist = PhoneNumber.where(number: new_phone_number).present?
      if is_already_exist
        number = rand(10 ** 10).to_s
        phone_number = "#{number.first(3)}-#{number.first(3)}-#{number.first(4)}"
      else
        phone_number = new_phone_number
      end
    else
      number = rand(10 ** 10).to_s
      phone_number = "#{number.first(3)}-#{number.first(3)}-#{number.first(4)}"
    end
    return phone_number
  end
end
