class HostValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([a-zA-Z0-9_.]+)|(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\z/
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end
end
