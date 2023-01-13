class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients

  def self.patient_count_sort
    self.joins(:patients).group(:id).order("patients.count desc")
  end

  def patient_count
    self.patients.count
  end
end
