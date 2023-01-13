class DoctorPatientsController < ApplicationController
  def destroy
    @doctor = Doctor.find(params[:doctor_id])
    doctor_patient = DoctorPatient.find_by_doc_patient(params[:doctor_id], params[:patient_id])
    doctor_patient.destroy
    redirect_to doctor_path(@doctor.id)
  end


end