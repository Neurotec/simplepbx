xml.configuration name: 'callcenter.conf', description: 'Callcenter SimplePBX' do
  xml.settings do
    xml.param name: 'dbname', value: "$${db_dir}/#{@freeswitch.name}.db"
  end

  xml.queues do
    @freeswitch.callcenter_queues.each do |queue|
      xml.queue name: queue.uuid do
        xml.param name: 'strategy', value: queue.strategy
        xml.param name: 'moh-sound', value: queue.profile.moh_sound
        xml.param name: 'time-base-score', value: queue.profile.time_base_score
        xml.param name: 'tier-rules-apply', value: queue.profile.tier_rules_apply
        xml.param name: 'tier-rule-wait-second', value: queue.profile.tier_rule_wait_second
        xml.param name: 'tier-rule-no-agent-no-wait', value: queue.profile.tier_rule_no_agent_no_wait
        xml.param name: 'discard-abandoned-after', value: queue.profile.discard_abandoned_after
        xml.param name: 'abandoned-resume-allowed', value: queue.profile.abandoned_resume_allowed
        xml.param name: 'max-wait-time', value: queue.profile.max_wait_time
        xml.param name: 'max-wait-time-with-no-agent', value: queue.profile.max_wait_time_with_no_agent
      end
    end
  end

  xml.agents do
    @freeswitch.callcenter_queues.each do |queue|
      queue.tiers.each do |tier|
        next unless tier.extension.present?
        contact = "[origination_caller_id_name='#{queue.name}',leg_timeout=15]user/#{tier.extension.contact}"
        xml.agent :name => "#{tier.extension.contact}", contact: contact, :type => 'callback', :status => 'Available',
                  "max-no-answer" => 3, "wrap-up-time" => 10, "reject-delay-time" => 10,
                  "busy-delay-time" => 60
      end
    end
  end

  xml.tiers do
    @freeswitch.callcenter_queues.each do |queue|
      queue.tiers.each do |tier|
        next unless tier.extension.present?
        xml.tier agent: "#{tier.extension.contact}", queue: queue.uuid, level: tier.level, position: tier.position
      end
    end
  end

end
