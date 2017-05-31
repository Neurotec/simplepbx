require 'open3'
require 'shellwords'

class CdrController < ApplicationController
  skip_before_action :authenticate_user!, only: [:play]
  skip_before_action :verify_authenticity_token, only: [:play]
  def index
    authorize! :read, :cdr
    
    if session[:cdr_where]
      where = session[:cdr_where]
      @cdr = Cdr.new(where)
    else
      where = {freeswitch_id: Freeswitch.from_user(current_user).pluck(:id)}
      @cdr = Cdr.new
    end
    @cdrs = Cdr.where(where).order(created_at: :desc).page(params[:page])
  end

  def search
    authorize! :read, :cdr
    @cdr = Cdr.new(params.require(:cdr).permit(:caller_id_name, :caller_id_number, :destination_number))
    where = {freeswitch_id: Freeswitch.from_user(current_user).pluck(:id)}

    [:destination_number, :caller_id_name, :caller_id_number].each do |field|
      if @cdr.attribute_present?(field)
        where[field] = @cdr.send(field)
      end
    end
    session[:cdr_where] = where
    @cdrs = Cdr.where(where).order(created_at: :desc).page(params[:page])
    render 'index'
  end

  def play
    authorize! :read, :cdr_recording
    cdr = Cdr.where(freeswitch_id: Freeswitch.from_user(current_user).pluck(:id)).find(params[:id])
    record_pem_path = Shellwords.shellescape(cdr.freeswitch.record_pem_path)
    record_path = Shellwords.shellescape(cdr.record_path)
    cmd = "ssh -q  -o StrictHostKeyChecking=no -l #{cdr.freeswitch.record_public_user} -i #{record_pem_path} #{cdr.freeswitch.host} '#{record_path}'"
    puts cmd
    headers["Content-Type"] = "audio/x-wav"
    headers["Cache-Control"] = "no-cache"
    headers.delete("Content-Length")
    response.status = 200

    stdin, stdout, wait_thr = Open3.popen2(cmd)
    self.response_body = stdout
  end

end
