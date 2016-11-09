RGFA::Line::Edge::Common ||= Module.new

# Methods regarding the ends (from/to) of a GFA1 link/containment
#
# Requirements: +from+, +from_orient+, +to+, +to_orient+.
module RGFA::Line::Edge::Common::FromTo

  # @return [Boolean] is the from and to segments are equal
  def circular?
    from.to_sym == to.to_sym
  end

  # @return [Boolean] is the from and to segments are equal
  def circular_same_end?
    from_end == to_end
  end

  # @return [RGFA::OrientedSegment] the oriented segment represented by the
  #   from/from_orient fields
  def oriented_from
    [from, from_orient].to_oriented_segment
  end

  # @return [RGFA::OrientedSegment] the oriented segment represented by the
  #   to/to_orient fields
  def oriented_to
    [to, to_orient].to_oriented_segment
  end

  # @return [RGFA::SegmentEnd] the segment end represented by the
  #   from/from_orient fields
  def from_end
    [from, from_orient == :+ ? :E : :B].to_segment_end
  end

  # @return [RGFA::SegmentEnd] the segment end represented by the
  #   to/to_orient fields
  def to_end
    [to, to_orient == :+ ? :B : :E].to_segment_end
  end

  # Signature of the segment ends, for debugging
  # @api private
  def segment_ends_s
    [from_end.to_s, to_end.to_s].join("---")
  end

  # @param segment_end [RGFA::SegmentEnd] one of the two segment ends
  #   of the line
  # @return [RGFA::SegmentEnd] the other segment end
  # @raise [RGFA::ArgumentError] if segment_end is not a valid segment end
  #   representation
  # @raise [RuntimeError] if segment_end is not a segment end of the line
  def other_end(segment_end)
    segment_end = segment_end.to_segment_end
    if (from_end == segment_end)
      return to_end
    elsif (to_end == segment_end)
      return from_end
    else
      raise RGFA::ArgumentError,
        "Segment end '#{segment_end.inspect}' not found\n"+
            "(from=#{from_end.inspect};to=#{to_end.inspect})"
    end
  end

  # The from segment name, in both cases where from is a segment name (Symbol)
  # or a segment (RGFA::Line::Segment::GFA1)
  # @return [Symbol]
  def from_name
    from.to_sym
  end

  # The to segment name, in both cases where to is a segment name (Symbol)
  # or a segment (RGFA::Line::Segment::GFA1)
  # @return [Symbol]
  def to_name
    to.to_sym
  end

  # The other segment of a connection line
  # @param segment [RGFA::Line::Segment::GFA1, Symbol] segment name or instance
  # @raise [RGFA::NotFoundError]
  #   if segment is not involved in the connection
  # @return [Symbol] the name of the other segment of the connection
  #   if circular, then +segment+
  def other(segment)
    segment_name =
      (segment.kind_of?(RGFA::Line) ? segment.name : segment.to_sym)
    if segment_name == from.to_sym
      to
    elsif segment_name == to.to_sym
      from
    else
      raise RGFA::NotFoundError,
        "Line #{self} does not involve segment #{segment_name}"
    end
  end

end