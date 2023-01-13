require 'rails_helper'

RSpec.describe "hospital show page" do
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
    @patient3 = @doctor2.patients.create!(name: "Jimmy Bobby", age: 9)
    DoctorPatient.create!(doctor_id: @doctor2.id, patient_id: @patient2.id)
    @patient4 = @doctor.patients.create!(name: "some guy", age: 45)
    @patient5 = @doctor3.patients.create!(name: "some other guy", age: 19)
    @patient6 = @doctor.patients.create!(name: "wow, another guy", age: 45)
  end

  describe "Extension User Story" do
    it 'displays the hospital name' do
      visit hospital_path(@hospital.id)

      expect(page).to have_content(@hospital.name)
    end

    it 'lists doctors in order by number of patients, and displays that value next to their name' do
      visit hospital_path(@hospital.id)

      within "#doctors" do
        expect(page).to have_content("Doctors Employed:")
        expect(page).to have_css("#doctor_id-#{@doctor.id} ~ #doctor_id-#{@doctor2.id}")
        expect(page).to have_css("#doctor_id-#{@doctor2.id} ~ #doctor_id-#{@doctor3.id}")
        expect(page).to_not have_css("#doctor_id-#{@doctor3.id} ~ #doctor_id-#{@doctor.id}")
      end

      within "#doctor_id-#{@doctor.id}" do
        expect(page).to have_content("Patients: 4")
      end

      within "#doctor_id-#{@doctor2.id}" do
        expect(page).to have_content("Patients: 2")
      end

      within "#doctor_id-#{@doctor3.id}" do
        expect(page).to have_content("Patients: 1")
      end
    end
  end
end