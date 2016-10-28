module RGFA::Field::AlignmentGFA1

  def decode(string)
    string.to_cigar
  end

  def unsafe_decode(string)
    string.to_cigar(valid: true)
  end

  def validate_encoded(string)
    if string !~ /^(\*|([0-9]+[MIDNSHPX=])+)$/
      raise RGFA::FormatError,
        "#{string.inspect} is not a valid GFA1 alignment\n"+
        "(it is not * and is not a CIGAR string (([0-9]+[MIDNSHPX=])+)"
    end
  end

  def validate_decoded(cigar)
    cigar.validate!
  end

  def validate(object)
    case object
    when String
      validate_encoded(object)
    when RGFA::CIGAR
      validate_decoded(object)
    when RGFA::Placeholder
    else
      raise RGFA::TypeError,
        "the class #{object.class} is incompatible with the datatype\n"+
        "(accepted classes: String, RGFA::CIGAR, RGFA::Placeholder)"
    end
  end

  def unsafe_encode(object)
    object.to_s
  end

  def encode(object)
    case object
    when String
      validate_encoded(object)
      return object
    when RGFA::CIGAR
      object.validate!
      return object.to_s
    when RGFA::Placeholder
      return object.to_s
    else
      raise RGFA::TypeError,
        "the class #{object.class} is incompatible with the datatype\n"+
        "(accepted classes: String, RGFA::CIGAR, RGFA::Placeholder)"
    end
  end

  module_function :decode
  module_function :unsafe_decode
  module_function :validate_encoded
  module_function :validate_decoded
  module_function :validate
  module_function :unsafe_encode
  module_function :encode

end