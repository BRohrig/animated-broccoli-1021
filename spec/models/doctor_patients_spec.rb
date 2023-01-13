require 'rails_helper'

RSpec.describe DoctorPatient, type: :model do
  describe "relationships" do
    it {should belong_to :doctor}
    it {should belong_to :patient}
  end

  before(:all) do
    DoctorPatient.delete_all
    Doctor.delete_all
    Hospital.delete_all
    Patient.delete_all
    @hospital = Hospital.create!(name: "Prolong Life Med")
    @doctor = @hospital.doctors.create!(name: "Jaymie Wagner", specialty: "Family Med", university: "Trinity")
    @patient = Patient.create!(name: "Jim Bob", age: 46)
    @doc_patient = DoctorPatient.create!(doctor_id: @doctor.id, patient_id: @patient.id)
  end

  it 'has a method to find an instance of itself based on doc/patient ids' do
    expect(DoctorPatient.find_by_doc_patient(@doctor.id, @patient.id)).to eq(@doc_patient)
  end


end