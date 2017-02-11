class FreeswitchConfiguratorController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  layout 'response'

  def configuration
    @section_name = "configuration"

    @freeswitch = authenticate_freeswitch()
    
    if !@freeswitch.nil?
      case configuration_params['section']
      when 'configuration'
        case configuration_params['key_value']
        when 'ivr.conf'
          configuration_ivr
        when 'callcenter.conf'
          configuration_cc
        when 'json_cdr.conf'
          configuration_json_cdr
        when 'acl.conf'
          configuration_acl
        when 'sofia.conf'
          configuration_sofia
        else
          render_invalid_response("invalid section")
        end
      else
        render_invalid_response("invalid freeswitch")
      end
    else
      render_invalid_response("not found")
    end
  end

  def dialplan
    @section_name = 'dialplan'
    @freeswitch = authenticate_freeswitch()
    if !@freeswitch.nil?
      if params.permit!["Event-Name"] == "REQUEST_PARAMS"
        render 'dialplan', formats: :xml
      else
        render_invalid_response("not found")
      end
    else
      render_invalid_response('not found')
    end
  end

  def directory
    @section_name = 'directory'
    @freeswitch = authenticate_freeswitch()
    if !@freeswitch.nil?
      if configuration_params['purpose'] == 'gateways'
        render_invalid_response('not implemented')
      elsif configuration_params['Event-Name'] == 'REQUEST_PARAMS' and configuration_params['section'] == 'directory' and configuration_params['tag_name'] = 'domain'
        if configuration_params['key_name'] == 'name'
          @endpoint = Endpoint.find_by(freeswitch_id: @freeswitch.id, domain: configuration_params['key_value'])
          unless @endpoint.nil?
            render 'extensions', formats: :xml
          else
            render_invalid_response('invalid domain')
          end
        else
          render_invalid_response('invalid domain')
        end
      else
        render_invalid_response('invalid params')
      end
    else
      render_invalid_response('not found')
    end
  end


  def configuration_ivr
    render 'ivr', formats: :xml
  end
  
  def configuration_cc
    render 'callcenter', formats: :xml
  end
  
  def configuration_json_cdr
    render 'json_cdr', formats: :xml
  end

  def configuration_acl
    render 'acl', formats: :xml
  end
  
  def configuration_sofia
    render 'sofia', formats: :xml
  end

  def json_cdr
    @freeswitch = authenticate_freeswitch()

    variables = params.require(:variables).permit!.to_h
    callflow = params.require(:callflow).first
    caller_profile = callflow["caller_profile"].permit!.to_h

    destination_number = caller_profile["destination_number"].to_s
    caller_id_number = caller_profile["caller_id_number"].to_s
    caller_id_name = caller_profile["caller_id_name"].to_s
    duration = variables["duration"].to_i
    hangup_cause_q850 = variables["hangup_cause_q850"].to_i
    hangup_cause = variables["hangup_cause"]
    start_epoch = variables["start_epoch"].to_i
    record_path = if variables['record_seconds'].to_i > 0
                    variables["recording_path"].to_s
                  else
                    ""
                  end

    is_loopback = false if variables["is_loopback"].to_s.empty?
    is_loopback = true unless variables["is_loopback"].to_s.empty?

    if variables["direction"] == "inbound" 
      File.write("/tmp/json_cdr", request.raw_post)
      Cdr.create!(freeswitch_id: @freeswitch.id,
                  caller_id_name: caller_id_name,
                  caller_id_number: caller_id_number,
                  destination_number: destination_number,
                  duration: duration,
                  hangup_cause_q850: hangup_cause_q850,
                  start_epoch: start_epoch,
                  hangup_cause: hangup_cause,
                  record_path: record_path
                 )
    end

  end

  private
  def render_invalid_response(msg)
    @section_name = 'result'
    @msg = msg
    render 'invalid_response', formats: :xml
  end

  def authenticate_freeswitch
    Freeswitch.where(host: request.remote_ip).first
  end
  
  def configuration_params
    params.permit(:section, :key_value, :purpose, :sip_auth_method, :tag_name, :name, :key_name, :key_value, 'Event-Name')
  end
end
