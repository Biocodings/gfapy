class ToGFA2:

  @property
  def from_coords(self):
    """
    GFA2 positions of the alignment on the **from** segment.

    Returns
    -------
    (Integer|Lastpos,Integer|Lastpos)
    	begin and end

    Raises
    ------
    gfapy.ValueError
    	If the overlap is not specified.
    gfapy.RuntimeError
    	If the segment length cannot be determined, because the segment line is unknown.
    gfapy.ValueError
    	If the segment length is not specified in the segment line.
    """
    self.check_overlap()
    if from_orient == "+":
      from_l = self.lastpos_of("from")
      return [from_l - self.overlap.length_on_reference, from_l]
    else:
      return [0, self.overlap.length_on_reference]

  @property
  def to_coords(self):
    """
    GFA2 positions of the alignment on the **to** segment.
    """
    self.check_overlap()
    if to_orient == "+":
      return [0, self.overlap.length_on_query]
    else:
      to_l = lastpos_of("to")
      return [to_l - self.overlap.length_on_query, to_l]