# A gap line of a GFA2 file
class RGFA::Line::Gap < RGFA::Line

  RECORD_TYPE = :G
  POSFIELDS = [:gid, :sid1, :sid2, :disp, :var]
  FIELD_ALIAS = { :name => :gid }
  PREDEFINED_TAGS = []
  DATATYPE = {
    :gid => :optional_identifier_gfa2,
    :sid1 => :oriented_identifier_gfa2,
    :sid2 => :oriented_identifier_gfa2,
    :disp => :i,
    :var => :optional_integer
  }
  REFERENCE_FIELDS = [:sid1, :sid2]
  REFERENCE_RELATED_FIELDS = []
  DEPENDENT_LINES = [:unordered_groups, :ordered_groups]
  OTHER_REFERENCES = []

  define_field_methods

  alias_method :to_sym, :gid

end

require_relative "gap/references.rb"

class RGFA::Line::Gap
  include RGFA::Line::Gap::References
end
