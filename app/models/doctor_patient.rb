class DoctorPatient < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  
  def self.find_by_doc_patient(doc_id, patient_id)
    self.where(doctor_id: doc_id, patient_id: patient_id).first
  end
end