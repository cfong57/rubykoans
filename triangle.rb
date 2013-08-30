# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  temp = [a, b, c]
  if(temp.include?(0))
    raise TriangleError.new("Side length of 0")
  end
  temp.each do |side|
    if(side != side.abs)
      raise TriangleError.new("Negative side length")
    end
  end
  perms = temp.permutation(3)
  perms.each do |sides|
    if((sides[0] + sides[1]) <= sides[2])
      raise TriangleError.new("Impossible triangle dimensions")
    end
  end

  temp.uniq!
  if(temp.length == 3)
    return :scalene
  elsif(temp.length == 2)
    return :isosceles
  else
    return :equilateral
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end