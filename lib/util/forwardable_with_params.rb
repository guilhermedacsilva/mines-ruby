module GameMines
  # Creates forwardable methods with fixed params
  # Can create without params too.
  module ForwardableWithParams
    # instance: caller
    # method_name: will be called
    # new_method_name: the new method created
    # params: can be a value or an array. It is optional.
    def def_delegator_with_params(
      instance, method_name, new_method_name, params = []
    )
      params = [params] unless params.is_a? Array
      class_eval "
        def #{new_method_name}
          #{instance}.#{method_name}(#{params.join(',')})
        end
      "
    end
  end
end
