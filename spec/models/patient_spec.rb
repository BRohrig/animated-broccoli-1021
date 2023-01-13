require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe "relationships" do
    it {should have_many(:doctor_patients)}
    it {should have_many(:doctors).through(:doctor_patients)}
    it {should have_many(:hospitals).through(:doctors)}
  end

  before(:all) do
    DoctorPatient.delete_all
    Patient.delete_all
    @patient = Patient.create!(name: "Jim Bob", age: 46)
    @patient2 = Patient.create!(name: "James Robert", age: 29)
    @patient3 = Patient.create!(name: "Jimmy Bobby", age: 9)
    @patient4 = Patient.create!(name: "William Rutherford", age: 7)
    @patient5 = Patient.create!(name: "Aaron Burr", age: 256)
  end

  it 'has a method to find adult instances of itself in alphabetical order' do
    expect(Patient.adult_patients_alpha).to eq([@patient5, @patient2, @patient])
  end

end