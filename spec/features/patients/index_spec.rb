require 'rails_helper'

RSpec.describe "patient index page" do
  before(:all) do
    @patient = Patient.create!(name: "Jim Bob", age: 46)
    @patient2 = Patient.create!(name: "James Robert", age: 29)
    @patient3 = Patient.create!(name: "Jimmy Bobby", age: 9)
    @patient4 = Patient.create!(name: "William Rutherford", age: 97)
    @patient5 = Patient.create!(name: "Aaron Burr", age: 256)
  end

  describe "User Story 3" do
    it 'lists all adult patients (over 18)' do
      visit patients_path

      within "#adult_patients" do
        expect(page).to have_content(@patient.name)
        expect(page).to have_content(@patient2.name)
        expect(page).to_not have_content(@patient3.name)
        expect(page).to have_content(@patient4.name)
        expect(page).to have_content(@patient5.name)
      end
    end

    it 'lists the names in alphabetical order (A-Z)' do
      visit patients_path

      within "#adult_patients" do
        expect(page).to have_css("#patient_id-#{@patient5.id} ~ #patient_id-#{@patient2.id}")
        expect(page).to have_css("#patient_id-#{@patient2.id} ~ #patient_id-#{@patient.id}")
        expect(page).to have_css("#patient_id-#{@patient.id} ~ #patient_id-#{@patient4.id}")
        expect(page).to_not have_css("#patient_id-#{@patient4.id} ~ #patient_id-#{@patient5.id}")
        expect(page).to_not have_css("#patient_id-#{@patient.id} ~ #patient_id-#{@patient2.id}")
      end
    end
  end
end