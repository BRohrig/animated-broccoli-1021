require 'rails_helper'

RSpec.describe Doctor do
  it {should belong_to :hospital}
  it {should have_many(:doctor_patients)}
  it {should have_many(:patients).through(:doctor_patients)}
  
  before(:all) do
    DoctorPatient.delete_all
    Doctor.delete_all
    Hospital.delete_all
    Patient.delete_all
    @hospital = Hospital.create!(name: "Prolong Life Med")
    @doctor = @hospital.doctors.create!(name: "Jaymie Wagner", specialty: "Family Med", university: "Trinity")
    @doctor2 = @hospital.doctors.create!(name: "Becca Pratt", specialty: "Neurology", university: "Trinity")
    @doctor3 = @hospital.doctors.create!(name: "Anitesh Jaswal", specialty: "Radiology", university: "Trinity")
    @patient = @doctor.patients.create!(name: "Jim Bob", age: 46)
    @patient2 = @doctor.patients.create!(name: "James Robert", age: 29)
    @patient3 = @doctor.patients.create!(name: "Jimmy Bobby", age: 9)
    DoctorPatient.create!(doctor_id: @doctor2.id, patient_id: @patient2.id)
    @patient4 = @doctor.patients.create!(name: "some guy", age: 45)
    @patient5 = @doctor3.patients.create!(name: "some other guy", age: 19)
    @patient6 = @doctor3.patients.create!(name: "wow, another guy", age: 45)
  end

  it 'has a method to sort by number of patients descending' do
    expect(Doctor.patient_count_sort).to eq([@doctor, @doctor3, @doctor2])
  end

  it 'has a method to count patients' do
    expect(@doctor.patient_count).to eq(4)
    expect(@doctor2.patient_count).to eq(1)
    expect(@doctor3.patient_count).to eq(2)
  end
end
