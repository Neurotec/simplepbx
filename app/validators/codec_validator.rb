class CodecValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A((pcmu|pcma|g729|opus|ilbc),?)+\z/i
      record.errors[attribute] << (options[:message] || "allowed PCMU,PCMA,G729,OPUS,iLBC")
    end
  end
end
