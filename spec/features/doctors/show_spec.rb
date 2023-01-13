require 'rails_helper'

RSpec.describe 'doctor show page' do
  before(:all) do
    DoctorPatient.delete_all
    Doctor.delete_all
    Hospital.delete_all
    
    Patient.delete_all
    @hospital = Hospital.create!(name: "Prolong Life Med")
    @doctor = @hospital.doctors.create!(name: "Jaymie Wagner", specialty: "Family Med", university: "Trinity")
    @doctor2 = @hospital.doctors.create!(name: "Becca Pratt", specialty: "Neurology", university: "Trinity")
    @patient = @doctor.patients.create!(name: "Jim Bob", age: 46)
    @patient2 = @doctor.patients.create!(name: "James Robert", age: 29)
    @patient3 = @doctor2.patients.create!(name: "Jimmy Bobby", age: 9)

  end

  it 'displays the doctors information and all their patients' do
    visit doctor_path(@doctor.id)

    expect(page).to have_content(@doctor.name)
    expect(page).to have_content(@doctor.specialty)
    expect(page).to have_content(@doctor.university)
    expect(page).to have_content(@doctor.hospital.name)
    expect(page).to_not have_content(@doctor2.name)

    within "#patients" do
      expect(page).to have_content(@patient.name)
      expect(page).to have_content(@patient2.name)
      expect(page).to_not have_content(@patient3.name)
    end


  end


end