import gfapy

class Finders:
  def segment(self, s):
    if isinstance(s, gfapy.Line):
      return s
    else:
      return self._records["S"][s]

  def try_get_segment(self, s):
    seg = self.segment(s)
    if seg == None:
      raise gfapy.NotFoundError("No segment has name {}".format(s))
      # TODO: output segment names list (shortened to 10 elements)
    else:
      return seg

  RECORDS_WITH_NAME = ["E", "S", "P", "U", "G", "O", None]

  def line(self, l):
    if gfapy.is_placeholder(l):
      return None
    elif isinstance(l, gfapy.Line):
      return l
    elif isinstance(l, str):
      return self.__line_by_name(l)
    else:
      return None

  def try_get_line(self, l):
    gfa_line = self.line(l)
    if gfa_line == None:
      if is_placeholder(l):
        raise gfapy.ValueError(
          "'*' is a placeholder and not a valid name for a line")
      else:
        raise gfapy.NotFoundError(
            "No line found with ID {}".format(l))

  def fragments_for_external(self, external_id):
    return self._records["F"].get(external_id,[])

  def select(self, dict_or_line):
    is_dict = isinstance(dict_or_line, dict)
    name = dict_or_line["name"] if is_dict else hash_or_line.get("name")
    if name is not None and not is_placeholder(name):
      collection = [self.__line_by_name(name)]
    else:
      if is_dict:
        record_type = dict_or_line["record_type"]
      else:
        record_type = dict_or_line.record_type
      collection = self.__collection_for_select(record_type)
    method = "_has_field_values" if dict_or_line else "_has_eql_fields"
    return [line for line in collection \
        if line.get_attr(method)(dict_or_line, ["record_type","name"])]

  def _search_duplicate(self, gfa_line):
    if gfa_line.record_type == "L":
      return self._search_link(gfa_line.oriented_from, gfa_line.oriented_to,
                               gfa_line.alignment)
    elif gfa_line.record_type in self.RECORDS_WITH_NAME:
      return self.line(gfa_line.name)
    else:
      return None

  def _search_link(self, orseg1, orseg2, cigar):
    s = self.segment(orseg1.line)
    if s is None:
      return None
    for l in s.dovetails():
      if isinstance(l, gfapy.line.edge.Link) and \
          l.is_compatible(orseg1, orseg2, cigar, True):
        return l
    return None

  def __line_by_name(self, name):
    for rt in self.RECORDS_WITH_NAME:
      if rt not in self._records:
        next
      found = self._records[rt].get(name, None)
      if found is not None:
        return found
    return None

  def __collection_for_select(self, record_type):
    if record_type is None:
      return self.lines
    else:
      d = self._records[record_type]
      if record_type == "S" or record_type == "P":
        return list(d.values())
      elif record_type in ["E", "G", "U", "O", "F"]:
        return [v for k,v in d.items() if k is not None] + d[None]
      else:
        return d