Placeholders
------------

Some positional fields may contain an undefined value S: ``sequence``;
L/C: ``overlap``; P: ``overlaps``; E: ``eid``, ``alignment``; F:
``alignment``; G: ``gid``, ``var``; U/O: ``pid``. In GFA this value is
represented by a ``*``.

In Gfapy the class Placeholder represent the undefined value.

Distinguishing placeholders
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The method \`\`\`gfapy.is\_placeholder()\`\`\`\` checks if a value is or
would be represented by a placeholder in GFA (such as an empty array, or
a string containing "\*").

.. code:: python

    gfapy.is_placeholder("*") # => True
    gfapy.is_placeholder("**") # => False
    gfapy.is_placeholder([]) # => True
    gfapy.is_placeholder(gfapy.Placeholder()) # => True

Note that, as a placeholder is False in boolean context, just a
``if not placeholder`` will also work, if placeholder is a
gfa.Placeholder() but not if it is a string representation.

Compatibility methods
~~~~~~~~~~~~~~~~~~~~~

Some methods are defined for placeholders, which allow them to respond
to the same methods as defined values. This allows to write generic
code.

.. code:: python

    placeholder.validate() # does nothing
    len(placeholder) # => 0
    placeholder[1] # => gfapy.Placeholder()
    placeholder + anything # => gfapy.Placeholder()