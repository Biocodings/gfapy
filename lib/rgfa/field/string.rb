module RGFA::Field::String

  def decode(string)
    validate_encoded(string)
    string
  end

  def unsafe_decode(string)
    string
  end

  def validate_encoded(string)
    if string !~ /^[ !-~]+$/
      raise RGFA::FormatError,
        "#{string.inspect} is not a valid string field\n"+
        "(it contains newlines/tabs and/or non-printable characters)"
    end
  end

  alias_method :validate_decoded, :validate_encoded

  def validate(object)
    case object
    when String, Symbol
      validate_encoded(object)
    else
      raise RGFA::TypeError,
        "the class #{object.class} is incompatible with the datatype\n"+
        "(accepted classes: String, Symbol)"
    end
  end

  def unsafe_encode(object)
    object.to_s
  end

  def encode(object)
    case object
    when String
    when Symbol
      object = object.to_s
    else
      raise RGFA::TypeError,
        "the class #{object.class} is incompatible with the datatype\n"+
        "(accepted classes: String, Symbol)"
    end
    validate_encoded(object)
    return object
  end

  module_function :decode
  module_function :unsafe_decode
  module_function :validate_encoded
  module_function :validate_decoded
  module_function :unsafe_encode
  module_function :encode

end
