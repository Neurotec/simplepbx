class NameValidator < ActiveModel::EachValidator
   def validate_each(record, attribute, value)
     unless value =~ /\A([a-zA-Z0-9_])+\z/
       record.errors[attribute] << (options[:message] || "is invalid")
    end
  end
end
