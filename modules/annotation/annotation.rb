require "minitest/autorun"

module Annotations
  def annotations(meth=nil)
    return @__annotations__[meth] if meth
    @__annotations__
  end

  private

  def method_added(m)
    (@__annotations__ ||= {})[m] = @__last_annotation__ if @__last_annotation__
    @__last_annotation__ = nil
    super
  end

  def method_missing(meth, *args)
    return super unless /^__anno__/ =~ meth
    @__last_annotation__ ||= {}
    @__last_annotation__[meth[8..-1].to_sym] = args.size == 1 ? args.first : args
  end
end

# class Module
#   private
#
#   def annotate!
#     extend Annotations
#   end
# end
#
# class A
#   annotate!
#
#   _hello   color: 'red',   ancho:   23
#   _goodbye color: 'green', alto:  -123
#   _foobar  color: 'blew'
#   def m1; end
#
#   def m2; end
#
#   _foobar  color: 'cyan'
#   def m3; end
# end
#

# puts  A.annotations(:m1)[:hello][:color]
# puts  A.annotations[:m3][:foobar][:color]
# puts  A.annotations


class TT
  #annotate!
  extend Annotations

  __anno__anots color:"1"
  def bb

  end

end

puts TT.annotations