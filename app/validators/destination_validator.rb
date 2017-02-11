class DestinationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if (value =~ /\A\^?[\(a-zA-Z0-9_\\+\*\.)]+\$?\z/).nil?
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end
end
