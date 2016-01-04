#encoding:utf-8

=begin
 给ruby加上像java的annotation
=end
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
    return super unless /\^__annotation__/ =~ meth
    @__last_annotation__ ||= {}
    @__last_annotation__[meth[1..-1].to_sym] = args.size == 1 ? args.first : args
  end
end

class Module
  private

  def annotate!

  end
end

class TestAnnoation
  include Annotations

end