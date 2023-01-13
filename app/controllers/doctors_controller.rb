class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find(params[:id])
    @patients = @doctor.patients
  end



end