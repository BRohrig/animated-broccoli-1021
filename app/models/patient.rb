class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients
  has_many :hospitals, through: :doctors

  def self.adult_patients_alpha
    self.where("age > 18")
        .order(:name)
  end
end