class Hash
  # allow to pass multiple keys, useful for nested hashes.
  # Ex: h = { :a => { :b => { :c => 42 } } }
  # h.r(:a, :b, :c) => 42
  def r(*args)
    v = self[args.shift]
    if args.empty?
      v
    elsif v.is_a?(Hash)
      v.r(*args)
    else
      nil
    end
  end
end
