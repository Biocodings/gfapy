module RGFA::Field::Comment

  def unsafe_decode(string)
    string
  end

  def decode(string)
    validate_encoded(string)
    string
  end

  def validate_encoded(string)
    if string.index("\n")
      raise RGFA::FormatError
        "#{string.inspect} is not a single-line string"
    end
  end

  alias_method :validate_decoded, :validate_encoded

  def unsafe_encode(object)
    object.to_s
  end

  def encode(object)
    case object
    when String
      validate_encoded(object)
      return object
    else
      raise RGFA::TypeError,
        "the class #{object.class} is incompatible with the datatype\n"+
        "(accepted classes: String)"
    end
  end

  module_function :decode
  module_function :unsafe_decode
  module_function :validate_encoded
  module_function :validate_decoded
  module_function :unsafe_encode
  module_function :encode

end
