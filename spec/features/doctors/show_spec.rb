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
    DoctorPatient.create!(doctor_id: @doctor2.id, patient_id: @patient2.id)
  end

  describe "User Story 1" do
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

  describe "User Story 2" do
    it 'has buttons to remove patients from that doctors care' do
      visit doctor_path(@doctor.id)

      within "#patient_id-#{@patient.id}" do
        expect(page).to have_button("Remove Patient")
      end
      
      within "#patient_id-#{@patient2.id}" do
        expect(page).to have_button("Remove Patient")
      end
    end

    it 'deletes that patient from that doctor when pressed' do
      visit doctor_path(@doctor.id)

      within "#patient_id-#{@patient2.id}" do
        click_button "Remove Patient"
      end

      expect(current_path).to eq(doctor_path(@doctor.id))
      expect(page).to_not have_content(@patient2.name)
    end

    it 'does not effect doctor/patient relations for other doctors' do
      visit doctor_path(@doctor2.id)

      within "#patient_id-#{@patient2.id}" do
        click_button "Remove Patient"
      end

      visit doctor_path(@doctor.id)

      within "#patient_id-#{@patient2.id}" do
        expect(page).to have_content(@patient2.name)
      end
    end
  end
end