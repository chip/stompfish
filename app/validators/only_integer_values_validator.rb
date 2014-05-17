class OnlyIntegerValuesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.reject { |id| id.kind_of?(Fixnum) }.empty?
      record.errors[attribute] << "must be integer values"
    end
  end
end
